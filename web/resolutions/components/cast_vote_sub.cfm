<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    <cfset result = {}>

    <cftry>

        <cfset res = new Prefiniti.Collaboration.Resolution(form.res_id)>
        <cfset t = res.castVote(session.current_association, form.voter_password, form.vote_type)>
    
        <cfset result.ok = t.success>
        <cfset result.message = t.message>
       
        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = cfcatch.message & " " & cfcatch.detail>  
            <cfset result.error = {message: cfcatch.message, detail: cfcatch.detail}>
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>      