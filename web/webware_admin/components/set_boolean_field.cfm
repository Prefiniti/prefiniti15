<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset result = {}>
    <cftry>
        <cfif session.user.webware_admin NEQ 1>
            <cfthrow message="Permission denied" detail="Must be Global Administrator">
        </cfif>

        <cfquery name="update_user" datasource="webwarecl">
            UPDATE users SET #url.field_name#=#url.field_value# WHERE id=#url.user_id#
        </cfquery>

        <cfset result.ok = true>
        <cfset result.message = "Set field '#url.field_name#' = '#url.field_value#' for user ID #url.user_id#">

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = cfcatch.detail>
            <cfset result.error = {message: cfcatch.message, detail: cfcatch.detail}>
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJSON(result)#</cfoutput>