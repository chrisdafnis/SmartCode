<%@ Page Title="Book In Product" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="BookInItem.aspx.cs" Inherits="SmartCode.BookInItem" %>
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
        <asp:Label ID="lbTitle" runat="server" Text="Search for Product"></asp:Label>
        <nav class="dbtable">
            <table>
                <tr>
                    <td>Product Code</td>
                    <td>
                        <asp:TextBox ID="txtBarcode" runat="server" Width="180px" OnTextChanged="txtBarcode_TextChanged"></asp:TextBox>
                        <asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server"
                          ControlToValidate="txtBarcode"
                          ErrorMessage="Product Code is a required field."
                          ForeColor="Red"> </asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Short Description</td>
                    <td>
                        <asp:TextBox ID="txtDescription" runat="server" Width="180px" Enabled="false"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Location</td>
                    <td>
                        <asp:TextBox ID="txtLocation" runat="server" Width="180px" Enabled="false"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Quantity</td>
                    <td>
                        <asp:TextBox ID="txtQuantity" runat="server" Width="180px" Enabled="false"></asp:TextBox>
                        <asp:RangeValidator ID="RangeValidator1" runat="server" Type="Integer" 
                            MinimumValue="1" MaximumValue="9999999" ControlToValidate="txtQuantity" 
                            ErrorMessage="Value must be a whole number, 1 or greater" ForeColor="Red"></asp:RangeValidator>
                        <asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server"
                          ControlToValidate="txtBarcode"
                          ErrorMessage="Value is a required field."
                          ForeColor="Red"> </asp:RequiredFieldValidator>
                    </td>
                </tr>
            </table>
            <br />
            <asp:Button ID="btSearchForProduct" runat="server" Text="Search" OnClick="OnClickSearchForProduct" CssClass="button" />
            <asp:Button ID="btBookInProduct" runat="server" OnClick="btBookInProduct_Click" Text="Book In" Enabled="false" CssClass="button" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="OnClickCancel" CausesValidation="false" EnableClientScript="False" CssClass="button" />
        </nav>
    </nav>
</asp:Content>
