using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SmartCode
{
    public partial class EditSupplier : System.Web.UI.Page
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

        private void ReturnToSuppliers()
        {
            Response.Redirect("Suppliers.aspx");
        }

        protected void OnClickCancel(object sender, EventArgs e)
        {
            ReturnToSuppliers();
        }

        protected void OnClickSave(object sender, EventArgs e)
        {
            try
            {
                //SmartCodeDataContext db = new SmartCodeDataContext();
                //db.UpdateUser(currentUser.UserId, txtUsername.Text, txtPassword.Text, Convert.ToInt32(ddlUserLevel.SelectedValue), createdDate, lastLoginDate);

                //db.SubmitChanges();
            }
            catch (Exception)
            {

            }

            ReturnToSuppliers();
        }
    }
}