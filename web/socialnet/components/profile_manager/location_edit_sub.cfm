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

        <cfquery name="udLoc" datasource="webwarecl">
            UPDATE  locations
            SET     description='#form.description#',
                    address='#form.address#',
                    city='#form.city#',
                    state='#form.state#',
                    zip='#form.zip#',
                    <cfif form.billing EQ true>
                        billing=1,
                    <cfelse>
                        billing=0,
                    </cfif>                
                    <cfif form.mailing EQ true>
                        mailing=1,
                    <cfelse>
                        mailing=0,
                    </cfif>
                    <cfif form.public_location EQ true>
                        public_location=1
                    <cfelse>
                        public_location=0
                    </cfif>
            WHERE   id=#form.location_id#
        </cfquery>

        <cfset eventText = prefiniti.getLongname(session.user.id) & " has edited a  " & locationPrivacy & " location in " & prefiniti.getHisHer(session.user.id) & " profile.">
        <cfset prefiniti.writeUserEvent(session.user.id, "map_edit.png", eventText)>

        <cfset result.ok = true>
        <cfset result.message = "Your location information has been updated.">

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error updating your location information (" & cfcatch.message & ")">  
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>