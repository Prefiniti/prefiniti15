<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <meta name="description" content="Geodigraph PM">
    <meta name="author" content="John P. Willis">
    <link rel="shortcut icon" href="/graphics/geodigraph_icon.png?v=3">

    <title>Geodigraph PM | Login</title>

    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
    
    <link href="css/bootstrap.min.css" rel="stylesheet">
   
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">

    <cfif not IsDefined("cookie.wwcl_rememberMe")>
        <cfcookie name="wwcl_rememberMe" value="false">
    </cfif>

</head>
<body class="gray-bg">

    <cfif session.loggedin>
        <cflocation url = "/app" addtoken="false">
    </cfif>

    <cfset session.message = "">

    <cfif isDefined("form.submit")>
        <cfset user = new Prefiniti.Authentication.UserAccount({id: session.pending_user_id}, false)>
        <cfset tfa = new Prefiniti.Authentication.GoogleAuthenticator()>

        <cfif tfa.verifyGoogleToken(user.tfa_secret, form.otp)>
            <cfset session.loggedin = true>
            <cfset session.username = user.username>
            <cfset session.longname = user.longname>
            <cfset session.userid = user.id>
            <cfset session.email = user.email>
            <cfset session.webware_admin = user.webware_admin>
            
            <cfset session.user = user>
                        
            <cfquery name="setOnline" datasource="#session.datasource#">
                UPDATE users SET online=1, last_login=#CreateODBCDateTime(Now())# WHERE id=#user.id#
            </cfquery>                        

            <cflocation url="/go" addtoken="no">
        <cfelse>
            <cfset session.message = "Invalid authenticator key">
        </cfif>
    </cfif>

    <cfset errorMessage = "">
    <cfif isDefined("session.message")>    
        <cfif session.message NEQ "">
            <cfset errorMessage = session.message>
        </cfif>
    </cfif>
    <cfoutput>

        <div class="middle-box text-center loginscreen animated fadeInDown">
            <div>
                <div>
                    <h1 class="logo-name"><img src="graphics/login-header.png"></h1>
                </div>
                <h3>Two-Factor Authentication</h3>
                <span class="text-danger"><cfoutput>#errorMessage#</cfoutput></span>

                <form class="m-t" method="post" action="/verify">                

                    <div class="form-group">
                        <input type="text" class="form-control" name="otp" id="otp" placeholder="Enter your Authenticator Key" maxlength="6">
                    </div>
                    
                    <button type="submit" class="btn btn-primary block full-width m-b" name="submit">Login</button>                   

                </form>
                <p class="m-t"> <small>Copyright &copy; 2018 Coherent Logic Development LLC</small> </p>
            </div>
        </div>
    </cfoutput>

    <!-- Mainly scripts -->
    <script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script> 

    <script>
        $(document).ready(function() {
            $("#otp").focus();
        });
    </script>
    
</body>                         
</html>
