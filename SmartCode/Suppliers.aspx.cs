using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SmartCode
{
    public partial class Suppliers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsAdmin())
            {
                ((DataControlField)SupplierGridView.Columns
                   .Cast<DataControlField>()
                   .Where(fld => (fld.HeaderText == "Edit"))
                   .SingleOrDefault()).Visible = false;
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

        protected void SupplierGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            // fix the column headings
            if (e.Row.RowType == DataControlRowType.Header)
            {
                foreach (TableCell cell in e.Row.Cells)
                {
                    if (cell.Text == "SupplierName")
                        cell.Text = "Supplier Name";
                    if (cell.Text == "AddressLine1")
                        cell.Text = "Address Line 1";
                    if (cell.Text == "AddressLine2")
                        cell.Text = "Address Line 2";
                    if (cell.Text == "AddressLine3")
                        cell.Text = "Address Line 3";
                    if (cell.Text == "AddressLine4")
                        cell.Text = "Address Line 4";
                    if (cell.Text == "AddressLine5")
                        cell.Text = "Address Line 5";
                    if (cell.Text == "ContactNo")
                        cell.Text = "Contact No";
                    if (cell.Text == "WebSite")
                        cell.Text = "Web Site";
                }
            }
        }

        protected void OnClickAddSupplier(object sender, EventArgs e)
        {
            Response.Redirect("AddNewSupplier.aspx");
        }

        protected void SupplierGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "EditSupplier":
                    {
                        GridViewRow clickedRow = ((LinkButton)e.CommandSource).NamingContainer as GridViewRow;
                        SupplierGridView.EditIndex = clickedRow.RowIndex;

                        DataKey rowKeys = SupplierGridView.DataKeys[clickedRow.RowIndex];
                        int supplierId = (int)rowKeys["Id"];
                        Response.Redirect("EditSupplier.aspx?ID=" + supplierId);
                    }
                    break;

                case "DeleteSupplier":
                    {
                        GridViewRow clickedRow = ((LinkButton)e.CommandSource).NamingContainer as GridViewRow;
                        SupplierGridView.EditIndex = clickedRow.RowIndex;

                        DataKey rowKeys = SupplierGridView.DataKeys[clickedRow.RowIndex];
                        int supplierId = (int)rowKeys["Id"];
                        DeleteSupplier(supplierId);
                    }
                    break;

            }
        }

        private void DeleteSupplier(int supplierId)
        {
            SmartCodeDataContext db = new SmartCodeDataContext();
            var remove = (from aremove in db.Suppliers
                          where aremove.Id == supplierId
                          select aremove).FirstOrDefault();

            if (remove != null)
            {
                db.Suppliers.DeleteOnSubmit(remove);
                db.SubmitChanges();
            }
        }
    }
}