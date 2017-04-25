<%@ Page Title="Search" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="SmartCode.Search" %>
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
    <asp:LinqDataSource ID="UserDataSource" 
        ContextTypeName="SmartCode.SmartCodeDataContext" 
        TableName="Security"
        runat="server" EntityTypeName="" />
    <nav class="jumbotron">
        <p>Search</p>
        <nav class="dbtable">
            <table>
                <tr>
                    <td>Search Type</td>
                    <td>
                        <asp:DropDownList ID="ddlSearchType" runat="server" Width="180px" Enabled="true"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>Search Text</td>
                    <td>
                        <asp:TextBox ID="txtSearchText" runat="server" Width="180px" Enabled="true"></asp:TextBox>
                        <asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server"
                          ControlToValidate="txtSearchText"
                          ErrorMessage="Search Text is a required field."
                          ForeColor="Red">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>                                       
            </table>
            <br />
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="OnClickSearch" CausesValidation="true" CssClass="button" />
            <br />
            <br />
            <p class="h4">Search Results</p>
            <asp:GridView ID="GridViewSearchResults" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">
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
            </asp:GridView>
        </nav>
    </nav>
</asp:Content>
