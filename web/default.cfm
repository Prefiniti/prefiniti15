<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Prefiniti 1.5.2">
    <meta name="author" content="John P. Willis">
    <link rel="shortcut icon" href="favicon.ico?v=2">

    <title>Prefiniti 1.5.2 Login</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
    <link rel="stylesheet" href="css/signin.css">

    <cfquery name="SiteInfo" datasource="sites">
        SELECT * FROM sites WHERE SiteID='WebWareCL'
    </cfquery>

    <cfquery name="getStatus" datasource="webwarecl">
        SELECT * FROM config
    </cfquery>

    <cfif not IsDefined("cookie.wwcl_rememberMe")>
        <cfcookie name="wwcl_rememberMe" value="false">
    </cfif>

</head>
<body class="text-center">
    <cfoutput>
        <form class="form-signin" method="post" action="/login-submit.cfm">
            <cfif IsDefined("url.redir")>
                <input type="hidden" name="doRedirect" value="true" />
                <input type="hidden" name="redir" value="#url.redir#" />
            <cfelse>
                <input type="hidden" name="doRedirect" value="false" />
            </cfif>

            <img class="mb-0" src="/graphics/prefiniti.png">
            <p class="mt-0 mb-4 text-muted"><small>Prefiniti 1.5.2 (BETA)</small></p>

            <input type="hidden" name="siteid" value="WebWareCL">

            <label for="UserName" class="sr-only">Username</label>
            <input type="text" class="form-control" name="UserName" placeholder="Username" id="UserName" <cfif #cookie.wwcl_rememberMe# EQ "true">value="#cookie.wwcl_username#"</cfif>>
            <label for="Password" class="sr-only">Password</label>
            <input type="password" id="Password" class="form-control" placeholder="Password" name="Password" <cfif #cookie.wwcl_rememberMe# EQ "true">value="#cookie.wwcl_password#"</cfif>>

            <div class="checkbox mb-3">
                <label>
                    <input type="checkbox" name="rememberMe" <cfif #cookie.wwcl_rememberMe# EQ "true">checked</cfif>/>Remember me
                </label>
            </div>

            <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
            <p class="mt-5 mb-3 text-muted">Copyright &copy; 2007-2018<br>Coherent Logic Development LLC</p>
        </form>
    </cfoutput>
</body>                         
</html>
