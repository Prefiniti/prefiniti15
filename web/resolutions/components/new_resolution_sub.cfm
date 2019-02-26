<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    <cfset result = {}>

    <cftry>

        <cfset res = new Prefiniti.Collaboration.Resolution()>
       
        <cfset res.site_id = session.current_site_id>
        <cfset res.sponsor_assoc_id = session.current_association>
        <cfset res.res_carry_threshold = form.res_carry_threshold>
        <cfset res.res_quorum = form.res_quorum>
        <cfset res.res_eligibility = form.res_eligibility>
        <cfset res.res_tabled = 0>
        <cfset res.res_voting_open = createODBCDate(form.res_voting_open)>
        <cfset res.res_voting_close = createODBCDate(form.res_voting_close)>
        <cfset res.res_title = form.res_title>
        <cfset res.res_text = form.res_text>
        <cfset res.res_repeals = form.res_repeals>

        <cfset res.save()>

        <cfset eventText = prefiniti.getLongname(session.user.id) & " has drafted a new resolution.">
        <cfset prefiniti.writeUserEvent(session.user.id, "timeline_marker.png", eventText)>
    
        <cfset result.ok = true>
        <cfset result.message = "Resolution has been created.">
        <cfset result.resolution_id = res.id>

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error creating resolution.">  
            <cfset result.error = {message: cfcatch.message, detail: cfcatch.detail}>
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>      