using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SmartCode
{
    public partial class StockTake : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            TextBox quantityTextBox = new TextBox();
            quantityTextBox.ID = "actualValue";
            PendingGridView.Controls.Add(quantityTextBox);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            SmartCodeDataContext db = new SmartCodeDataContext();
            var pending = db.GetPendingStockTakes();

            PendingGridView.DataSource = pending.ToList<GetPendingStockTakesResult>();
            PendingGridView.DataBind();
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

        protected void OnClickUpdatePending(object sender, EventArgs e)
        {
            foreach (GridViewRow row in PendingGridView.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    TextBox actualValue = (row.Cells[0].FindControl("actualValue") as TextBox);

                    if (actualValue.Text != String.Empty)
                    {
                        SmartCodeDataContext db = new SmartCodeDataContext();
                        DataKeyArray keys = PendingGridView.DataKeys;
                        DataKey rowKeys = keys[row.RowIndex];
                        int transactionId = (int)rowKeys["Id"];
                        int productId = (int)rowKeys["ProductId"];
                        int locationId = (int)rowKeys["LocationId"];

                        var selectquery2 = from l in db.Locations
                                           where l.ProductId == productId &&
                                                l.Id == locationId
                                           select l;

                        string barcode = String.Empty;
                        string location = String.Empty;
                        foreach (Location loc in selectquery2)
                        {
                            loc.Quantity = Convert.ToInt32(actualValue.Text);
                            barcode = loc.Barcode;
                            location = loc.LocationCode;

                            // update stock in location
                            db.UpdateLocationQuantity(locationId, productId, loc.Quantity);
                        }

                        // delete record from pending
                        var deletequery = from t in db.PendingStockTakes
                                          where t.ProductId == productId &&
                                                t.LocationId == locationId
                                          select t;

                        string description = null;
                        foreach (PendingStockTake pst in deletequery)
                        {
                            description = pst.Product.Description;
                            db.PendingStockTakes.DeleteOnSubmit(pst);
                        }

                        try
                        {
                            db.SubmitChanges();
                        }
                        catch (Exception)
                        {

                        }

                        WriteToLog(productId, description, barcode, "STU", Convert.ToInt32(actualValue.Text), null, location, null);

                        Response.Redirect(Request.RawUrl);
                    }
                }
            }
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

        protected void PendingGridView_DataBound(object sender, EventArgs e)
        {
            List<DataControlField> columns = PendingGridView.Columns.Cast<DataControlField>().ToList();
            columns.Find(col => col.HeaderText == "ProductId").Visible = false;
            columns.Find(col => col.HeaderText == "Id").Visible = false;
        }

        protected void PendingGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // check the date on the stock take items, and if they are older than one week, highlight in red

                GetPendingStockTakesResult row = (GetPendingStockTakesResult)e.Row.DataItem;
                DateTime? datestamp = row.DateStamp;

                TimeSpan timespan = new TimeSpan(7, 0, 0, 0);

                if (datestamp < DateTime.Now.Subtract(timespan))
                {
                    e.Row.BackColor = System.Drawing.Color.Red;
                    e.Row.ForeColor = System.Drawing.Color.White;
                    //e.Row.ToolTip = "OUTSTANDING STOCK TAKE";
                }
            }
        }
    }
}