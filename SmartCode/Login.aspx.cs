using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using SmartCode;

namespace SmartCode
{
    public partial class LoginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Application["User"] = null;
        }

        protected void ValidateUser(object sender, AuthenticateEventArgs e)
        {
            SmartCodeDataContext db = new SmartCodeDataContext();
            var transations = db.ValidateUser(Login1.UserName, Login1.Password);

            var varUser = (from u in db.Securities
                           where u.Username == Login1.UserName &&
                                       u.Password == Login1.Password
                           select u).Distinct();

            if (varUser.ToList().Count > 0)
            {
                Security user = (Security)varUser.First();
                Application["User"] = user;
                FormsAuthentication.RedirectFromLoginPage(Login1.UserName, false);
                db.UpdateUser(user.UserId, user.Username, user.Password, user.UserLevel, user.CreatedDate, DateTime.Now);
            }
            else
            {
                Login1.FailureText = "Username and/or password is incorrect.";
            }
        }
    }
}