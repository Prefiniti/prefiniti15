<cfinclude template="/contentManager/cm_udf.cfm">

<cfparam name="basePath" default="">



<cfswitch expression="#url.mode#">
	<cfcase value="user">
		<cfset basePath="#cmsUserBasePath(url.user_id)#/#url.basedir#">
    </cfcase>
    <cfcase value="site">
    	<cfset basePath="#cmsSiteBasePath(url.site_id)#/#url.basedir#/#url.subdir#">
    
    </cfcase>
</cfswitch>


<cffile action="upload" filefield="Filedata" destination="#basePath#"  nameconflict="makeunique">
<cfoutput>Complete.</cfoutput>

<cfset filename = cffile.serverFile>

<cfif url.mode EQ "user">
	<cfoutput>#cmsCreateUserFile(url.user_id, filename, url.basedir, filename)#</cfoutput>
<cfelse>
	<cfoutput>#cmsCreateSiteFile(url.site_id, url.user_id, filename, url.basedir, url.subdir, filename)#</cfoutput>
</cfif>    
<!---<cffunction name="cmsCreateFile" returntype="void">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="filename" type="string" required="yes">
    <cfargument name="basedir" type="string" required="yes">
    cfargument name="description" type="string" required="yes">
	
	'
	<cffunction name="cmsCreateSiteFile" returntype="void">
	<cfargument name="site_id" type="numeric" required="yes">
    <cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="filename" type="string" required="yes">
    <cfargument name="basedir" type="string" required="yes">
    <cfargument name="subdir" type="string" required="yes">
    <cfargument name="description" type="string" required="yes">--->