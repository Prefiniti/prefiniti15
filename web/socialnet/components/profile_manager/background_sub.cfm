<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    <cfset result = {}>

    <cftry>
        <cfset interests = form.interests>
        <cfset interests = interests.split(",")>
        <cfset arraySort(interests, "text")>
        <cfset interests = ArrayToList(interests, ",")>

        <cfset music = form.music>
        <cfset music = music.split(",")>
        <cfset arraySort(music, "text")>
        <cfset music = ArrayToList(music, ",")>

        <cfquery name="ubi" datasource="webwarecl">
            UPDATE users
            SET     bio='#form.bio#',
                    background='#form.background#',
                    interests='#interests#',
                    music='#music#'                
            WHERE   id=#session.user.id#
        </cfquery>        

        <cfset eventText = prefiniti.getLongname(session.user.id) & " has updated " & prefiniti.getHisHer(session.user.id) & " background information.">
        <cfset prefiniti.writeUserEvent(session.user.id, "user.png", eventText)>

        <cfset result.ok = true>
        <cfset result.message = "Your background information has been updated.">

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error updating your background information (" & cfcatch.message & ")">  
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>