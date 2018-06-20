<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Process Upload</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
    <link rel="stylesheet" href="css/app.css">
</head>
<body>
    <cfdump var="#form#">

    <cfinclude template="/contentManager/cm_udf.cfm">
   
    <cfif isDefined("form.profilePhoto")>
        <cfset basedir = "profile_images">
    <cfelse>
        <cfset basedir = "project_files">
    </cfif>

    <cfset basePath = cmsUserBasePath(session.userid) & "/" & "/" & basedir>

    <cffile action="upload" filefield="fileData" destination="#basePath#"  nameconflict="makeunique">

    <cfset filename = cffile.serverFile>
    <cfset cmsCreateUserFile(session.userid, filename, basedir, filename)>
 
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>