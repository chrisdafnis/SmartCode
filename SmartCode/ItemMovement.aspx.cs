using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SmartCode
{
    public partial class ItemMovement : System.Web.UI.Page
    {
        private int selectedValue = 1;

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
                BindGrid();
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
                SmartCodeDataContext db = new SmartCodeDataContext();
                var products = db.GetProductMovements(selectedValue).ToList();

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

        protected void ddlItem_SelectedIndexChanged(object sender, EventArgs e)
        {
            selectedValue = Convert.ToInt32((sender as DropDownList).SelectedValue);
            BindGrid();
        }
    }
}