using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SmartCode
{
    public partial class User : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Security state = (Security)Application["User"];
                if (state != null)
                {
                    Label userNameLabel = this.FindControl("Username") as Label;
                    userNameLabel.Text = ((Security)Application["User"]).Username.ToString();

                    Label userLevelLabel = this.FindControl("Userlevel") as Label;
                    userLevelLabel.Text = ((Security)Application["User"]).UserLevel;
                }
                else
                {
                    Context.GetOwinContext().Authentication.SignOut();
                    Response.Redirect("Login.aspx");
                }
            }
        }

        protected void logOutButton_Click(object sender, EventArgs e)
        {
            Context.GetOwinContext().Authentication.SignOut();
            Response.Redirect("Login.aspx");
        }
    }
}