<%@ Page Title="Add New User" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AddNewUser.aspx.cs" Inherits="SmartCode.AddNewUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <asp:LinqDataSource ID="ItemsDataSource" 
        ContextTypeName="SmartCode.SmartCodeDataContext"
        TableName="Securities"
        EnableUpdate="True"
        EnableInsert="True" 
        EnableDelete="True"
        runat="server" EntityTypeName="" />
    <nav class="jumbotron">
        <p>Add New User</p>
        <nav class="dbtable">
            <table>
                <tr>
                    <td>User Name</td>
                    <td>
                        <asp:TextBox ID="txtUserName" runat="server" Width="180px"></asp:TextBox>
                        <asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server"
                          ControlToValidate="txtUserName"
                          ErrorMessage="User Name is a required field."
                          ForeColor="Red">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Password</td>
                    <td>
                        <asp:TextBox ID="txtPassword" runat="server" Width="180px"></asp:TextBox>
                        <asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server"
                          ControlToValidate="txtPassword"
                          ErrorMessage="Password is a required field."
                          ForeColor="Red">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>UserLevel</td>
                    <td>
                        <asp:DropDownList ID="ddlUserLevel" runat="server" Width="180px"></asp:DropDownList>
                        <asp:RequiredFieldValidator id="RequiredFieldValidator3" runat="server"
                          ControlToValidate="ddlUserLevel"
                          ErrorMessage="User Level is a required field."
                          ForeColor="Red">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>    
            </table>
            <br />
            <asp:Button ID="btnAddUser" runat="server" Text="Add User" OnClick="OnClickAddUser" CssClass="button" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="OnClickCancel" CausesValidation="false" CssClass="button" />
        </nav>
    </nav>
</asp:Content>
