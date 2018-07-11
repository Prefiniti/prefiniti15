<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    
    <cfset result = {}>

    <cftry>
        <cfset confID = createUUID()>

        <cfquery name="addSite" datasource="sites">
            INSERT INTO sites 
                (SiteName,
                admin_id,
                enabled,
                conf_id)
            VALUES
                ('#form.SiteName#',
                #form.admin_id#,
                #form.enabled#,
                "#confID#")        
        </cfquery>

        <cfquery name="getSiteID" datasource="sites">
            SELECT SiteID FROM sites WHERE conf_id="#confID#"
        </cfquery>

        <cfset admin = new Prefiniti.Authentication.UserAccount({id: form.admin_id}, false)>

        <cfset assoc_id = admin.addSiteAssociation(getSiteID.SiteID, "employee")>

        <cfset initialPerms = ["AS_CREATE",
                               "AS_EDIT",
                               "AS_LOGIN",
                               "AS_VIEW",
                               "RSS_CREATE",
                               "WW_SITEMAINTAINER"]>

        <cfloop array="#initialPerms#" item="permKey">
            <cfstoredproc procedure="grantPermission" datasource="sites">
                <cfprocparam cfsqltype="CF_SQL_BIGINT" value="#assoc_id#">
                <cfprocparam cfsqltype="CF_SQL_VARCHAR" value="#permKey#">
            </cfstoredproc>
        </cfloop>

        <cfset eventText = session.user.longName & " has added a new site.">
        <cfset prefiniti.writeUserEvent(session.user.id, "world_add.png", eventText)>
    
        <cfset result.ok = true>
        <cfset result.message = "Site has been added.">
        
        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error adding site.">
            <cfset result.error = {message: cfcatch.message, detail: cfcatch.detail}>  
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>