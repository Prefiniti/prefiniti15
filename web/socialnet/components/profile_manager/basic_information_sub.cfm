<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    <cfset result = {}>

    <cfset form.middleInitial = trim(form.middleInitial)>

    <cftry>
        <cfquery name="ubi" datasource="webwarecl">
        	UPDATE users
           	SET		firstName='#form.firstName#',
            		middleInitial='#form.middleInitial#',
                    lastName='#form.lastName#',
                    <cfif form.middleInitial EQ "">
        				longName='#form.firstName# #form.lastName#',
                    <cfelse>
        				longName='#form.firstName# #form.middleInitial#. #form.lastName#',
        			</cfif>
                    gender='#form.gender#',
                    birthday=#CreateODBCDate(form.birthday)#,
                    remember_page=#form.remember_page#,
                    <cfif NOT isDefined("form.show_tour")>
                        show_tour=0,
                    <cfelse>
                        show_tour=1,
                    </cfif>
                    maps_username="#form.maps_username#",
                    maps_password="#hash(form.maps_password, "SHA-256")#"
        	WHERE	id=#session.user.id#
        </cfquery>        

        <cfset eventText = prefiniti.getLongname(session.user.id) & " has updated " & prefiniti.getHisHer(session.user.id) & " identity information.">
        <cfset prefiniti.writeUserEvent(session.user.id, "user.png", eventText)>

        <cfset result.ok = true>
        <cfset result.message = "Your identity information has been updated.">

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error updating your identity information (" & cfcatch.message & cfcatch.detail & ")">  
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>                                