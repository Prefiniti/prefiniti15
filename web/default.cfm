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
                <h3>Geodigraph PM</h3>
                <span class="text-danger"><cfoutput>#errorMessage#</cfoutput></span>

                <form class="m-t" method="post" action="/login-submit.cfm">                

                    <div class="form-group">
                        <input type="email" class="form-control" name="UserName" placeholder="E-Mail Address" id="UserName" <cfif #cookie.wwcl_rememberMe# EQ "true">value="#cookie.wwcl_username#"</cfif>>
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
                    <p class="text-muted text-center"><small>Don't have an account?</small></p>
                    <a class="btn btn-sm btn-white btn-block" href="/register">Create an account</a>

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
