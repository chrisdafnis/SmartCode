﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SmartCode
{
    public partial class History : System.Web.UI.Page
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
            if (!IsPostBack)
            {
                ViewState["Filter"] = "ALL";

            }
            BindGrid();
        }

        private void BindGrid()
        {
            try
            {
                SmartCodeDataContext db = new SmartCodeDataContext();
                //var transactions = db.GetAllTransactionHistory(null);
                var transactions = db.GetTransactions().ToList();
                //load the grid
                //var transactions = (from tl in db.TransactionLogs
                //                    select new { tl.Barcode, tl.Product, tl.TransactionType, tl.Quantity, tl.JobNumber, tl.NewLocation, tl.PreviousLocation, tl.DateStamp })
                //                    .OrderByDescending(tl => tl.DateStamp).ToList();//.ToList<GetTransactionsResult>();

                HistoryGridView.DataSource = transactions;
                HistoryGridView.DataBind();

                //BindBarcodesList();
            }
            catch (Exception)
            {

            }
        }

        //private void BindBarcodesList()
        //{
        //    try
        //    {
        //        SmartCodeDataContext db = new SmartCodeDataContext();

        //        DropDownList ddlBarcodes = (DropDownList)HistoryGridView.HeaderRow.FindControl("ddlBarcodes");
        //        // load the ddl with products
        //        var products = (from tr in db.TransactionLogs
        //                        select tr.Barcode).Distinct();

        //        ddlBarcodes.DataSource = products;
        //        ddlBarcodes.DataBind();
        //    }
        //    catch (Exception)
        //    {

        //    }
        //}

        //protected void ddlBarcodes_SelectedItemChanged(object sender, EventArgs e)
        //{
        //    string ddlVal = ((DropDownList)HistoryGridView.HeaderRow.FindControl("ddlBarcodes")).SelectedValue;
        //    BindGridUsingDdl(ddlVal);
        //}

        //private void BindGridUsingDdl(string ddlVal)
        //{
        //    try
        //    {
        //        SmartCodeDataContext db = new SmartCodeDataContext();
        //        if (ddlVal == "ALL")
        //            ddlVal = String.Empty;

        //        var transactions = db.GetAllTransactionHistory(ddlVal);
        //        HistoryGridView.DataSource = transactions.ToList<GetAllTransactionHistoryResult>();
        //        HistoryGridView.DataBind();
        //        BindBarcodesList();
        //        DropDownList ddlBarcodes = (DropDownList)HistoryGridView.HeaderRow.FindControl("ddlBarcodes");
        //        ddlBarcodes.SelectedValue = ddlVal;
        //    }
        //    catch (Exception)
        //    {

        //    }
        //}

        protected void OnPaging(object sender, GridViewPageEventArgs e)
        {
            HistoryGridView.PageIndex = e.NewPageIndex;
            string ddlVal = ((DropDownList)HistoryGridView.HeaderRow.FindControl("ddlBarcodes")).SelectedValue;
            //BindGridUsingDdl(ddlVal);
            BindGrid();
        }

        protected void HistoryGridView_RowDataBound(object sender, GridViewRowEventArgs e)
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
                    case "PIC":
                        {
                            toolTip = "Product Manually Booked In";
                        }
                        break;
                    case "EDI":
                        {
                            toolTip = "Record Edited";
                        }
                        break;
                }
                e.Row.Cells[2].ToolTip = toolTip;
            }
        }

        protected void HistoryGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            ApplyFilter();
            HistoryGridView.PageIndex = e.NewPageIndex;
            HistoryGridView.DataBind();
        }

        protected void HistoryGridView_Sorting(object sender, GridViewSortEventArgs e)
        {
            List<GetTransactionsResult> list = (List<GetTransactionsResult>)HistoryGridView.DataSource;
            DataTable dataTable = new DataTable(typeof(GetAllTransactionHistoryResult).Name);
            PropertyInfo[] Props = typeof(GetTransactionsResult).GetProperties(BindingFlags.Public | BindingFlags.Instance);
            foreach (PropertyInfo prop in Props)
            {
                //Defining type of data column gives proper data table 
                var type = (prop.PropertyType.IsGenericType && prop.PropertyType.GetGenericTypeDefinition() == typeof(Nullable<>) ? Nullable.GetUnderlyingType(prop.PropertyType) : prop.PropertyType);
                //Setting column names as Property names
                dataTable.Columns.Add(prop.Name, type);
            }
            foreach (GetTransactionsResult item in list)
            {
                var values = new object[Props.Length];
                for (int i = 0; i < Props.Length; i++)
                {
                    //inserting property values to datatable rows
                    values[i] = Props[i].GetValue(item, null);
                }
                dataTable.Rows.Add(values);
            }

            DataView dataView = dataTable.DefaultView;

            if (e.SortExpression == (string)HttpContext.Current.Session["SortColumn"])
            {
                // We are resorting the same column, so flip the sort direction
                e.SortDirection =
                    ((SortDirection)HttpContext.Current.Session["SortColumnDirection"] == SortDirection.Ascending) ?
                    SortDirection.Descending : SortDirection.Ascending;
            }
            // Apply the sort
            dataView.Sort = e.SortExpression +
                (string)((e.SortDirection == SortDirection.Ascending) ? " ASC" : " DESC");
            HttpContext.Current.Session["SortColumn"] = e.SortExpression;
            HttpContext.Current.Session["SortColumnDirection"] = e.SortDirection;

            if (dataView != null)
            {
                HistoryGridView.DataSource = dataView;
                HistoryGridView.DataBind();
            }
        }

        protected void ButtonFilter_Click(object sender, EventArgs e)
        {
            ApplyFilter();
        }

        private void ApplyFilter()
        {
            DateTime? fromDate = Convert.ToDateTime(txtFrom.Text);
            DateTime? toDate = Convert.ToDateTime(txtTo.Text + " 23:59:59");
            SmartCodeDataContext db = new SmartCodeDataContext();
            var transactions = db.GetTransactionHistoryPeriod(fromDate, toDate).ToList();
            DataTable dataTable = LINQResultToDataTable(transactions);
            HistoryGridView.DataSource = dataTable;
            HistoryGridView.DataBind();
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

        protected void ButtonClearFilter_Click(object sender, EventArgs e)
        {
            txtFrom.Text = String.Empty;
            txtTo.Text = String.Empty;
            BindGrid();

        }
    }
}