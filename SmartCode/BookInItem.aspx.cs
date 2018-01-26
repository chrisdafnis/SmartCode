using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SmartCode
{
    public partial class BookInItem : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lbTitle.Text = "Search for Product";
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

        protected void OnClickSearchForProduct(object sender, EventArgs e)
        {
            string barcode = txtBarcode.Text;
            txtDescription.Text = string.Empty;
            SmartCodeDataContext db = new SmartCodeDataContext();

            var products = (from p in db.Products
                            where p.Barcode == barcode
                            select p).Distinct();

            foreach (Product prod in products)
            {
                txtDescription.Text = prod.Description;
                lbTitle.Text = "Book In Item";
                txtLocation.Enabled = false;
                txtLocation.Text = prod.BinLocation;
                txtQuantity.Enabled = true;
                btBookInProduct.Enabled = true;
                txtLocation.Attributes["required"] = "true";
                txtQuantity.Attributes["required"] = "true";
            }

            if (txtDescription.Text == string.Empty)
            {
                txtDescription.Text = "Barcode not found.";
                lbTitle.Text = "Search for Product";
                txtLocation.Enabled = false;
                txtQuantity.Enabled = false;
                btBookInProduct.Enabled = false;
                txtLocation.Attributes["required"] = "false";
                txtQuantity.Attributes["required"] = "false";
            }
        }

        protected void OnClickCancel(object sender, EventArgs e)
        {
            ReturnToItems();
        }

        private void ReturnToItems()
        {
            Response.Redirect("Items.aspx");
        }

        protected void btBookInProduct_Click(object sender, EventArgs e)
        {
            string barcode = txtBarcode.Text;
            string description = txtDescription.Text;
            string location = txtLocation.Text;
            int quantity;
            if (Int32.TryParse(txtQuantity.Text, out quantity))
            {

            }
            else
            {
                // some kind of error message
            }

            SmartCodeDataContext db = new SmartCodeDataContext();
            Product product = db.Products.Single(p => p.Barcode == barcode);
            Location loc = db.Locations.Where(l => l.Barcode == barcode).SingleOrDefault(l => l.LocationCode == location);

            try
            {
                if (loc == null)
                {
                    // location doesn't exist, so create new one
                    loc = new Location();
                    loc.LocationCode = product.BinLocation;
                    loc.LocationType = "BULK";
                    loc.ProductId = product.ProductId;
                    loc.Product.Description = product.Description;
                    loc.Quantity = quantity;
                    loc.Barcode = product.Barcode;
                    db.Locations.InsertOnSubmit(loc);
                }
                else
                {
                    // location exists, so update quantity
                    loc.Quantity += quantity;
                }

                db.SubmitChanges();
            }
            catch (Exception)
            {

            }
            WriteToLog(loc.ProductId, loc.Product.Description, barcode, loc.LocationType, quantity, null, loc.LocationCode, null);
            ResetForm();
        }

        private void ResetForm()
        {
            txtBarcode.Text = string.Empty;
            txtDescription.Text = string.Empty;
            txtLocation.Text = string.Empty;
            txtQuantity.Text = string.Empty;
            lbTitle.Text = "Search for Product";
            txtLocation.Enabled = false;
            txtQuantity.Enabled = false;
            btBookInProduct.Enabled = false;
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

        protected void txtBarcode_TextChanged(object sender, EventArgs e)
        {
            lbTitle.Text = "Search for Product";
        }
    }
}