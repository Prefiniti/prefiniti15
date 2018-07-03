<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    <cfset result = {}>

    <cftry>
        <cfif form.public_location>
            <cfset locationPrivacy = "public">
        <cfelse>
            <cfset locationPrivacy = "private">
        </cfif>

        <cfquery name="addLoc" datasource="webwarecl">
            INSERT INTO locations
                (user_id,
                description,
                address,
                city,
                state,
                zip,
                mailing,
                billing,
                public_location)
            VALUES
                (#form.user_id#,        
                '#form.description#',
                '#form.address#',
                '#form.city#',
                '#form.state#',
                '#form.zip#',
                <cfif form.mailing EQ true>
                    1,
                <cfelse>
                    0,
                </cfif>
                <cfif form.billing EQ true>
                    1,
                <cfelse>
                    0,
                </cfif>
                <cfif form.public_location EQ true>
                    1)
                <cfelse>
                    0)
                </cfif>                                    
                
        </cfquery>

        <cfset eventText = prefiniti.getLongname(session.user.id) & " has added a new " & locationPrivacy & " location to " & prefiniti.getHisHer(session.user.id) & " profile.">
        <cfset prefiniti.writeUserEvent(session.user.id, "map.png", eventText)>

        <cfset result.ok = true>
        <cfset result.message = "Your location information has been updated.">

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error updating your location information (" & cfcatch.message & ")">  
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>