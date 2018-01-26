<%@ Page Title="Products" EnableEventValidation="false" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Items.aspx.cs" Inherits="SmartCode.Items" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <asp:LinqDataSource ID="ItemsDataSource" 
        ContextTypeName="SmartCode.SmartCodeDataContext"
        TableName="Products"
        runat="server" EntityTypeName="" />
    <asp:LinqDataSource ID="SupplierDataSource" 
        ContextTypeName="SmartCode.SmartCodeDataContext" 
        TableName="Suppliers"
        runat="server" EntityTypeName="" />
    <nav class="jumbotron">
        <p>Products</p>
        <nav class="dbtable" style="overflow:scroll;">
            <asp:GridView ID="ProductGridView"
                AllowPaging="True"
                AllowSorting="True"
                runat="server" 
                AutoGenerateColumns="False" 
                DataKeyNames="ProductId"
                AlternatingRowStyle-CssClass="alternaterow" 
                CellPadding="4" 
                CellSpacing="4"
                ForeColor="#333333" 
                GridLines="None" 
                ShowFooter="True" 
                OnRowDataBound="ProductGridView_RowDataBound" 
                OnSelectedIndexChanged="ProductGridView_SelectedIndexChanged" 
                OnRowCreated="ProductGridView_RowCreated" 
                OnPageIndexChanging="ProductGridView_PageIndexChanging" 
                OnSorting="ProductGridView_Sorting" 
                OnRowCommand="ProductGridView_RowCommand" >
                <AlternatingRowStyle CssClass="alternaterow"></AlternatingRowStyle>
                <Columns>
                    <asp:TemplateField ShowHeader="False" HeaderText="ID">
                        <ItemTemplate>
                            <asp:HiddenField ID="ProductId" runat="server" Value='<%# Eval("ProductId") %>' Visible="false"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Barcode" HeaderText="Product Code" SortExpression="Barcode" ItemStyle-Width="175px"/>
                    <asp:BoundField DataField="Description" HeaderText="Short Description" SortExpression="Description" ItemStyle-Width="350px"/>
                    <asp:BoundField DataField="BinLocation" HeaderText="Bin Location" SortExpression="BinLocation" ItemStyle-Width="100px"/>
                    <asp:BoundField DataField="FullDescription" HeaderText="Full Description" SortExpression="FullDescription" ItemStyle-Width="450px"/>
                    <asp:BoundField DataField="SupplierName" HeaderText="Supplier Name" SortExpression="SupplierName" ItemStyle-Width="125px"/>
                    <asp:BoundField DataField="SupplierCode" HeaderText="Supplier Code" SortExpression="SupplierCode" ItemStyle-Width="100px"/>
                    <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" ItemStyle-HorizontalAlign ="Right" ItemStyle-Width="50px"/>
                    <asp:BoundField DataField="UnitOfMeasure" HeaderText="Unit Of Measure" SortExpression="UnitOfMeasure" ItemStyle-Width="100px"/>
                    <asp:BoundField DataField="UnitPrice" HeaderText="Unit Price" SortExpression="UnitPrice" ItemStyle-HorizontalAlign ="Right" ItemStyle-Width="100px"/>
                    <asp:TemplateField ShowHeader="False" HeaderText="Edit">
                        <ItemTemplate>
                            <asp:LinkButton ID="EditButton"
                                            runat="server"
                                            CommandName="EditProduct" 
                                            Text="Edit" ItemStyle-Width="125px"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ShowHeader="False" HeaderText="Delete">
                        <ItemTemplate>
                        <asp:LinkButton ID="DeleteButton"
                                    Text="Delete"
                                    CommandName="DeleteProduct" 
                                    OnClientClick="return confirm('Are you sure you want to delete this user?')"
                                    runat="server" ItemStyle-Width="125px"/>
                        </ItemTemplate>
                    </asp:TemplateField>
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
            <asp:Button ID="btnAddItem" runat="server" Text="Add Product" OnClick="OnClickAddProduct" CssClass="button" />
        </nav>
    </nav>
</asp:Content>
