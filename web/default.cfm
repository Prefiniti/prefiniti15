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
<body class="gray-bg">

    <cfset errorMessage = "">
    <cfoutput>

        <div class="middle-box text-center loginscreen animated fadeInDown">
            <div>
                <div>
                    <h1 class="logo-name"><img src="graphics/login-header.png"></h1>
                </div>
                <h3>Geodigraph PM</h3>
                <span style="color:red;"><cfoutput>#errorMessage#</cfoutput></span>

                <form class="m-t" method="post" action="/login-submit.cfm">
                    <cfif IsDefined("url.redir")>
                        <input type="hidden" name="doRedirect" value="true" />
                        <input type="hidden" name="redir" value="#url.redir#" />
                    <cfelse>
                        <input type="hidden" name="doRedirect" value="false" />
                    </cfif>

                    <input type="hidden" name="siteid" value="WebWareCL">

                    <div class="form-group">
                        <input type="text" class="form-control" name="UserName" placeholder="Username" id="UserName" <cfif #cookie.wwcl_rememberMe# EQ "true">value="#cookie.wwcl_username#"</cfif>>
                    </div>
                    
                    <div class="form-group">
                        <input type="password" id="Password" class="form-control" placeholder="Password" name="Password">
                    </div>

                    <div class="form-group">
                        <div class="checkbox mb-3">
                            <label>
                                <input type="checkbox" name="rememberMe" <cfif #cookie.wwcl_rememberMe# EQ "true">checked</cfif>/>Remember me
                            </label>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary block full-width m-b" name="submit">Login</button>

                    <a href="##"><small>Forgot password?</small></a>
                    <p class="text-muted text-center"><small>Do not have an account?</small></p>
                    <a class="btn btn-sm btn-white btn-block" href="register.cfm">Create an account</a>

                </form>
                <p class="m-t"> <small>Copyright &copy; 2018 Coherent Logic Development LLC</small> </p>
            </div>
        </div>
        <!-- Mainly scripts -->
        <script src="js/jquery-3.1.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script> 
    </cfoutput>
</body>                         
</html>
