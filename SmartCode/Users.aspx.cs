using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SmartCode
{
    public partial class Users : System.Web.UI.Page
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

        protected void OnClickAddUser(object sender, EventArgs e)
        {
            Response.Redirect("AddNewUser.aspx");
        }

        protected void UsersGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "EditUser":
                    {
                        GridViewRow clickedRow = ((LinkButton)e.CommandSource).NamingContainer as GridViewRow;
                        UsersGridView.EditIndex = clickedRow.RowIndex;

                        DataKey rowKeys = UsersGridView.DataKeys[clickedRow.RowIndex];
                        int userId = (int)rowKeys["UserId"];
                        Response.Redirect("EditUser.aspx?ID=" + userId);
                    }
                    break;

                case "DeleteUser":
                    {
                        GridViewRow clickedRow = ((LinkButton)e.CommandSource).NamingContainer as GridViewRow;
                        UsersGridView.EditIndex = clickedRow.RowIndex;

                        DataKey rowKeys = UsersGridView.DataKeys[clickedRow.RowIndex];
                        int userId = (int)rowKeys["UserId"];
                        DeleteUser(userId);
                    }
                    break;

            }
        }

        private void DeleteUser(int userId)
        {
            SmartCodeDataContext db = new SmartCodeDataContext();
            var remove = (from aremove in db.Securities
                          where aremove.UserId == userId
                          select aremove).FirstOrDefault();

            if (remove != null)
            {
                db.Securities.DeleteOnSubmit(remove);
                db.SubmitChanges();
            }
        }

        bool ReturnValue()
        {
            return false;
        }

        protected void UsersGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label type = (Label)e.Row.FindControl("lblUserLevel");
                if (type.Text == "1")
                {
                    type.Text = "Administrator";
                }
                else if (type.Text == "2")
                {
                    type.Text = "User";
                }
            }
        }
    }
}