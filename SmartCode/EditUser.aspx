<%@ Page Title="Edit User" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="EditUser.aspx.cs" Inherits="SmartCode.EditUser" %>
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
        <p>Edit User</p>
        <nav class="dbtable">
            <table>
                <tr>
                    <td>User Name</td>
                    <td>
                        <asp:TextBox ID="txtUsername" runat="server" Width="180px" Enabled="true"></asp:TextBox>
                        <asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server"
                          ControlToValidate="txtUsername"
                          ErrorMessage="User Name is a required field."
                          ForeColor="Red">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Password</td>
                    <td>
                        <asp:TextBox ID="txtPassword" runat="server" Width="180px" Enabled="true"></asp:TextBox>
                        <asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server"
                          ControlToValidate="txtPassword"
                          ErrorMessage="Password is a required field."
                          ForeColor="Red">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>              
                <tr>
                    <td>User Level</td>
                    <td><asp:DropDownList ID="ddlUserLevel" runat="server" Width="180px" Enabled="true"></asp:DropDownList></td>
                </tr>                           
            </table>
            <br />
            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="OnClickSave" CausesValidation="true" CssClass="button" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="OnClickCancel" CausesValidation="false" CssClass="button" />
        </nav>
    </nav>
</asp:Content>
