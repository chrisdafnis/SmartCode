<%@ Page Title="Suppliers" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Suppliers.aspx.cs" Inherits="SmartCode.Suppliers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <nav class="jumbotron">
        <p>Suppliers</p>
        <asp:LinqDataSource ID="SupplierDataSource" 
            ContextTypeName="SmartCode.SmartCodeDataContext" 
            TableName="Suppliers" 
            EnableDelete="True" 
            EnableInsert="True" 
            EnableUpdate="True" 
            runat="server" EntityTypeName="" />
        <nav class="dbtable">
            <asp:GridView ID="SupplierGridView" 
                runat="server" 
                CellPadding="4"
                CellSpacing="4" 
                ForeColor="#333333" 
                GridLines="None" 
                OnRowDataBound="SupplierGridView_RowDataBound" 
                AllowPaging="True" 
                AllowSorting="True" 
                ShowFooter="True" 
                AutoGenerateColumns="False" 
                DataSourceID="SupplierDataSource"
                DataKeyNames="Id" 
                OnSelectedIndexChanged="OnClickAddSupplier" 
                OnRowCommand="SupplierGridView_RowCommand">
                <AlternatingRowStyle CssClass="alternaterow" BackColor="White"></AlternatingRowStyle>
                <Columns>
                    <asp:BoundField DataField="SupplierName" HeaderText="Supplier Name" SortExpression="SupplierName" ItemStyle-Width="125px" />
                    <asp:BoundField DataField="AddressLine1" HeaderText="Address Line 1" SortExpression="AddressLine1" ItemStyle-Width="125px" />
                    <asp:BoundField DataField="AddressLine2" HeaderText="Address Line 2" SortExpression="AddressLine2" ItemStyle-Width="125px" />
                    <asp:BoundField DataField="AddressLine3" HeaderText="Address Line 3" SortExpression="AddressLine3" ItemStyle-Width="125px" />
                    <asp:BoundField DataField="AddressLine4" HeaderText="Address Line 4" SortExpression="AddressLine4" ItemStyle-Width="125px" />
                    <asp:BoundField DataField="AddressLine5" HeaderText="Address Line 5" SortExpression="AddressLine5" ItemStyle-Width="125px" />
                    <asp:BoundField DataField="ContactNo" HeaderText="Contact Number" SortExpression="ContactNo" ItemStyle-Width="125px" />
                    <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" ItemStyle-Width="125px" />
                    <asp:BoundField DataField="WebSite" HeaderText="Web Site" SortExpression="WebSite" ItemStyle-Width="125px" />
                    <%--<asp:HyperLinkColumn DataField="WebSite" HeaderText="Web Site" SortExpression="WebSite" ItemStyle-Width="125px" />--%>
                    <asp:TemplateField ShowHeader="False" HeaderText="Edit">
                        <ItemTemplate>
                            <asp:LinkButton ID="EditButton"
                                            runat="server"
                                            CommandName="EditSupplier" 
                                            Text="Edit" 
                                            ItemStyle-Width="125px"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ShowHeader="False" HeaderText="Delete">
                        <ItemTemplate>
                        <asp:LinkButton ID="DeleteButton"
                                    Text="Delete"
                                    CommandName="DeleteSupplier" 
                                    OnClientClick="return confirm('Are you sure you want to delete this supplier?')"
                                    runat="server" ItemStyle-Width="125px" />
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
            <asp:Button ID="btnAddSupplier" runat="server" Text="Add Supplier" OnClick="OnClickAddSupplier" CssClass="button" />
        </nav>
    </nav>
</asp:Content>
