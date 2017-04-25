using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SmartCode
{
    public partial class Items : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BindGrid();

            if (!IsAdmin())
            {
                try
                {
                    ((DataControlField)ProductGridView.Columns
                       .Cast<DataControlField>()
                       .Where(fld => (fld.HeaderText == "Edit"))
                       .SingleOrDefault()).Visible = false;
                }
                catch(Exception)
                {

                }
            }
        }

        void Page_PreInit(object sender, EventArgs e)
        {
            if (IsAdmin())
            {
                MasterPageFile = "~/Admin.master";
            }
            else
            {
                MasterPageFile = "~/User.master";
            }
        }

        public bool IsAdmin()
        {
            Security state = (Security)Application["User"];
            if (state != null)
            {
                if (((Security)Application["User"]).UserLevel == "Admin")
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                Context.GetOwinContext().Authentication.SignOut();
                Response.Redirect("Login.aspx");
                return false;
            }
        }

        private void BindGrid()
        {
            SmartCodeDataContext db = new SmartCodeDataContext();
            var items = db.GetAllProductDetails();
            DataTable dataTable = new DataTable(typeof(GetAllProductDetailsResult).Name);
            PropertyInfo[] Props = typeof(GetAllProductDetailsResult).GetProperties(BindingFlags.Public | BindingFlags.Instance);
            foreach (PropertyInfo prop in Props)
            {
                //Defining type of data column gives proper data table 
                var type = (prop.PropertyType.IsGenericType && prop.PropertyType.GetGenericTypeDefinition() == typeof(Nullable<>) ? Nullable.GetUnderlyingType(prop.PropertyType) : prop.PropertyType);
                //Setting column names as Property names
                dataTable.Columns.Add(prop.Name, type);
            }
            foreach (GetAllProductDetailsResult item in items)
            {
                var values = new object[Props.Length];
                for (int i = 0; i < Props.Length; i++)
                {
                    //inserting property values to datatable rows
                    values[i] = Props[i].GetValue(item, null);
                }
                dataTable.Rows.Add(values);
            }

            DataView dataView = dataTable.DefaultView;
            ProductGridView.DataSource = dataView;
            ProductGridView.DataBind();
            BindData();
        }

        protected void ProductGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["OnClick"] = Page.ClientScript.GetPostBackClientHyperlink(ProductGridView, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
            }
        }

        protected void OnClickAddProduct(object sender, EventArgs e)
        {
            Response.Redirect("AddNewItem.aspx");
        }

        protected void ProductGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridViewRow row in ProductGridView.Rows)
            {
                if (row.RowIndex == ProductGridView.SelectedIndex)
                {
                    row.BackColor = ColorTranslator.FromHtml("#A1DCF2");
                    row.ToolTip = string.Empty;
                }
                else
                {
                    row.BackColor = ColorTranslator.FromHtml("#FFFFFF");
                    row.ToolTip = "Click to select this row.";
                }
            }
            GridView gridView = sender as GridView;
            DataView view = gridView.DataSource as DataView;
            DataRowView selectedRow = view[ProductGridView.SelectedIndex];

            Response.Redirect("ViewItem.aspx?ID=" + this.ProductGridView.DataKeys[this.ProductGridView.SelectedRow.RowIndex].Value.ToString());
        }

        protected void ProductGridView_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.originalstyle=this.style.backgroundColor;this.style.backgroundColor='#EEFFAA';this.style.cursor='pointer'");
                e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=this.originalstyle;");
            }
        }

        protected void ProductGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            ProductGridView.PageIndex = e.NewPageIndex;
            ProductGridView.DataBind();
        }

        protected void ProductGridView_Sorting(object sender, GridViewSortEventArgs e)
        {
            BindData();

            DataView view = ProductGridView.DataSource as DataView;

            if (view != null)
            {
                //Sort the data.
                view.Sort = e.SortExpression + (string)((e.SortDirection == SortDirection.Ascending) ? " ASC" : " DESC");

                Session["sort"] = view.Sort;
                ProductGridView.DataSource = view;
                ProductGridView.DataBind();
            }
        }

        private void BindData()
        {
            DataView view = ProductGridView.DataSource as DataView;

            if (view != null)
            {
                if (Session["sort"] != null)
                {
                    //Sort the data.
                    view.Sort = Session["sort"].ToString();
                }

                ProductGridView.DataSource = view;
                ProductGridView.DataBind();
            }
        }

        protected void ProductGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "EditProduct":
                    {
                        GridViewRow clickedRow = ((LinkButton)e.CommandSource).NamingContainer as GridViewRow;
                        ProductGridView.EditIndex = clickedRow.RowIndex;

                        DataKey rowKeys = ProductGridView.DataKeys[clickedRow.RowIndex];
                        int productId = (int)rowKeys["ProductId"];
                        Response.Redirect("EditItem.aspx?ID=" + productId);
                    }
                    break;

                case "DeleteProduct":
                    {
                        GridViewRow clickedRow = ((LinkButton)e.CommandSource).NamingContainer as GridViewRow;
                        ProductGridView.EditIndex = clickedRow.RowIndex;

                        DataKey rowKeys = ProductGridView.DataKeys[clickedRow.RowIndex];
                        int productId = (int)rowKeys["ProductId"];
                        DeleteItem(productId);
                    }
                    break;
            }
        }

        private void DeleteItem(int itemId)
        {
            SmartCodeDataContext db = new SmartCodeDataContext();
            var remove = (from aremove in db.Products
                          where aremove.ProductId == itemId
                          select aremove).FirstOrDefault();

            GetProductResult prod = (GetProductResult)db.GetProduct(itemId).Single();

            var location = (from aremove in db.Locations
                            where aremove.ProductId == itemId
                            select aremove).FirstOrDefault();

            if (remove != null)
            {
                db.Locations.DeleteOnSubmit(location);
                db.Products.DeleteOnSubmit(remove);
                db.SubmitChanges();
                WriteToLog(itemId, prod.Description, prod.Barcode, "DEL", prod.Quantity, null, prod.BinLocation, null);
            }
            Server.TransferRequest(Request.Url.AbsolutePath, false);
        }

        private void WriteToLog(int? productId, string description, string barcode, string transactionType, int quantity, string jobNumber, string newLocCode, string prevLocCode)
        {
            // write new record to Transaction log
            try
            {
                SmartCodeDataContext db = new SmartCodeDataContext();
                db.WriteTransaction(productId, description, barcode, transactionType, quantity, jobNumber, newLocCode, prevLocCode);
                db.SubmitChanges();
            }
            catch (Exception)
            {

            }
        }

        protected void ProductGridView_Sorted(object sender, EventArgs e)
        {
            ProductGridView.SelectedIndex = 0;
        }
    }
}