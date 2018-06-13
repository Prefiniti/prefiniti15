<cfquery name="addSite" datasource="sites">
	INSERT INTO sites 
    	(SiteName,
        admin_id,
        enabled)
	VALUES
    	('#form.SiteName#',
        #form.admin_id#,
        #form.enabled#)        
</cfquery>

<cflocation url="/webware_admin/manageSites.cfm" addtoken="no">