<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    <cfset result = {}>

    <cftry>
        <cfquery name="addLoc" datasource="webwarecl">
            DELETE FROM locations WHERE id=#form.id#
        </cfquery>

        <cfset eventText = prefiniti.getLongname(session.user.id) & " has removed a location from " & prefiniti.getHisHer(session.user.id) & " profile.">
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