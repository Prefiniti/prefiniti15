<cfif url.box EQ "inbox">
	<cfquery name="dm" datasource="webwarecl">
		UPDATE messageinbox SET deleted_inbox=1 WHERE id=#url.id#
	</cfquery>
<cfelse>
	<cfquery name="dm" datasource="webwarecl">
		UPDATE messageinbox SET deleted_outbox=1 WHERE id=#url.id#
	</cfquery>            
</cfif>    