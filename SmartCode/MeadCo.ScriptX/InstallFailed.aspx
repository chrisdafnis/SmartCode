<%@ Page Title="MeadCo's ScriptX Failed to Install" Language="C#" MasterPageFile="~/Site.master" %>

<%@ Register src="installFailUI.ascx" tagname="installFailUI" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <div class="jumbotron">
        <h1>Application Printing</h1>
        <p class="lead">This application requires MeadCo's Scriptx Add-on for Internet Explorer in order to print successfully.</p>
    </div>

	<p id="InstallStarting"><br>Please wait for the download of ScriptX ... <br><br>
	Once you have accepted the software update and it has been installed you can close this page.<br>
        <br>
	</p>

    <uc1:installFailUI ID="installFailUI1" runat="server" LoadingElementID="InstallStarting" SuccessElementID="Content" OnSuccess="installedOK" />
  
    <div id="Content" style="display:none">
    	<p id="cont" style="font-weight: bold;"><b>ScriptX v<span id="sxversion"></span></b> has successfully been installed on your machine.</p>         
        <% if ( Request.UrlReferrer != null ) { %>
            <p><a class="btn btn-default" href="<%= Request.UrlReferrer.AbsoluteUri%>">Continue &raquo;</a></p>
        <% } else { %>
            <p><button class="btn btn-primary" onclick="window.close(); return false;">Close</button></p>
        <% } %>
    </div>

<script type="text/javascript">
    //<![CDATA[
    function installedOK() {
        document.getElementById('sxversion').innerText = MeadCo.ScriptX.ScriptXVersion();
    }
    //]]>
</script>

</asp:Content>

