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
            var pending = db.GetAllPendingStockTakes();

            PendingGridView.DataSource = pending.ToList<GetAllPendingStockTakesResult>();
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
                        DataKey rowKeys = PendingGridView.DataKeys[row.RowIndex];
                        int transactionId = (int)rowKeys["Id"];
                        int productId = (int)rowKeys["ProductId"];
                        int locationId = (int)rowKeys["LocationId"];
                        GetPendingStockTakeResult pending = db.GetPendingStockTake(transactionId).ToList<GetPendingStockTakeResult>()[0];

                        db.UpdateLocationQuantity(pending.LocationId, pending.ProductId, Convert.ToInt32(actualValue.Text));
                        db.UpdatePendingStockTake(pending.Id, pending.ProductId, pending.Barcode);
                        try
                        {
                            db.SubmitChanges();
                        }
                        catch (Exception)
                        {

                        }
                        WriteToLog(productId,"Stock Take", pending.Barcode, "STU", Convert.ToInt32(actualValue.Text), null, pending.LocationCode, null);

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

                GetAllPendingStockTakesResult row = (GetAllPendingStockTakesResult)e.Row.DataItem;
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