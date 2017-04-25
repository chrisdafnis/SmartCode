<%@ Page Title="View Product" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="ViewItem.aspx.cs" Inherits="SmartCode.ViewItem" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <asp:LinqDataSource ID="ItemsDataSource" 
        ContextTypeName="SmartCode.SmartCodeDataContext"
        TableName="Products"
        EnableUpdate="True"
        EnableInsert="True" 
        EnableDelete="True"
        runat="server" EntityTypeName="" />
    <asp:LinqDataSource ID="SupplierDataSource" 
        ContextTypeName="SmartCode.SmartCodeDataContext" 
        TableName="Suppliers"
        runat="server" EntityTypeName="" />
    <nav class="jumbotron">
        <p>View Product</p>
        <nav class="dbtable">
            <table>
                <tr>
                    <td>Product Code</td>
                    <td><asp:TextBox ID="txtBarcode" runat="server" Width="180px" Enabled="False"></asp:TextBox></td>
                    <td></td>
                    <td>Short Description</td>
                    <td><asp:TextBox ID="txtDescription" runat="server" Width="180px" Enabled="False"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Bin Location</td>
                    <td><asp:TextBox ID="txtBinLocation" runat="server" Width="180px" Enabled="False"></asp:TextBox></td>
                    <td></td>
                     <td>Full Description</td>
                    <td><asp:TextBox ID="txtFullDescription" runat="server" Width="180px" Enabled="False"></asp:TextBox></td>
                </tr>              
                <tr>
                    <td>Supplier</td>
                    <td><asp:TextBox ID="txtSupplier" runat="server" Width="180px" Enabled="False"></asp:TextBox></td>
                    <td></td>
                    <td>Supplier Code</td>
                    <td><asp:TextBox ID="txtSupplierCode" runat="server" Width="180px" Enabled="False"></asp:TextBox></td>
                </tr>                           
                <tr>
                    <td>Unit Price</td>
                    <td><asp:TextBox ID="txtUnitPrice" runat="server" Width="180px" Enabled="False"></asp:TextBox></td>
                    <td></td>
                    <td>Unit Of Measure</td>
                    <td><asp:TextBox ID="txtUnitOfMeasure" runat="server" Width="180px" Enabled="False"></asp:TextBox></td>
                </tr>
                <tr>
                    <td><asp:Button ID="btnPrintLabel" runat="server" Text="Print Label" CssClass="button" /></td>
                </tr>
            </table>
        </nav>
        <p>Product Locations</p>
        <nav class="dbtable">
            <table>
                <tr>
                    <td>
                        <asp:GridView ID="ProductLocationsGridView" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" OnRowDataBound="ProductLocationsGridView_RowDataBound" Width="218px">
                            <AlternatingRowStyle BackColor="White" />
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
                            <Columns>
                                <asp:BoundField DataField="LocationCode" HeaderText="Location" />
                                <asp:BoundField DataField="LocationType" HeaderText="Type" />
                                <asp:BoundField DataField="Quantity" HeaderText="Quantity" ItemStyle-HorizontalAlign ="Right"/>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
            </table>
            <br />
        </nav>
        <p>Product History</p>
        <nav class="dbtable">
            <table>
                <tr>
                    <td>
                        <asp:GridView ID="ItemHistoryGridView" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" OnRowDataBound="ItemHistoryGridView_RowDataBound">
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
                    </td>
                </tr>
            </table>
            <br />
            <asp:Button ID="btnOK" runat="server" Text="OK" OnClick="OnClickOK" CausesValidation="false" CssClass="button" />
        </nav>
    </nav>
</asp:Content>
