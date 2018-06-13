<cfquery name="gpn" datasource="webwarecl">
	SELECT clsJobNumber FROM projects WHERE id=#attributes.id#
</cfquery>

<cfoutput query="gpn">#clsJobNumber#</cfoutput>