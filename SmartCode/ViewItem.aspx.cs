using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RawPrint;
using System.Text;

namespace SmartCode
{
    public partial class ViewItem : System.Web.UI.Page
    {
        private int itemID = 0;
        public class LocalProduct
        {
            private string fullDescription = String.Empty;
            private double? unitPrice = null;

            public int ProductId { get; set; }
            public string Barcode { get; set; }
            public string BinLocation { get; set; }
            public string Description { get; set; }
            public string FullDescription { get; set; }
            public int Quantity { get; set; }
            public string SupplierName { get; set; }
            public string UnitOfMeasure { get; set; }
            public double? UnitPrice { get; set; }

            public LocalProduct(int productId, string barcode, string binLocation, string description, string fullDescription, int quantity, string supplierName, string unitOfMeasure, double? unitPrice)
            {
                ProductId = productId;
                Barcode = barcode;
                BinLocation = binLocation;
                Description = description;
                FullDescription = fullDescription;
                Quantity = quantity;
                SupplierName = supplierName;
                UnitOfMeasure = unitOfMeasure;
                UnitPrice = unitPrice;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProduct();
            }
        }

        private void LoadProduct()
        {
            itemID = Convert.ToInt32(Request.QueryString["ID"]);

            // populate the item fields
            SmartCodeDataContext db = new SmartCodeDataContext();
            var prodQuery = db.Products.Join(db.Suppliers, pr => pr.SupplierId, su => su.Id, (pr, su) =>
                new { pr.ProductId, pr.Barcode, pr.BinLocation, pr.Description, pr.FullDescription, pr.Quantity, su.SupplierName, pr.UnitOfMeasure, pr.UnitPrice })
                .Where(p => p.ProductId == itemID);

            IEnumerable<LocalProduct> product = from item in prodQuery.AsEnumerable()
                                                select new LocalProduct(item.ProductId,
                                                                         item.Barcode,
                                                                         item.BinLocation,
                                                                         item.Description,
                                                                         item.FullDescription,
                                                                         item.Quantity,
                                                                         item.SupplierName,
                                                                         item.UnitOfMeasure,
                                                                         item.UnitPrice);

            try
            {

                txtBarcode.Text = product.First<LocalProduct>().Barcode;
                txtBinLocation.Text = product.First<LocalProduct>().BinLocation;
                txtDescription.Text = product.First<LocalProduct>().Description;
                txtFullDescription.Text = product.First<LocalProduct>().FullDescription;
                txtSupplier.Text = product.First<LocalProduct>().SupplierName;
                txtUnitOfMeasure.Text = product.First<LocalProduct>().UnitOfMeasure;
                txtUnitPrice.Text = product.First<LocalProduct>().UnitPrice.ToString();

                // populate the Locations GridView
                var locations = (from loc in db.Locations
                                 join pr in db.Products
                                 on loc.ProductId equals pr.ProductId
                                 where loc.ProductId == itemID
                                 select new { loc.LocationCode, loc.LocationType, loc.Quantity });

                ProductLocationsGridView.DataSource = locations;
                ProductLocationsGridView.DataBind();

                // populate the History GridView
                var transaction = db.GetAllTransactionHistory(txtBarcode.Text).ToList();
                ItemHistoryGridView.DataSource = transaction;
                ItemHistoryGridView.DataBind();
            }
            catch (Exception)
            {

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

        protected void OnClickOK(object sender, EventArgs e)
        {
            Response.Redirect("Items.aspx");
        }

        protected void ItemHistoryGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string toolTip = String.Empty;
                string temp = DataBinder.Eval(e.Row.DataItem, "TransactionType", string.Empty);
                switch (temp)
                {
                    case "MOV":
                        {
                            toolTip = "Internal Product Movement";
                        }
                        break;
                    case "STU":
                        {
                            toolTip = "Stock Take Update";
                        }
                        break;
                    case "STP":
                        {
                            toolTip = "Stock Take Pending";
                        }
                        break;
                    case "IN":
                        {
                            toolTip = "Goods In";
                        }
                        break;
                    case "ST":
                        {
                            toolTip = "Stock Take";
                        }
                        break;
                    case "OUT":
                        {
                            toolTip = "Goods Out";
                        }
                        break;
                    case "ADP":
                        {
                            toolTip = "New Product Added";
                        }
                        break;
                    case "DEL":
                        {
                            toolTip = "Product Deleted";
                        }
                        break;
                    case "BK":
                        {
                            toolTip = "Product Booked In";
                        }
                        break;
                }
                e.Row.Cells[2].ToolTip = toolTip;
            }
        }


        protected void btnPrintLabel_Click(object sender, EventArgs e)
        {
            string zpl = "^XA" +
                        @"^MMT" +
                        @"^PW408" +
                        @"^LL0200" +
                        @"^LS0" +
                        @"^FT16,43^A0N,24,24^FH\^FD"+ txtDescription.Text  + "^FS" +
                        @"^BY2,3,66^FT20,142^BCN,,N,N,A^FD" + txtBarcode.Text + "^FS" +
                        @"^FT90,170^A0N,24,24^FH\^FD" + txtBarcode.Text + "^FS" +
                        @"^PQ1,0,1,Y^XZ";
            Printer.PrintStream("ZDesigner GK420t", new MemoryStream(Encoding.UTF8.GetBytes(zpl)), "");
        }
    }
}