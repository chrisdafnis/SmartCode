<%@ Page Title="Add New Supplier" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AddNewSupplier.aspx.cs" Inherits="SmartCode.AddNewSupplier" %>
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
        <p>Add New Supplier</p>
        <nav class="dbtable">
            <table>
                <tr>
                    <td>Supplier Name</td>
                    <td>
                        <asp:TextBox ID="txtSupplierName" runat="server" Width="180px"></asp:TextBox>
                        <asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server"
                          ControlToValidate="txtSupplierName"
                          ErrorMessage="Supplier Name is a required field."
                          ForeColor="Red">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Address Line 1</td>
                    <td>
                        <asp:TextBox ID="txtAddressLine1" runat="server" Width="180px"></asp:TextBox>
                        <asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server"
                          ControlToValidate="txtAddressLine1"
                          ErrorMessage="Address Line 1 is a required field."
                          ForeColor="Red">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Address Line 2</td>
                    <td>
                        <asp:TextBox ID="txtAddressLine2" runat="server" Width="180px"></asp:TextBox>
                        <asp:RequiredFieldValidator id="RequiredFieldValidator3" runat="server"
                          ControlToValidate="txtAddressLine2"
                          ErrorMessage="Address Line 2 is a required field."
                          ForeColor="Red">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Address Line 3</td>
                    <td><asp:TextBox ID="txtAddressLine3" runat="server" Width="180px"></asp:TextBox></td>
                </tr>                
                <tr>
                    <td>Address Line 4</td>
                    <td><asp:TextBox ID="txtAddressLine4" runat="server" Width="180px"></asp:TextBox></td>
                </tr>                
                <tr>
                    <td>Address Line 5</td>
                    <td><asp:TextBox ID="txtAddressLine5" runat="server" Width="180px"></asp:TextBox></td>
                </tr>                
                <tr>
                    <td>Contact Number</td>
                    <td><asp:TextBox ID="txtContactNumber" runat="server" Width="180px"></asp:TextBox></td>
                </tr>                
                <tr>
                    <td>Email</td>
                    <td><asp:TextBox ID="txtEmail" runat="server" Width="180px"></asp:TextBox></td>
                </tr>                
                <tr>
                    <td>Web Site</td>
                    <td><asp:TextBox ID="txtWebSite" runat="server" Width="180px"></asp:TextBox></td>
                </tr>                
            </table>
            <br />
            <asp:Button ID="btnAddSupplier" runat="server" Text="Add Supplier" OnClick="OnClickAddSupplier" CssClass="button" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="OnClickCancel" CausesValidation="false" CssClass="button" />
        </nav>
    </nav>
</asp:Content>
