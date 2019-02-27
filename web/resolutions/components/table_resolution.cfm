<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset res = new Prefiniti.Collaboration.Resolution(url.id)>
    <cfif session.current_association EQ res.sponsor_assoc_id>
        <cftry>

            <cfset res.res_tabled = 1>
            <cfset res.save()>

            <cfset result = {
                ok: true,
                message: "Resolution tabled."
            }>
            <cfcatch type="any">
                <cfset result = {
                    ok: false,
                    message: "Error tabling resolution."
                }>
            </cfcatch>
        </cftry>
    <cfelse>
        <cfset result = {
            ok: false,
            message: "Only the sponsor of a resolution may table it."
        }>
    </cfif>
</cfsilent>
<cfoutput>#serializeJSON(result)#</cfoutput>