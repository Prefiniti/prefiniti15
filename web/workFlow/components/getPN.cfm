<cfparam name="nextPN" default="">

<cfquery name="getHighPN" datasource="webwarecl">
	SELECT MAX(MID(clsJobNumber, 8, 3)) AS JN FROM projects WHERE site_id=#url.current_site_id#
</cfquery>


<cfif #getHighPN.JN# EQ "">
	<cfset nextPN="001">
<cfelse>
	<cfoutput query="getHighPN">
		<cfset nextPN=#JN# + 1>
	</cfoutput>
</cfif>

<cfset nextPN='WFP-OD-#nextPN#-#DateFormat(Now(), "yymmdd")#-S#url.current_site_id#'>

<cfoutput>#nextPN#</cfoutput>