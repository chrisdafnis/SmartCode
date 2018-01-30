using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SmartCode
{
    public partial class StockValue : System.Web.UI.Page
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
                BindGrid();
            }
        }

        private void BindGrid()
        {
            try
            {
                SmartCodeDataContext db = new SmartCodeDataContext();
                //var transactions = db.GetAllTransactionHistory(null);
                var transactions = db.GetTotalStockValue();
                //load the grid
                //var transactions = (from tl in db.TransactionLogs
                //                    select new { tl.Barcode, tl.Product, tl.TransactionType, tl.Quantity, tl.JobNumber, tl.NewLocation, tl.PreviousLocation, tl.DateStamp })
                //                    .OrderByDescending(tl => tl.DateStamp).ToList();//.ToList<GetTransactionsResult>();

                StockValueGridView.DataSource = transactions.ToList();
                StockValueGridView.DataBind();

                double? grandtotal = null;
                db.GetGrandTotalStockValue(ref grandtotal);
                string[] MyArray = new string[1];
                if (grandtotal.HasValue)
                {
                    MyArray[0] = grandtotal.ToString();
                }

                TotalValueGridView.DataSource = MyArray.ToList();
                TotalValueGridView.DataBind();
            }
            catch (Exception)
            {

            }
        }

        protected void OnClickOK(object sender, EventArgs e)
        {
            Response.Redirect("Items.aspx");
        }

        protected void StockValueGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.Cells[0].Text = "ID";
                e.Row.Cells[0].Visible = false;
                e.Row.Cells[1].Text = "Product Code";
                e.Row.Cells[2].Text = "Description";
                e.Row.Cells[3].Text = "Unit Of Measure";
                e.Row.Cells[4].Text = "Quantity";
                e.Row.Cells[5].Text = "Value/Unit";
                e.Row.Cells[6].Text = "Total";
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[0].Visible = false;
                e.Row.Cells[5].CssClass = "Sterling";
                e.Row.Cells[6].CssClass = "Sterling";
            }
        }

        protected void TotalValueGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.Cells[0].Text = "Total Value";
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[0].CssClass = "Sterling";
            }
        }
        public DataTable LINQResultToDataTable<T>(IEnumerable<T> Linqlist)
        {
            DataTable dt = new DataTable();


            PropertyInfo[] columns = null;

            if (Linqlist == null) return dt;

            foreach (T Record in Linqlist)
            {

                if (columns == null)
                {
                    columns = ((Type)Record.GetType()).GetProperties();
                    foreach (PropertyInfo GetProperty in columns)
                    {
                        Type colType = GetProperty.PropertyType;

                        if ((colType.IsGenericType) && (colType.GetGenericTypeDefinition()
                        == typeof(Nullable<>)))
                        {
                            colType = colType.GetGenericArguments()[0];
                        }

                        dt.Columns.Add(new DataColumn(GetProperty.Name, colType));
                    }
                }

                DataRow dr = dt.NewRow();

                foreach (PropertyInfo pinfo in columns)
                {
                    dr[pinfo.Name] = pinfo.GetValue(Record, null) == null ? DBNull.Value : pinfo.GetValue
                    (Record, null);
                }

                dt.Rows.Add(dr);
            }
            return dt;
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    //DateTime? fromDate = Convert.ToDateTime(txtFrom.Text);
                    //DateTime? toDate = Convert.ToDateTime(txtTo.Text + " 23:59:59");
                    //int selectedValue = Convert.ToInt32(ddlItem.SelectedValue);

                    SmartCodeDataContext db = new SmartCodeDataContext();
                    var stockValue = db.GetTotalStockValue();
                    double? grandtotal = null;
                    db.GetGrandTotalStockValue(ref grandtotal);

                    //TotalValueGridView.DataSource = MyArray.ToList();
                    //TotalValueGridView.DataBind();
                    //GetProductMovementsResult result = (GetProductMovementsResult)products[0];

                    DataTable dt = LINQResultToDataTable(stockValue);
                    Document pdfDoc = new Document();
                    pdfDoc.SetPageSize(PageSize.A4);
                    pdfDoc.SetPageSize(PageSize.A4.Rotate());
                    PdfWriter writer = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
                    pdfDoc.Open();
                    iTextSharp.text.Font font5 = iTextSharp.text.FontFactory.GetFont(FontFactory.HELVETICA, 5);
                    iTextSharp.text.Font bolldfont5 = iTextSharp.text.FontFactory.GetFont(FontFactory.HELVETICA, 5, Font.BOLD);

                    PdfPTable table = new PdfPTable(dt.Columns.Count);
                    PdfPRow row = null;

                    // add report title
                    Font ColFont = FontFactory.GetFont(FontFactory.HELVETICA, 15, Font.BOLD);
                    String title = string.Format("{0} Report", "Stock Value");
                    Chunk chunkCols = new Chunk(title, ColFont);
                    PdfPCell cell = new PdfPCell(new Paragraph(chunkCols));
                    cell.Colspan = dt.Columns.Count;
                    cell.Padding = 5;
                    table.AddCell(cell);

                    table.HeaderRows = 4;

                    float[] widths = new float[] { 0f, 4f, 4f, 4f, 4f, 4f, 4f };

                    table.SetWidths(widths);

                    table.WidthPercentage = 100;
                    int iCol = 0;
                    string colname = "";
                    cell = new PdfPCell(new Phrase("Products"));

                    cell.Colspan = dt.Columns.Count;

                    foreach (DataColumn c in dt.Columns)
                    {

                        table.AddCell(new Phrase(c.ColumnName, bolldfont5));
                    }

                    foreach (DataRow r in dt.Rows)
                    {
                        if (dt.Rows.Count > 0)
                        {
                            table.AddCell(new Phrase(r[0].ToString(), font5));
                            table.AddCell(new Phrase(r[1].ToString(), font5));
                            table.AddCell(new Phrase(r[2].ToString(), font5));
                            table.AddCell(new Phrase(r[3].ToString(), font5));
                            table.AddCell(new Phrase(r[4].ToString(), font5));
                            PdfPCell currencyCell = new PdfPCell(new Phrase("£" + r[5].ToString(), font5));
                            currencyCell.HorizontalAlignment = Element.ALIGN_RIGHT;
                            table.AddCell(currencyCell);
                            currencyCell = new PdfPCell(new Phrase("£" + r[6].ToString(), font5));
                            currencyCell.HorizontalAlignment = Element.ALIGN_RIGHT;
                            table.AddCell(currencyCell);
                        }
                    }

                    Font TotalFont = FontFactory.GetFont(FontFactory.HELVETICA, 5, Font.BOLD);

                    // add a row for total value
                    table.AddCell(new Phrase("", TotalFont));
                    table.AddCell(new Phrase("Total Value", TotalFont));
                    table.AddCell(new Phrase("", TotalFont));
                    table.AddCell(new Phrase("", TotalFont));
                    table.AddCell(new Phrase("", TotalFont));
                    table.AddCell(new Phrase("", TotalFont));
                    PdfPCell totalCell = new PdfPCell(new Phrase("£" + grandtotal.ToString(), TotalFont));
                    totalCell.HorizontalAlignment = Element.ALIGN_RIGHT;
                    table.AddCell(totalCell);
                    
                    ColFont = FontFactory.GetFont(FontFactory.HELVETICA, 6, Font.BOLD);
                    String footer = string.Format("Report generated at: {0}", DateTime.Now.ToString());
                    chunkCols = new Chunk(footer, ColFont);
                    cell = new PdfPCell(new Paragraph(chunkCols));
                    cell.Colspan = dt.Columns.Count;
                    cell.Padding = 5;
                    table.AddCell(cell);

                    pdfDoc.AddTitle("Stock Value");
                    pdfDoc.Add(table);
                    pdfDoc.Close();

                    Response.ContentType = "application/pdf";
                    Response.AddHeader("content-disposition", "attachment;filename=StockValueReport.pdf");
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.Write(pdfDoc);
                    Response.End();
                }
            }
        }
    }
}