<cfquery name="cn" datasource="webwarecl">
	SELECT longName FROM Users WHERE id=#attributes.id#
</cfquery>

<cfoutput><a href="##" onmouseover="userDropDown(this, event, #attributes.id#, '#cn.longName#');">#cn.longName#</a></cfoutput>