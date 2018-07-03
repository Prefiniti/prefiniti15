<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    <cfset result = {}>

    <cftry>
        <cfquery name="ubi" datasource="webwarecl">
            UPDATE users
            SET     phone='#form.phone#',
                    smsNumber='#form.smsNumber#',
                    fax='#form.fax#'
            WHERE   id=#session.user.id# 
        </cfquery>        

        <cfset eventText = prefiniti.getLongname(session.user.id) & " has updated " & prefiniti.getHisHer(session.user.id) & " contact information.">
        <cfset prefiniti.writeUserEvent(session.user.id, "phone.png", eventText)>

        <cfset result.ok = true>
        <cfset result.message = "Your contact information has been updated.">

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error updating your contact information">  
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>