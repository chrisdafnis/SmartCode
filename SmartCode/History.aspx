<%@ Page Title="History" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="History.aspx.cs" Inherits="SmartCode.History" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %> 
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <asp:LinqDataSource ID="ItemsDataSource" 
        ContextTypeName="SmartCode.SmartCodeDataContext"
        TableName="Products"
        EnableUpdate="True"
        EnableDelete="True"
        runat="server" EntityTypeName="" EnableInsert="True" />
            <asp:LinqDataSource ID="SupplierDataSource" runat="server" ContextTypeName="SmartCode.SmartCodeDataContext" EntityTypeName="" TableName="Suppliers">
            </asp:LinqDataSource>
        <nav class="jumbotron">
            <p>
            <asp:Label ID="lblTitle" runat="server" Text="Label">Transaction History</asp:Label>
            <nav class="normal">
                <asp:Label ID="lblFilterPeriod" runat="server" Text="Label" CssClass="Label">Filter Period</asp:Label><br ID="break"/>
                <asp:Label ID="Label1" runat="server" Text="Label" CssClass="Label">From:</asp:Label><asp:TextBox ID="txtFrom" runat="server" Width="150px" CssClass="TextBox"/>  
                <cc1:CalendarExtender ID="CalendarFrom" PopupButtonID="imgPopup" runat="server" TargetControlID="txtFrom" Format="dd/MM/yyyy" />  
                <asp:Label ID="Label2" runat="server" Text="Label" CssClass="Label">To:</asp:Label><asp:TextBox ID="txtTo" runat="server"  Width="150px" CssClass="TextBox"/>  
                <cc1:CalendarExtender ID="CalendarTo" PopupButtonID="imgPopup" runat="server" TargetControlID="txtTo" Format="dd/MM/yyyy" />  
                <br />
                <asp:Button ID="ButtonFilter" runat="server" Text="Filter" OnClick="ButtonFilter_Click" CssClass="button" />
                <asp:Button ID="ButtonClearFilter" runat="server" Text="Clear" OnClick="ButtonClearFilter_Click" CssClass="button" />
            </nav>
            <nav class="dbtable" style="overflow:scroll;">
                <asp:GridView ID="HistoryGridView"
                    AllowPaging="True"
                    AllowSorting="True"
                    runat="server" 
                    AutoGenerateColumns="False" 
                    AlternatingRowStyle-CssClass="alternaterow" 
                    CellPadding="4" 
                    CellSpacing="4"
                    ForeColor="#333333" 
                    GridLines="None" 
                    ShowFooter="True" OnRowDataBound="HistoryGridView_RowDataBound" OnPageIndexChanging="HistoryGridView_PageIndexChanging" OnSorting="HistoryGridView_Sorting" >
                    <AlternatingRowStyle CssClass="alternaterow"></AlternatingRowStyle>
                    <Columns>
                        <asp:BoundField DataField="Barcode" HeaderText="Product Code" SortExpression="Barcode" ItemStyle-Width="175px"/>
                        <asp:BoundField DataField="Product" HeaderText="Description" SortExpression="Product" ItemStyle-Width="350px"/>
                        <asp:BoundField DataField="TransactionType" HeaderText="Transaction Type" SortExpression="TransactionType" ItemStyle-Width="100px"/>
                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" ItemStyle-HorizontalAlign ="Right" ItemStyle-Width="50px"/>
                        <asp:BoundField DataField="JobNumber" HeaderText="Job Number" SortExpression="JobNumber" ItemStyle-Width="75px"/>
                        <asp:BoundField DataField="DateStamp" HeaderText="DateStamp" SortExpression="DateStamp" ItemStyle-Width="175px"/>
                        </Columns>
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
            </nav>
        </nav>
</asp:Content>
