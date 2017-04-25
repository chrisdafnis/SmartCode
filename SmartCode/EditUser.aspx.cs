using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SmartCode
{
    public partial class EditUser : System.Web.UI.Page
    {
        private int userID = 0;
        GetUserResult currentUser = new GetUserResult();
        DateTime createdDate = new DateTime();
        DateTime? lastLoginDate = new DateTime();

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
            userID = Convert.ToInt32(Request.QueryString["ID"]);

            // populate the item fields
            SmartCodeDataContext db = new SmartCodeDataContext();

            currentUser = db.GetUser(userID).ToList<GetUserResult>().First();
            createdDate = currentUser.CreatedDate;
            lastLoginDate = currentUser.LastLoginDate;

            if (!Page.IsPostBack)
            {
                txtUsername.Text = currentUser.Username;
                txtPassword.Text = currentUser.Password;

                ListItem item = new ListItem("Administrator", "1");
                ddlUserLevel.Items.Add(item);
                item = new ListItem("User", "2");
                ddlUserLevel.Items.Add(item);
                ddlUserLevel.SelectedValue = currentUser.UserLevel.ToString();
            }
        }

        private void ReturnToUsers()
        {
            Response.Redirect("Users.aspx");
        }

        protected void OnClickCancel(object sender, EventArgs e)
        {
            ReturnToUsers();
        }

        protected void OnClickSave(object sender, EventArgs e)
        {
            try
            {
                SmartCodeDataContext db = new SmartCodeDataContext();
                db.UpdateUser(currentUser.UserId, txtUsername.Text, txtPassword.Text, ddlUserLevel.SelectedValue, createdDate, lastLoginDate);

                db.SubmitChanges();
            }
            catch (Exception)
            {

            }

            ReturnToUsers();
        }
    }
}