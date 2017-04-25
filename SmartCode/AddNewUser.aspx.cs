using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SmartCode
{
    public partial class AddNewUser : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            ddlUserLevel.Items.Add(new ListItem("Administator", "1"));
            ddlUserLevel.Items.Add(new ListItem("User", "2"));
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

        protected void OnClickAddUser(object sender, EventArgs e)
        {
            // get data for new record from form
            string userName = txtUserName.Text;
            string password = txtPassword.Text;
            string userLevel = ddlUserLevel.SelectedItem.Value;

            // write new record to database
            Security secr = new Security();
            secr.Username = userName;
            secr.Password = password;
            secr.UserLevel = userLevel;
            secr.CreatedDate = DateTime.Now;

            try
            {
                SmartCodeDataContext db = new SmartCodeDataContext();
                db.Securities.InsertOnSubmit(secr);
                db.SubmitChanges();
            }
            catch (Exception)
            {

            }

            ReturnToUsers();
        }
        private void ReturnToUsers()
        {
            Response.Redirect("Users.aspx");
        }
        protected void OnClickCancel(object sender, EventArgs e)
        {
            ReturnToUsers();
        }
    }
}