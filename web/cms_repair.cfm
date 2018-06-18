<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>Repair CMS Database/On-Disk Structure</title>

	<link rel="stylesheet" href="css/prefiniti.css">

    <style>
    .ok { color: green; }
    .warn { color: yellow; }
    .error { color: red; }
    </style>

    <cfinclude template="/contentManager/cm_udf.cfm">
    <cfinclude template="/authentication/authentication_udf.cfm">
    <cfinclude template="/socialnet/socialnet_udf.cfm">

    <cfset siteBase = expandPath("/")>
    <cfset userContent = siteBase & "UserContent/">
    <cfset siteContent = siteBase & "SiteContent/">

    <cfset users = getUserIDs()>
</head>
<body>
    <h1>CMS Repair Tool</h1>

    <ul>
        <li>Site base: <cfoutput>#siteBase#</cfoutput></li>
        <li>User content: <cfoutput>#userContent#</cfoutput></li>
        <li>Site content: <cfoutput>#siteContent#</cfoutput></li>
    </ul>

    <h2>Checking user content structure...</h2>

    <cfif NOT directoryExists(userContent)>
        <p><cfoutput>#userContent#</cfoutput> did not exist. Creating...</p>
        <cfset directoryCreate(userContent)>
    <cfelse>
        <p><cfoutput>#userContent#</cfoutput> exists.</p>
    </cfif>

    <cfloop array="#users#" item="user">
        <cfset username = getUsername(user)>

        <h3>Checking <cfoutput>#username#</cfoutput> structure...</h3>


        <blockquote>
            <cfif NOT directoryExists(userContent & username)>
                <p class="error">No user directory! Creating...</p>
                <cfset directoryCreate(userContent & username)>
            <cfelse>
                <p class="ok">User directory OK</p>
            </cfif>

            <cfif NOT directoryExists(userContent & username & "/profile_images")>
                <p class="error">No profile_images directory! Creating...</p>
                <cfset directoryCreate(userContent & username & "/profile_images")>
            <cfelse>
                <p class="ok">profile_images OK</p>
            </cfif>
            <cfif NOT directoryExists(userContent & username & "/project_files")>
                <p class="error">No project_files directory! Creating...</p>
                <cfset directoryCreate(userContent & username & "/project_files")>
            <cfelse>
                <p class="ok">project_files OK</p>
            </cfif>
        </blockquote>

        <h3>Checking <cfoutput>#username#</cfoutput> files...</h3>

        <cfset files = cmsGetUserFiles(user)>

        <cfif files.recordCount GT 0>
            <p class="ok"><cfoutput>#username# has #files.recordCount# files.</cfoutput></p>
        <cfelse>
            <p class="error"><cfoutput>#username# has #files.recordCount# files.</cfoutput></p>
        </cfif>

        <cfoutput query="files">
            <cfset path = userContent & username & "/" & basedir & "/" & filename>

            <cfif NOT fileExists(path)>
                <p class="error">#path# does not exist! Deleting from CMS database...</p>
                <cfset cmsDeleteUserFile(id)>
            <cfelse>
                <p class="ok">#path# OK</p>
            </cfif>
        </cfoutput>

    </cfloop>

</body>
</html>