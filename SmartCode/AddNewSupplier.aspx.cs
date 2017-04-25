using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SmartCode
{
    public partial class AddNewSupplier : System.Web.UI.Page
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
        protected void OnClickAddSupplier(object sender, EventArgs e)
        {
            // get data for new record from form
            string supplierName = txtSupplierName.Text;
            string addressLine1 = txtAddressLine1.Text;
            string addressLine2 = txtAddressLine2.Text;
            string addressLine3 = txtAddressLine3.Text;
            string addressLine4 = txtAddressLine4.Text;
            string addressLine5 = txtAddressLine5.Text;
            string contactNumber = txtContactNumber.Text;
            string email = txtEmail.Text;
            string webSite = txtWebSite.Text;

            // write new record to database
            Supplier supp = new Supplier();
            supp.SupplierName = supplierName;
            supp.AddressLine1 = addressLine1;
            supp.AddressLine2 = addressLine2;
            supp.AddressLine3 = addressLine3;
            supp.AddressLine4 = addressLine4;
            supp.AddressLine5 = addressLine5;
            supp.ContactNo = contactNumber;
            supp.Email = email;
            supp.WebSite = webSite;

            try
            {
                SmartCodeDataContext db = new SmartCodeDataContext();
                db.Suppliers.InsertOnSubmit(supp);
                db.SubmitChanges();
            }
            catch (Exception)
            {

            }

            ReturnToSuppliers();
        }
        private void ReturnToSuppliers()
        {
            Response.Redirect("Suppliers.aspx");
        }
        protected void OnClickCancel(object sender, EventArgs e)
        {
            ReturnToSuppliers();
        }
    }
}