<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset res = new Prefiniti.Collaboration.Resolution(form.res_id)>
    <cfif session.current_association EQ res.sponsor_assoc_id>
        <cftry>
            <cfif form.confirmation EQ "WITHDRAW">
                <cfif res.withdraw()>
                    <cfset result = {
                        ok: true,
                        message: "Resolution withdrawn."
                    }>
                <cfelse>
                    <cfset result = {
                        ok: false,
                        message: "Resolution withdrawal not permitted."
                    }>
                </cfif>
            <cfelse>
                <cfset result = {
                    ok: false,
                    message: "You must type &quot;WITHDRAW&quot; in the confirmation box."
                }>
            </cfif>
            <cfcatch type="any">
                <cfset result = {
                    ok: false,
                    message: "Error withdrawing resolution."
                }>
            </cfcatch>
        </cftry>
    <cfelse>
        <cfset result = {
            ok: false,
            message: "Only the sponsor of a resolution may withdraw it."
        }>
    </cfif>
</cfsilent>
<cfoutput>#serializeJSON(result)#</cfoutput>