<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>Site Selection</title>

	<cfquery name="getSites" datasource="sites">
		SELECT * FROM site_associations WHERE id=#form.siteAssociation#
	</cfquery>

	<cfquery name="updateLastSite" datasource="webwarecl">
		UPDATE users SET last_site_id=#form.siteAssociation# WHERE id=#session.userid# 
	</cfquery>    

	<cfset session.usertype = getSites.assoc_type>
	<cfset session.current_association = getSites.id>
	<cfset session.originating_assoc_id = session.current_association>
	<cfset session.current_site_id = getSites.site_id>

	<cfset session.association = new Prefiniti.Authentication.SiteAssociation(session.current_association)>
	<cfset session.site = new Prefiniti.Authentication.Site(session.current_site_id)>

	<link rel="stylesheet" href="css/prefiniti.css">
</head>
<body>
	<cfif getPermissionByKey("AS_LOGIN", session.current_association) EQ false>
		<center>
	    <div style="margin:30px; padding:30px; width:300px; border:1px solid #EFEFEF;" align="center">
	        <img src="/graphics/webware.png" style="padding-bottom:20px;">
	        <h3 class="stdHeader">Permission Denied</h3>
	        
	        <p>You do not have the <strong>AS_LOGIN</strong> permission on this site.</p>
	    </div>
	    </center>
	    <cfabort>
	</cfif>
	    
	<cfquery name="getASite" datasource="sites">
		SELECT * FROM sites WHERE SiteID=#session.current_site_id# 
	</cfquery>    

	<cfif #getASite.enabled# EQ 1>
		<cflocation url="/app" addtoken="no">
	<cfelse>
		<center>
	    <div align="center" style="margin:30px; padding:30px; width:300px; border:1px solid #EFEFEF;">
			<img src="/graphics/webware.png" style="padding-bottom:20px;"/>
			<h3 class="stdHeader">Site Disabled</h3>
	        
	        <p>Logins to this site have been disabled.</p>
	        <p>Please try again later.</p>
		</div>
		</center>
	</cfif> 
</body>
</html>               