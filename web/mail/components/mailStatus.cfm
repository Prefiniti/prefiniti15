<cfquery name="urc" datasource="webwarecl">
    SELECT * FROM messageInbox WHERE touser=#url.calledByUser# AND tread='no'
</cfquery>
	
<cfif #urc.RecordCount# NEQ 0><a href="javascript:viewMailFolder('inbox')"><img src="/centerlineservices/graphics/email.png" border="0" align="absmiddle"/></a></cfif>
