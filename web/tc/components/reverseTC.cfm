
<cfquery name="ap" datasource="webwarecl">
	UPDATE time_card SET closed=0 WHERE id=#url.id#
</cfquery>

<cfmodule template="/tc/components/tcStatus.cfm" id="#url.id#">