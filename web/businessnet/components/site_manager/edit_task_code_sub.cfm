<cfheader name="Content-Type" value="application/json">
<cfset prefiniti = new Prefiniti.Base()>

<cftry>

    <cfif isDefined("form.billable")>
        <cfset bill = 1>
    <cfelse>
        <cfset bill = 0>
    </cfif>

    <cfquery name="editTaskCode" datasource="webwarecl">
        UPDATE task_codes
        SET task_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#form.task_id#">,
            item=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.item#" maxlength="255">,
            rate=<cfqueryparam cfsqltype="cf_sql_float" value="#form.rate#">,
            charge_type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.charge_type#" maxlength="45">,
            billable=<cfqueryparam cfsqltype="cf_sql_tinyint" value="#bill#">
        WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#form.service_id#">
    </cfquery>

    <cfset result = {
        ok: true,
        message: "Service changes saved."
    }>

    <cfcatch type="any">
        <cfset result = {
            ok: false,
            message: "Error saving service changes."
        }>

    </cfcatch>
</cftry>

<cfoutput>#serializeJSON(result)#</cfoutput>