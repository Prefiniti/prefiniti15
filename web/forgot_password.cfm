<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Geodigraph PM | Forgot Password</title>

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet">

    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">

    <link rel="shortcut icon" href="/graphics/geodigraph_icon.png?v=2">
</head>
<body class="gray-bg">
    <div class="passwordBox animated fadeInDown">
        <div class="row">
            <div class="col-md-12">
                <div class="ibox-content">                                        
                    <cfif NOT isDefined("form.submit")>
                        <h2 class="font-bold">Forgot Password</h2>
                        <p>
                            Please enter the e-mail address associated with your Geodigraph PM account.
                        </p>                    
                        <div class="row">
                            <div class="col-lg-12">
                                <cfoutput>
                                    <form class="m-t" role="form" method="POST" action="/forgot_password.cfm">
                                        <div class="form-group">
                                            <input type="email" name="email" class="form-control" placeholder="E-Mail Address" required>
                                        </div>
                                        <button type="submit" name="submit" class="btn btn-primary block full-width m-b">Begin Password Reset</button>
                                    </form>
                                </cfoutput>
                            </div>
                        </div>
                    <cfelse>

                        <cfset prefiniti = new Prefiniti.Base()>
                        <cfset prefiniti.beginPasswordReset(form.email)>

                        <h2 class="font-bold">Password Reset Sent</h2>

                        <cfoutput>
                            <p>If there is a valid Geodigraph PM account associated with <strong>#form.email#</strong>, we have sent an e-mail to that address containing a link you may click in order to continue the password reset process.</p>
                            <p>This link will expire in 1 hour.</p>
                        </cfoutput>

                    </cfif>
                </div>
            </div>
        </div>
        <hr/>
        <div class="row">
            <div class="col-md-12 text-center">
                Copyright &copy; 2018 Coherent Logic Development LLC
            </div>            
        </div>
    </div>
</body>
</html>
