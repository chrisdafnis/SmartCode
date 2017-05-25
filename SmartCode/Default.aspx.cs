using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SmartCode
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("items.aspx");
        }
        //void Page_PreInit(object sender, EventArgs e)
        //{
        //    if (IsAdmin())
        //    {
        //        MasterPageFile = "~/Admin.master";
        //    }
        //    else
        //    {
        //        MasterPageFile = "~/User.master";
        //    }
        //}

        //public bool IsAdmin()
        //{
        //    Security state = (Security)Application["User"];
        //    if (state != null)
        //    {
        //        if (((Security)Application["User"]).UserLevel == "Admin")
        //        {
        //            return true;
        //        }
        //        else
        //        {
        //            return false;
        //        }
        //    }
        //    else
        //    {
        //        Context.GetOwinContext().Authentication.SignOut();
        //        Response.Redirect("Login.aspx");
        //        return false;
        //    }
        //}
    }
}