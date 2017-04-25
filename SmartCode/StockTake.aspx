<%@ Page Title="Stock Take" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="StockTake.aspx.cs" Inherits="SmartCode.StockTake" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <nav class="jumbotron">
        <p>Stock Take Transactions - Pending<asp:LinqDataSource ID="PendingLinqDataSource" runat="server" ContextTypeName="SmartCode.SmartCodeDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="PendingStockTakes" OrderBy="ProductId, Datestamp">
            </asp:LinqDataSource>
            <asp:LinqDataSource ID="ProductLinqDataSource" runat="server" ContextTypeName="SmartCode.SmartCodeDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="Products">
            </asp:LinqDataSource>
        </p>
        <style type="text/css">
          .hiddencol
          {
            display: none;
          }
        </style>

        <nav class="dbtable">
            <asp:GridView ID="PendingGridView" 
                runat="server" 
                AllowPaging="True" 
                AllowSorting="True" 
                AutoGenerateColumns="False" 
                CellPadding="4" 
                CellSpacing="4"
                DataKeyNames="Id,ProductId,LocationId" 
                ForeColor="#333333" 
                GridLines="None" 
                OnDataBound="PendingGridView_DataBound" 
                OnSelectedIndexChanged="PendingGridView_DataBound"
                OnRowDataBound="PendingGridView_RowDataBound">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" ItemStyle-CssClass="hiddencol" SortExpression="Id" ReadOnly="True" InsertVisible="False" ItemStyle-Width="125px">
                    </asp:BoundField>
                    <asp:BoundField DataField="ProductId" HeaderText="ProductId" ItemStyle-CssClass="hiddencol" SortExpression="ProductId" ItemStyle-Width="125px">
                    </asp:BoundField>
                    <asp:BoundField DataField="Barcode" HeaderText="Product Code" SortExpression="Barcode" ItemStyle-Width="125px" />
                    <asp:BoundField DataField="LocationCode" HeaderText="Location" SortExpression="LocationCode" ItemStyle-Width="125px" />
                    <asp:BoundField DataField="Quantity" HeaderText="Quantity In Location" SortExpression="Quantity" ItemStyle-HorizontalAlign ="Right" ItemStyle-Width="125px" />
                    <asp:BoundField DataField="QuantityInST" HeaderText="Quantity In Stock Take" SortExpression="QuantityInST" ItemStyle-HorizontalAlign ="Right" ItemStyle-Width="125px" />
                    <asp:templatefield HeaderText="Actual Value">
                        <itemtemplate>
                            <asp:TextBox ID="actualValue" runat="server" ItemStyle-Width="125px"></asp:TextBox>
                        </itemtemplate>
                    </asp:templatefield>
                    <asp:BoundField DataField="Datestamp" HeaderText="Datestamp" SortExpression="Datestamp" ItemStyle-Width="125px"/>
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
            <br />
            <asp:Button ID="btnGetSelected" runat="server" Text="Update" OnClick="OnClickUpdatePending" CssClass="button" />
        </nav>
    </nav>
</asp:Content>
