using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SmartCode
{
    public partial class StockValue : System.Web.UI.Page
    {
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

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                BindGrid();
            }
        }

        private void BindGrid()
        {
            try
            {
                SmartCodeDataContext db = new SmartCodeDataContext();
                //var transactions = db.GetAllTransactionHistory(null);
                var transactions = db.GetTotalStockValue();
                //load the grid
                //var transactions = (from tl in db.TransactionLogs
                //                    select new { tl.Barcode, tl.Product, tl.TransactionType, tl.Quantity, tl.JobNumber, tl.NewLocation, tl.PreviousLocation, tl.DateStamp })
                //                    .OrderByDescending(tl => tl.DateStamp).ToList();//.ToList<GetTransactionsResult>();

                StockValueGridView.DataSource = transactions.ToList();
                StockValueGridView.DataBind();

                double? grandtotal = null;
                db.GetGrandTotalStockValue(ref grandtotal);
                string[] MyArray = new string[1];
                if (grandtotal.HasValue)
                {
                    MyArray[0] = grandtotal.ToString();
                }

                TotalValueGridView.DataSource = MyArray.ToList();
                TotalValueGridView.DataBind();
            }
            catch (Exception)
            {

            }
        }

        protected void OnClickOK(object sender, EventArgs e)
        {
            Response.Redirect("Items.aspx");
        }

        protected void StockValueGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.Cells[0].Text = "ID";
                e.Row.Cells[0].Visible = false;
                e.Row.Cells[1].Text = "Product Code";
                e.Row.Cells[2].Text = "Description";
                e.Row.Cells[3].Text = "Unit Of Measure";
                e.Row.Cells[4].Text = "Quantity";
                e.Row.Cells[5].Text = "Value/Unit";
                e.Row.Cells[6].Text = "Total";
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[0].Visible = false;
                e.Row.Cells[5].CssClass = "Sterling";
                e.Row.Cells[6].CssClass = "Sterling";
            }
        }

        protected void TotalValueGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.Cells[0].Text = "Total Value";
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[0].CssClass = "Sterling";
            }
        }
    }
}