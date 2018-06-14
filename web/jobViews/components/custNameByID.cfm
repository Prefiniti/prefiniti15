<cfquery name="cn" datasource="webwarecl">
	SELECT longName FROM users WHERE id=#attributes.id#
</cfquery>

<cfoutput>#cn.longName#</cfoutput>