using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SmartCode
{
    public partial class Search : System.Web.UI.Page
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
                ListItem item = new ListItem("Products", "0");
                ddlSearchType.Items.Add(item);
                item = new ListItem("Suppliers", "1");
                ddlSearchType.Items.Add(item);
                if (IsAdmin())
                {
                    item = new ListItem("Users", "2");
                    ddlSearchType.Items.Add(item);
                }

                ddlSearchType.SelectedIndex = 0;
            }
        }

        protected void OnClickSearch(object sender, EventArgs e)
        {
            string searchString = '%' + txtSearchText.Text + '%';
            SmartCodeDataContext db = new SmartCodeDataContext();

            switch (ddlSearchType.SelectedItem.Text)
            {
                case "Products":
                    {
                        List<SearchProductsResult> productList = db.SearchProducts(searchString).ToList();
                        GridViewSearchResults.DataSource = productList;
                        GridViewSearchResults.DataBind();
                    }
                    break;
                case "Suppliers":
                    {
                        List<SearchSuppliersResult> supplierList = db.SearchSuppliers(searchString).ToList();
                        GridViewSearchResults.DataSource = supplierList;
                        GridViewSearchResults.DataBind();
                    }
                    break;
                case "Users":
                    {
                        List<SearchUsersResult> userList = db.SearchUsers(searchString).ToList();
                        GridViewSearchResults.DataSource = userList;
                        GridViewSearchResults.DataBind();
                    }
                    break;
            }
        }
    }
}