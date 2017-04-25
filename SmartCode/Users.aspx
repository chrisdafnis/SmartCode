<%@ Page Title="Users" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="SmartCode.Users" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <asp:LinqDataSource ID="UsersDataSource" 
        ContextTypeName="SmartCode.SmartCodeDataContext"
        TableName="Securities"
        runat="server" EntityTypeName="" EnableDelete="True" EnableInsert="True" EnableUpdate="True" />
    <nav class="jumbotron">
        <p>Users</p>
        <nav class="dbtable" style="overflow:scroll;">
            <asp:GridView ID="UsersGridView"
                AllowPaging="True"
                AllowSorting="True"
                runat="server" 
                AutoGenerateColumns="False"
                AlternatingRowStyle-CssClass="alternaterow" 
                CellPadding="4"
                CellSpacing="4"
                ForeColor="#333333" 
                GridLines="None" 
                ShowFooter="True" 
                DataSourceID="UsersDataSource" 
                DataKeyNames="UserId" 
                OnRowCommand="UsersGridView_RowCommand" 
                OnRowDataBound="UsersGridView_RowDataBound" >
                <AlternatingRowStyle CssClass="alternaterow"></AlternatingRowStyle>
                <Columns>
                    <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" ItemStyle-Width="125px" />
                    <asp:BoundField DataField="Password" HeaderText="Password" SortExpression="Password" ItemStyle-Width="125px" />
                    <asp:TemplateField HeaderText="User Level" ItemStyle-Width="125px">
                        <ItemTemplate>
                            <asp:Label ID="lblUserLevel" runat="server" Text='<%# Eval("UserLevel")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="CreatedDate" HeaderText="Created Date" readonly="true" SortExpression="CreatedDate" ItemStyle-Width="125px" />
                    <asp:BoundField DataField="LastLoginDate" HeaderText="Last Login Date" readonly="true" SortExpression="LastLoginDate" ItemStyle-Width="125px" />
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="EditButton"
                                            runat="server"
                                            CommandName="EditUser" 
                                            Text="Edit" ItemStyle-Width="125px" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                        <asp:LinkButton ID="DeleteButton"
                                    Text="Delete"
                                    CommandName="DeleteUser" 
                                    OnClientClick="return confirm('Are you sure you want to delete this user?')"
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
            <asp:Button ID="AddUser" runat="server" Text="Add User" OnClick="OnClickAddUser" align="left" CssClass="button"/>
        </nav>
    </nav>
</asp:Content>
