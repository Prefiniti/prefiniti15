<cfquery name="cn" datasource="webwarecl">
	SELECT longName FROM Users WHERE id=#attributes.id#
</cfquery>

<cfoutput>#cn.longName#</cfoutput>