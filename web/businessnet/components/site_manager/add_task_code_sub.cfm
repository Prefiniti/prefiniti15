<cfheader name="Content-Type" value="application/json">
<cfset prefiniti = new Prefiniti.Base()>

<cftry>

    <cfif isDefined("form.billable")>
        <cfset bill = 1>
    <cfelse>
        <cfset bill = 0>
    </cfif>

    <cfquery name="addTaskCode" datasource="webwarecl">
        INSERT INTO task_codes
            (site_id,
            task_id,
            item,
            rate,
            charge_type,
            billable)
        VALUES
            (<cfqueryparam cfsqltype="cf_sql_bigint" value="#session.current_site_id#">,
            <cfqueryparam cfsqltype="cf_sql_integer" value="#form.task_id#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.item#" maxlength="255">,
            <cfqueryparam cfsqltype="cf_sql_float" value="#form.rate#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.charge_type#" maxlength="45">,
            <cfqueryparam cfsqltype="cf_sql_tinyint" value="#bill#">)
    </cfquery>

    <cfset result = {
        ok: true,
        message: "Service #form.item# has been added."
    }>

    <cfcatch type="any">
        <cfset result = {
            ok: false,
            message: "Error adding service #form.item#."
        }>

    </cfcatch>
</cftry>

<cfoutput>#serializeJSON(result)#</cfoutput>