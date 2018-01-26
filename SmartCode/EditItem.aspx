<%@ Page Title="Edit Product" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="EditItem.aspx.cs" Inherits="SmartCode.EditItem" %>
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
        <p>Edit Product</p>
        <nav class="dbtable">
            <table>
                <tr>
                    <td>Product Code</td>
                    <td>
                        <asp:TextBox ID="txtBarcode" runat="server" Width="180px"></asp:TextBox>
                        <asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server"
                          ControlToValidate="txtBarcode"
                          ErrorMessage="Product Code is a required field."
                          ForeColor="Red">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Short Description</td>
                    <td>
                        <asp:TextBox ID="txtDescription" runat="server" Width="180px"></asp:TextBox>
                        <asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server"
                          ControlToValidate="txtDescription"
                          ErrorMessage="Description is a required field."
                          ForeColor="Red">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Bin Location</td>
                    <td>
                        <asp:TextBox ID="txtBinLocation" runat="server" Width="180px"></asp:TextBox>
                        <asp:RequiredFieldValidator id="RequiredFieldValidator3" runat="server"
                          ControlToValidate="txtBinLocation"
                          ErrorMessage="Bin Location is a required field."
                          ForeColor="Red">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Full Description</td>
                    <td><asp:TextBox ID="txtFullDescription" runat="server" Width="180px"></asp:TextBox></td>
                </tr>                
                <tr>
                    <td>Supplier</td>
                    <td>
                        <asp:DropDownList ID="SupplierDropDownList" DataSourceID="SupplierDataSource"
                                DataValueField="Id"
                                DataTextField="SupplierName"
                                AppendDataBoundItems = "true"
                                AutoPostBack="True"
                                runat="server" Width="180px">
                            <asp:ListItem Text="Please select" Value=""/>
                        </asp:DropDownList>
<%--                        <asp:RequiredFieldValidator id="RequiredFieldValidator4" runat="server"
                          ControlToValidate="SupplierDropDownList"
                          ErrorMessage="Supplier is a required field."
                          ForeColor="Red">
                        </asp:RequiredFieldValidator>--%>
                    </td>
                </tr>                
                <tr>
                    <td>Supplier Code</td>
                    <td><asp:TextBox ID="txtSupplierCode" runat="server" Width="180px"></asp:TextBox></td>
                </tr>                
                <%--<tr>
                    <td>Quantity</td>
                    <td>
                        <asp:TextBox ID="txtQuantity" runat="server" Width="180px"></asp:TextBox>
                        <asp:RequiredFieldValidator id="RequiredFieldValidator5" runat="server"
                          ControlToValidate="txtQuantity"
                          ErrorMessage="Quantity is a required field."
                          ForeColor="Red">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>   --%>             
                <tr>
                    <td>Unit Of Measure</td>
                    <td>
                        <asp:TextBox ID="txtUnitOfMeasure" runat="server" Width="180px"></asp:TextBox>
                        <asp:RequiredFieldValidator id="RequiredFieldValidator6" runat="server"
                          ControlToValidate="txtUnitOfMeasure"
                          ErrorMessage="Unit Of Measure is a required field."
                          ForeColor="Red">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>                
                <tr>
                    <td>Unit Price</td>
                    <td>
                        <asp:TextBox ID="txtUnitPrice" runat="server" Width="180px"></asp:TextBox>
                        <asp:RequiredFieldValidator id="RequiredFieldValidator7" runat="server"
                          ControlToValidate="txtUnitPrice"
                          ErrorMessage="Unit Price is a required field."
                          ForeColor="Red">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>
            </table>
            <br />
            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="OnClickSave" CausesValidation="true" CssClass="button" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="OnClickCancel" CausesValidation="false" CssClass="button" />
        </nav>
    </nav>
</asp:Content>
