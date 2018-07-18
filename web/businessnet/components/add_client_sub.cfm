<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>    
    <cfset result = {}>

    <cftry>
        
        <cfif form.new_account EQ 1>
            <cfset accountParams = {
                email: form.email,
                firstName: form.firstName,
                lastName: form.lastName
            }>

            <cfif trim(form.middleInitial) NEQ "">
                <cfset accountParams.middleInitial = form.middleInitial>
            </cfif>

            <cfset account = new Prefiniti.Authentication.UserAccount(accountParams, true)>
        <cfelse>
            <cfset account = prefiniti.getUserByEmail(form.email)>
        </cfif>

        <cfset assoc_id = account.addSiteAssociation(session.current_site_id, "client")>

        <cfset initialPerms = ["AS_LOGIN",
                               "MA_VIEW",
                               "MA_WRITE",                               
                               "WF_VIEW"]>

        <cfloop array="#initialPerms#" item="permKey">
            <cfset account.grantPermission(assoc_id, permKey)>
        </cfloop>                   

        <cfset eventText = prefiniti.getLongname(session.user.id) & " has added a new client.">
        <cfset prefiniti.writeUserEvent(session.user.id, "user_add.png", eventText)>
        <cfset prefiniti.writeUserEvent(account.id, "user_add.png", eventText)>

        <cfset result.ok = true>
        <cfset result.message = "Client has been added.">

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error adding client.">
            <cfset result.tagContext = cfcatch.tagContext> 
            <cfset result.message = cfcatch.message>
            <cfset result.detail = cfcatch.detail> 

            <cfif cfcatch.type EQ "database">
                <cfset result.sql = cfcatch.sql>
            </cfif>
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>