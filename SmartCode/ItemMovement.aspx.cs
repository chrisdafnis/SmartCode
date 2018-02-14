using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using iTextSharp.tool.xml;
using System.Reflection;

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
                ViewState["SortColumn"] = "DateStamp";
                ViewState["SortDirection"] = "ASC";
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
                DateTime? toDate = Convert.ToDateTime(txtTo.Text + " 23:59:59");
                int selectedValue = Convert.ToInt32(ddlItem.SelectedValue);

                SmartCodeDataContext db = new SmartCodeDataContext();
                var products = db.GetProductMovements(selectedValue, fromDate, toDate).ToList();
                DataTable dataTable = LINQResultToDataTable(products);
                dataTable.DefaultView.Sort = ViewState["SortColumn"].ToString() + " " + ViewState["SortDirection"].ToString();
                ItemMovementGridView.DataSource = dataTable;
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

        protected void ButtonSearch_Click(object sender, EventArgs e)
        {
            BindGrid();
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
                    BindGrid();
                    DataView dv = new DataView(ItemMovementGridView.DataSource as DataTable);
                    if (ItemMovementGridView.DataSource != null)
                    {
                        dv.Sort = ViewState["SortColumn"].ToString() + " " + ViewState["SortDirection"].ToString();
                        DataTable dt = dv.ToTable();

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
                        String title = string.Format("{0} Report", lblTitle.Text);
                        Chunk chunkCols = new Chunk(title, ColFont);
                        PdfPCell cell = new PdfPCell(new Paragraph(chunkCols));
                        cell.Colspan = dt.Columns.Count;
                        cell.Padding = 5;
                        table.AddCell(cell);

                        // add some further details, product reporting period
                        ColFont = FontFactory.GetFont(FontFactory.HELVETICA, 10, Font.BOLD);
                        string item = ddlItem.SelectedItem.Text;
                        title = string.Format("{0}, {1}-{2}", item, txtFrom.Text, txtTo.Text);
                        chunkCols = new Chunk(title, ColFont);
                        cell = new PdfPCell(new Paragraph(chunkCols));
                        cell.Colspan = dt.Columns.Count;
                        cell.Padding = 5;
                        table.AddCell(cell);

                        table.HeaderRows = 4;

                        float[] widths = new float[] { 0f, 4f, 4f, 4f, 4f, 4f, 4f, 4f };

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
                                table.AddCell(new Phrase(r[5].ToString(), font5));
                                table.AddCell(new Phrase(r[6].ToString(), font5));
                                table.AddCell(new Phrase(r[7].ToString(), font5));
                            }
                        }

                        ColFont = FontFactory.GetFont(FontFactory.HELVETICA, 6, Font.BOLD);
                        String footer = string.Format("Report generated at: {0}", DateTime.Now.ToString());
                        chunkCols = new Chunk(footer, ColFont);
                        cell = new PdfPCell(new Paragraph(chunkCols));
                        cell.Colspan = dt.Columns.Count;
                        cell.Padding = 5;
                        table.AddCell(cell);

                        pdfDoc.AddTitle(lblTitle.Text);
                        pdfDoc.Add(table);
                        pdfDoc.Close();

                        Response.ContentType = "application/pdf";
                        Response.AddHeader("content-disposition", "attachment;filename=ProductMovementReport.pdf");
                        Response.Cache.SetCacheability(HttpCacheability.NoCache);
                        Response.Write(pdfDoc);
                        Response.End();
                    }
                }
            }
        }

        protected void gridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            BindGrid();
            DataTable dataTable = ItemMovementGridView.DataSource as DataTable;
            string sortDirection = "ASC";
            if (ViewState["SortColumnDirection"].ToString() == "Descending")
                sortDirection = "DESC";

            dataTable.DefaultView.Sort = ViewState["SortColumn"].ToString() + " " + sortDirection;
            ItemMovementGridView.DataSource = dataTable;
            ItemMovementGridView.PageIndex = e.NewPageIndex;
            ItemMovementGridView.DataBind();
        }



        protected void gridView_Sorting(object sender, GridViewSortEventArgs e)
        {
            BindGrid();
            DataTable dataTable = ItemMovementGridView.DataSource as DataTable;

            if (dataTable != null)
            {
                if (e.SortExpression == (string)ViewState["SortColumn"])
                {
                    // We are resorting the same column, so flip the sort direction
                    e.SortDirection =
                        ((SortDirection)ViewState["SortColumnDirection"] == SortDirection.Ascending) ?
                        SortDirection.Descending : SortDirection.Ascending;
                }
                // Apply the sort
                dataTable.DefaultView.Sort = e.SortExpression +
                    (string)((e.SortDirection == SortDirection.Ascending) ? " ASC" : " DESC");
                ViewState["SortColumn"] = e.SortExpression;
                ViewState["SortColumnDirection"] = e.SortDirection;
                ItemMovementGridView.DataSource = dataTable;
                ItemMovementGridView.DataBind();
            }
        }
    }
}