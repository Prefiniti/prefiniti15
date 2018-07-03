<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    <cfset result = {}>

    <cftry>
        <cfif form.allowSearch EQ "true">
            <cfquery name="updatePrivacy" datasource="webwarecl">
                UPDATE users SET allowSearch=1 WHERE id=#session.user.id#
            </cfquery>
        <cfelse>
            <cfquery name="updatePrivacy" datasource="webwarecl">
                UPDATE users SET allowSearch=0 WHERE id=#session.user.id#
            </cfquery> 
        </cfif>            

        <cfset eventText = prefiniti.getLongname(session.user.id) & " has updated " & prefiniti.getHisHer(session.user.id) & " privacy settings.">
        <cfset prefiniti.writeUserEvent(session.user.id, "user.png", eventText)>

        <cfset result.ok = true>
        <cfset result.message = "Your privacy information has been updated.">

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error updating your privacy information">  
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>                                
