<cfheader name="Content-Type" value="application/json">
<cfset prefiniti = new Prefiniti.Base()>

<cftry>

    <cfquery name="chkTimeDep" datasource="webwarecl">
        SELECT id FROM pm_time_entries WHERE task_code_id=#url.id#
    </cfquery>

    <cfquery name="chkTravelDep" datasource="webwarecl">
        SELECT id FROM pm_travel_entries WHERE task_code_id=#url.id#
    </cfquery>

    <cfset timeDependencies = chkTimeDep.recordCount>
    <cfset travelDependencies = chkTravelDep.recordCount>

    <cfif timeDependencies EQ 0 AND travelDependencies EQ 0>
        <cfquery name="deleteTaskCode" datasource="webwarecl">
            DELETE FROM task_codes WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#url.id#">
        </cfquery>

        <cfset result = {
            ok: true,
            message: "Service changes saved."
        }>
    <cfelse>
        <cfset errMsg = "Cannot delete service: in use by #timeDependencies# time log entries and #travelDependencies# travel log entries.">

        <cfset result = {
            ok: false,
            message: errMsg
        }>
    </cfif>

    <cfcatch type="any">
        <cfset result = {
            ok: false,
            message: "Error saving service changes."
        }>

    </cfcatch>
</cftry>

<cfoutput>#serializeJSON(result)#</cfoutput>