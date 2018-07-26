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

        <cfif form.zXpssa EQ form.zXpssa_confirm>
            <cfif form.zXpssa NEQ session.user.password AND form.zXpssa NEQ hash(session.user.password, "SHA-512")>
                <cfquery name="updatePassword" datasource="webwarecl">
                    UPDATE users 
                    SET password=<cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(form.zXpssa, 'SHA-512')#">,
                        password_question=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.password_question#">,
                        password_answer=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.password_answer#">
                    WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#session.user.id#">
                </cfquery>

                <cfset session.user.password = hash(form.zXpssa, "SHA-512")>
            </cfif>
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
