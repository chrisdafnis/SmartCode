using SmartCode;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SmartCode
{
    public partial class AddNewItem : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                SupplierDropDownList.SelectedIndex = 1;
            }
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

        protected void OnClickAddProduct(object sender, EventArgs e)
        {
            // get data for new record from form
            string barcode = txtBarcode.Text;
            string description = txtDescription.Text;
            string binLocation = txtBinLocation.Text;
            string fullDescription = txtFullDescription.Text;
            int selectedSupplier = 1;
            Int32.TryParse(SupplierDropDownList.SelectedValue, out selectedSupplier);
            string supplierCode = txtSupplierCode.Text;
            //int quantity = Convert.ToInt32(txtQuantity.Text);
            string unitOfMeasure = txtUnitOfMeasure.Text;
            double unitPrice = Convert.ToDouble(txtUnitPrice.Text);

            int? productId = null;
            try
            {
                SmartCodeDataContext db = new SmartCodeDataContext();
                db.InsertProduct(ref productId, barcode, description, binLocation, fullDescription, selectedSupplier, supplierCode, /*quantity,*/ unitOfMeasure, unitPrice);
                db.InsertLocation(productId, binLocation, barcode, 0, "BULK");
                db.SubmitChanges();
            }
            catch (Exception ex)
            {
                //this.ErrorTextBox.Text = ex.Message;
                //this.ErrorUpdatePanel.Update();
            }

            WriteToLog(productId, description, barcode, "ADP", /*quantity*/0, null, null, null);
            ReturnToItems();
        }

        private void WriteToLog(int? productId, string description, string barcode, string transactionType, int quantity, string jobNumber, string newLocCode, string prevLocCode)
        {
            // write new record to Transaction log
            try
            {
                SmartCodeDataContext db = new SmartCodeDataContext();
                db.WriteTransaction(productId, description, barcode, transactionType, quantity, jobNumber, newLocCode, prevLocCode);
                db.SubmitChanges();
            }
            catch (Exception)
            {

            }
        }

        private void ReturnToItems()
        {
            Response.Redirect("Items.aspx");
        }

        protected void OnClickCancel(object sender, EventArgs e)
        {
            ReturnToItems();
        }
    }
}