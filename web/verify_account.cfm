<!doctype html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Geodigraph PM | Verify Account</title>

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">

</head>

<cfscript>
error = false;
errorMessage = "";

if(isDefined("form.submit")) {
    submitting = true;
}
else {
    submitting = false;
}
</cfscript>

<body class="gray-bg">


    <div class="middle-box text-center animated fadeInDown">
        <div>
            <cfif submitting>
                <cfscript>
                    prefiniti = new Prefiniti.Base();

                    if(form.password != form.password_confirm) {
                        error = true;
                        errorMessage = "Passwords do not match.";
                    }

                    if(!error) {
                        prefiniti.confirmAccount(form.confirm_id, form.password);
                    }
                </cfscript>
            </cfif>

            <div>
                <h1 class="logo-name"><img src="graphics/login-header.png"></h1>
                <h3>Verify Geodigraph PM Account</h3>
            </div>

            <cfif (submitting AND error) OR (!submitting)>
                <form class="m-t" role="form" method="POST" action="verify_account.cfm">
                    <cfoutput>
                        <input type="hidden" name="confirm_id" value="#url.confirm_id#">
                        <input type="hidden" name="submit" value="0">
                    </cfoutput>
                    
                    <cfif submitting AND error>
                        <h4 class="text-danger"><cfoutput>#errorMessage#</cfoutput></h4>
                    </cfif>
                    
                    <h4>Please choose a password:</h4>
                    <div class="form-group">
                        <input type="password" class="form-control" placeholder="Password" name="password" required>
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control" placeholder="Confirm Password" name="password_confirm" required>
                    </div>
                    <button type="submit" class="btn btn-primary block full-width m-b">Verify Account</button>
                </form>                   
            <cfelse>                            
                <cfif (submitting) AND (!error)>
                    <p>Your account has been verified!</p>

                    <p>Please click the Login button below to log in.</p>

                    <a class="btn btn-sm btn-primary btn-block" href="default.cfm">Login</a>
                <cfelse>
                    <p class="text-danger">Account verification error! Please use the link in your account verification email.</p>
                </cfif>
            </cfif>
        </div>
        <p class="m-t"> <small>Copyright &copy; 2018 Coherent Logic Development LLC</small> </p>
    </div>
    
</body>

</html>
