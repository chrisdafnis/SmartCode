<%@ Page Title="Product Movement" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="ItemMovement.aspx.cs" Inherits="SmartCode.ItemMovement" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>  

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <link rel="stylesheet" href="/Content/print.css" type="text/css" media="print" />
    <script type="text/javascript">
        function Print() {
            window.print();
        }
    </script>
    <nav class="jumbotron">
        <p>
            <asp:Label ID="lblTitle" runat="server" Text="Label">Product Movement</asp:Label>
        <p>
            <span style="font-size:14px;"><asp:DropDownList ID="ddlItem" runat="server" Width="250px" CssClass="DropDown" AutoPostBack="True"></asp:DropDownList></span>
        </p>

        <nav class="normal">
            <asp:Label ID="lblSearchPeriod" runat="server" Text="Label" CssClass="Label">Search Period</asp:Label><br ID="break"/>
            <asp:Label ID="Label1" runat="server" Text="Label" CssClass="Label">From:</asp:Label><asp:TextBox ID="txtFrom" runat="server" Width="150px" CssClass="TextBox"/>  
            <cc1:CalendarExtender ID="CalendarFrom" PopupButtonID="imgPopup" runat="server" TargetControlID="txtFrom" Format="dd/MM/yyyy" />  
            <asp:Label ID="Label2" runat="server" Text="Label" CssClass="Label">To:</asp:Label><asp:TextBox ID="txtTo" runat="server"  Width="150px" CssClass="TextBox"/>  
            <cc1:CalendarExtender ID="CalendarTo" PopupButtonID="imgPopup" runat="server" TargetControlID="txtTo" Format="dd/MM/yyyy" />  
        </nav>
        <br />
        <asp:Button ID="ButtonSearch" runat="server" Text="Search" OnClick="ButtonSearch_Click" CssClass="button" />

        <div class="dbtable" id="divPrint">
            <asp:GridView ID="ItemMovementGridView" 
                runat="server" 
                CellPadding="4"
                CellSpacing="4" 
                ForeColor="#333333" 
                GridLines="None" 
                AllowPaging="True" 
                AllowSorting="True" 
                DataKeyNames="ProductId" AutoGenerateColumns="False">
                <AlternatingRowStyle CssClass="alternaterow" BackColor="White"></AlternatingRowStyle>
                <Columns>
                    <asp:BoundField DataField="ProductId" HeaderText="ProductId" InsertVisible="False" ReadOnly="True" SortExpression="ProductId" Visible="false" />
                    <asp:BoundField DataField="Barcode" HeaderText="Barcode" SortExpression="Barcode" />
                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                    <asp:BoundField DataField="TransactionType" HeaderText="Action" SortExpression="TransactionType" />
                    <asp:BoundField DataField="JobNumber" HeaderText="JobNumber" SortExpression="JobNumber" />
                    <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                    <asp:BoundField DataField="UpdatedQuantity" HeaderText="Updated Quantity" ReadOnly="True" SortExpression="UpdatedQuantity" />
                    <asp:BoundField DataField="DateStamp" HeaderText="DateStamp" SortExpression="DateStamp" />
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
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SmartCodeConnectionString %>" SelectCommand="GetProductMovements" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:Parameter Name="ID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:LinqDataSource ID="LinqDataSource1" runat="server" EntityTypeName="">
            </asp:LinqDataSource>
        </div>
        <asp:Button ID="btnPrint" runat="server" Text="Print" OnClientClick="Print()" CssClass="button" value="Print" />
    </nav>
</asp:Content>
