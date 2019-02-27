<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset res = new Prefiniti.Collaboration.Resolution(url.id)>
    <cfif session.current_association EQ res.sponsor_assoc_id>
        <cftry>
            <cfset res.res_tabled = 0>
            <cfset res.save()>

            <cfset result = {
                ok: true,
                message: "Resolution reopened."
            }>
            <cfcatch type="any">
                <cfset result = {
                    ok: false,
                    message: "Error reopening resolution."
                }>
            </cfcatch>
        </cftry>
    <cfelse>
        <cfset result = {
            ok: false,
            message: "Only the sponsor of a tabled resolution may reopen it."
        }>
    </cfif>
</cfsilent>
<cfoutput>#serializeJSON(result)#</cfoutput>