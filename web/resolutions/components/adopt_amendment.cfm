<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset res = new Prefiniti.Collaboration.Resolution(url.res_id)>

    <cfset result = res.adoptAmendment(url.amendment_id)>
</cfsilent>
<cfoutput>#serializeJSON(result)#</cfoutput> 