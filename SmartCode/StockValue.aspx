<%@ Page Title="Stock Value" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="StockValue.aspx.cs" Inherits="SmartCode.StockValue" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <nav class="jumbotron">
        <p>Stock Value</p>
        <asp:LinqDataSource ID="StockValueDataSource" 
            ContextTypeName="SmartCode.SmartCodeDataContext" 
            TableName="Products" 
            EnableDelete="True" 
            EnableInsert="True" 
            EnableUpdate="True" 
            runat="server" EntityTypeName="" />
        <nav class="dbtable">
            <asp:GridView ID="StockValueGridView" 
                runat="server" 
                CellPadding="4"
                CellSpacing="4" 
                ForeColor="#333333" 
                GridLines="None" 
                OnRowDataBound="StockValueGridView_RowDataBound" 
                AllowSorting="True" ShowHeader="True" >
                <AlternatingRowStyle CssClass="alternaterow" BackColor="White"></AlternatingRowStyle>
                <EditRowStyle BackColor="#2461BF" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                <SortedDescendingHeaderStyle BackColor="#4870BE" />
            </asp:GridView>
            <asp:GridView ID="TotalValueGridView" 
                runat="server" 
                CellPadding="4"
                CellSpacing="4" 
                ForeColor="#333333" 
                GridLines="None" 
                AllowSorting="True" 
                ShowFooter="False" 
                ShowHeader="True"
                OnRowDataBound="TotalValueGridView_RowDataBound">
                <AlternatingRowStyle CssClass="alternaterow" BackColor="White"></AlternatingRowStyle>
                <EditRowStyle BackColor="#2461BF" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle Font-Bold="True" BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                <SortedDescendingHeaderStyle BackColor="#4870BE" />
            </asp:GridView>
        </nav>
    </nav>
</asp:Content>
