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
                string[] MyArray = new string[2];
                MyArray[0] = "Total Value";
                if (grandtotal.HasValue)
                {
                    MyArray[1] = grandtotal.ToString();
                }

                TotalValueGridView.DataSource = MyArray.ToList();
                TotalValueGridView.DataBind();

                //BindBarcodesList();
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

        }
    }
}