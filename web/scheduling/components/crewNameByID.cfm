<cfquery name="cnbid" datasource="webwarecl">
	SELECT name FROM crews WHERE id=#attributes.id#
</cfquery>

<cfoutput query="cnbid">#name#</cfoutput>