<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset res = new Prefiniti.Collaboration.Resolution(form.res_id)>   

    <cfif res.getPermissionByKey("RES_AMEND", session.current_association)>
        <cftry>
            <cfset res.createAmendment(session.current_association, form.am_title, form.am_text)>
           
            <cfset result = {
                ok: true,
                message: "Amendment proposed."
            }>
            
            <cfcatch type="any">
                <cfset result = {
                    ok: false,
                    message: "Error proposing amendment."
                }>
            </cfcatch>
        </cftry>
    <cfelse>
        <cfset result = {
            ok: false,
            message: "You do not have permission to propose an amendment."
        }>
    </cfif>
</cfsilent>
<cfoutput>#serializeJSON(result)#</cfoutput>