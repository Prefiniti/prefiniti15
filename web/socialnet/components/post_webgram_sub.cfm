<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    <cfset result = {}>

    <cftry>
        <cfquery name="pwg" datasource="webwarecl">
            INSERT INTO webgrams
                (user_id,
                w_body,
                post_date)
            VALUES
                (#session.user.id#,
                '#form.webgram_body#',
                #CreateODBCDateTime(Now())#)        
        </cfquery>     

        <cfset eventText = prefiniti.getLongname(session.user.id) & " has posted a new WebGram.">
        <cfset prefiniti.writeUserEvent(session.user.id, "user.png", eventText)>

        <cfset result.ok = true>
        <cfset result.message = "WebGram has been posted.">

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error posting WebGram.">  
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>