<cfquery name="gpn" datasource="webwarecl">
	SELECT address, city, state, zip FROM projects WHERE id=#attributes.id#
</cfquery>

<cfoutput query="gpn">#address#<br />#city#, #state#  #zip#</cfoutput>