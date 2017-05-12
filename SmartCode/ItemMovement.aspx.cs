using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace SmartCode
{
    public partial class ItemMovement : System.Web.UI.Page
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
                BindDDL();
            }
        }

        private void BindDDL()
        {
            SmartCodeDataContext db = new SmartCodeDataContext();
            var products = (from prod in db.Products
                            select prod).ToList();

            var dictionary = new Dictionary<int, string>();
            foreach (var val in products)
            {
                dictionary.Add(val.ProductId, val.Description);
            }

            ddlItem.DataTextField = "Value";
            ddlItem.DataValueField = "Key";
            ddlItem.DataSource = dictionary;
            ddlItem.DataBind();
        }

        private void BindGrid()
        {
            try
            {
                DateTime? fromDate = Convert.ToDateTime(txtFrom.Text);
                DateTime? toDate = Convert.ToDateTime(txtTo.Text + " 23:59:59");
                int selectedValue = Convert.ToInt32(ddlItem.SelectedValue);

                SmartCodeDataContext db = new SmartCodeDataContext();
                var products = db.GetProductMovements(selectedValue, fromDate, toDate).ToList();

                ItemMovementGridView.DataSource = products;
                ItemMovementGridView.DataBind();
            }
            catch (Exception)
            {

            }
        }

        protected void OnClickOK(object sender, EventArgs e)
        {
            Response.Redirect("Items.aspx");
        }

        protected void ButtonSearch_Click(object sender, EventArgs e)
        {
            BindGrid();
        }
    }
}