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
                DateTime? toDate = Convert.ToDateTime(txtTo.Text);
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

        protected void PrintCurrentPage(object sender, EventArgs e)
        {
            StringWriter stringWrite = new StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new System.Web.UI.HtmlTextWriter(stringWrite);
            if (ItemMovementGridView is WebControl)
            {
                Unit w = new Unit(100, UnitType.Percentage);
                ((WebControl)ItemMovementGridView).Width = w;
            }
            Page pg = new Page();
            pg.EnableEventValidation = false;

            HtmlForm frm = new HtmlForm();
            pg.Controls.Add(frm);
            frm.Attributes.Add("runat", "server");
            frm.Controls.Add(lblTitle);
            frm.Controls.Add(txtFrom);
            frm.Controls.Add(txtTo);
            frm.Controls.Add(ItemMovementGridView);
            pg.DesignerInitialize();
            pg.RenderControl(htmlWrite);
            string strHTML = stringWrite.ToString();
            string printHTML = TweakHTMLForPrint(strHTML);
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.Write(printHTML);
            HttpContext.Current.Response.Write("<script>window.print();</script>");
            HttpContext.Current.Response.End();
        }

        private string TweakHTMLForPrint(string strHTML)
        {
            strHTML = strHTML.Replace("<form method=\"post\" action=\"./ItemMovement\" id=\"ctl00\" runat=\"server\">", "<form method=\"post\" action=\"./ItemMovement\" id=\"ctl00\" runat=\"server\" target=\"_blank\"><font face=\"verdana\" size=\"2\">");
            strHTML = strHTML.Replace("<span id=\"lblTitle\">Product Movement</span>", "<table cellspacing=\"4\"><tr><td><h2><b>Product Movement</b></h2></td>");
            strHTML = strHTML.Replace("<input name=\"txtFrom\" type=\"text\" value=\"", "<td align=\"right\"><h3><b>");
            strHTML = strHTML.Replace("\" id=\"txtFrom\" style=\"width:150px;\" />", "");
            strHTML = strHTML.Replace("<input name=\"txtTo\" type=\"text\" value=\"", " - ");
            strHTML = strHTML.Replace("\" id=\"txtTo\" style=\"width:150px;\" />", "</b></h3></td></tr></table>");
            strHTML = strHTML.Replace("<table cellspacing=\"4\" cellpadding=\"4\"", "<table border=\"1\" cellpadding=\"0\" cellspacing=\"0\"");
            strHTML = strHTML.Replace("</form>", "</font></form>");
            return strHTML;
        }

        protected void ButtonSearch_Click(object sender, EventArgs e)
        {
            BindGrid();
        }
    }
}