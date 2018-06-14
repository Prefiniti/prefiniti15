<cfquery name="u" datasource="webwarecl">
	SELECT longName FROM users WHERE id=#attributes.id#
</cfquery>

<cfoutput query="u">#longName#</cfoutput>
