using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SmartCode
{
    public partial class EditItem : System.Web.UI.Page
    {
        private int itemID = 0;
        GetProductResult currentProduct = new GetProductResult();
        int quantity = 0;

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
            itemID = Convert.ToInt32(Request.QueryString["ID"]);

            // populate the item fields
            SmartCodeDataContext db = new SmartCodeDataContext();

            currentProduct = (GetProductResult)db.GetProduct(itemID).Single();

            if (!Page.IsPostBack)
            {
                txtBarcode.Text = currentProduct.Barcode;
                txtDescription.Text = currentProduct.Description;
                txtBinLocation.Text = currentProduct.BinLocation;
                txtFullDescription.Text = currentProduct.FullDescription;
                SupplierDropDownList.SelectedIndex = Convert.ToInt32(currentProduct.SupplierId);
                txtSupplierCode.Text = currentProduct.SupplierCode;
                quantity = currentProduct.Quantity;
                //txtQuantity.Text = currentProduct.Quantity.ToString();
                txtUnitOfMeasure.Text = currentProduct.UnitOfMeasure;
                txtUnitPrice.Text = currentProduct.UnitPrice.ToString();
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

        protected void OnClickSave(object sender, EventArgs e)
        {
            try
            {
                SmartCodeDataContext db = new SmartCodeDataContext();
                db.UpdateProduct(currentProduct.ProductId,
                                    txtBarcode.Text,
                                    txtDescription.Text,
                                    txtBinLocation.Text,
                                    txtFullDescription.Text,
                                    Convert.ToInt32(SupplierDropDownList.SelectedValue),
                                    txtSupplierCode.Text,
                                    quantity,
                                    //int.Parse(txtQuantity.Text),
                                    txtUnitOfMeasure.Text,
                                    Convert.ToDouble(txtUnitPrice.Text));
                //db.up

                db.SubmitChanges();
                //WriteToLog(currentProduct.ProductId, txtDescription.Text, txtBarcode.Text, "STU", int.Parse(txtQuantity.Text), null, null, null);
                WriteToLog(currentProduct.ProductId, txtDescription.Text, txtBarcode.Text, "STU", quantity, null, null, null);
            }
            catch (Exception)
            {

            }

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
    }
}