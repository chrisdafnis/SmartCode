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
        private int supplierID = 0;
        GetSupplierResult currentSupplier = new GetSupplierResult();

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
            supplierID = Convert.ToInt32(Request.QueryString["ID"]);

            // populate the item fields
            SmartCodeDataContext db = new SmartCodeDataContext();

            currentSupplier = (GetSupplierResult)db.GetSupplier(supplierID).Single();

            if (!Page.IsPostBack)
            {
                txtSupplierName.Text = currentSupplier.SupplierName;
                txtAddressLine1.Text = currentSupplier.AddressLine1;
                txtAddressLine2.Text = currentSupplier.AddressLine2;
                txtAddressLine3.Text = currentSupplier.AddressLine3;
                txtAddressLine4.Text = currentSupplier.AddressLine4;
                txtAddressLine5.Text = currentSupplier.AddressLine5;
                txtContactNumber.Text = currentSupplier.ContactNo;
                txtEmail.Text = currentSupplier.Email;
                txtWebSite.Text = currentSupplier.WebSite;
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
                SmartCodeDataContext db = new SmartCodeDataContext();
                db.UpdateSupplier(currentSupplier.Id,
                                    txtSupplierName.Text,
                                    txtAddressLine1.Text,
                                    txtAddressLine2.Text,
                                    txtAddressLine3.Text,
                                    txtAddressLine4.Text,
                                    txtAddressLine5.Text,
                                    txtContactNumber.Text,
                                    txtEmail.Text,
                                    txtWebSite.Text);
                db.SubmitChanges();
                WriteToLog(currentSupplier.Id, "Supplier Edited", currentSupplier.SupplierName, "EDIT", 0, null, null, null);
            }
            catch (Exception)
            {

            }

            ReturnToSuppliers();
        }

        private void WriteToLog(int? supplierId, string reason, string name, string transactionType, int quantity, string jobNumber, string newLocCode, string prevLocCode)
        {
            // write new record to Transaction log
            try
            {
                SmartCodeDataContext db = new SmartCodeDataContext();
                db.WriteTransaction(supplierId, reason, name, transactionType, quantity, jobNumber, newLocCode, prevLocCode);
                db.SubmitChanges();
            }
            catch (Exception)
            {

            }
        }
    }
}