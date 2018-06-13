<cfquery name="gc" datasource="webwarecl">
	SELECT name FROM companies WHERE id=#attributes.id#
</cfquery>

<cfoutput>#gc.name#</cfoutput>