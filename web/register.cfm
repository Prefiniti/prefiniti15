<!doctype html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Geodigraph Hub | Register</title>

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">

    <link rel="shortcut icon" href="/graphics/geodigraph_icon.png?v=2">
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

                    if(prefiniti.emailTaken(form.email)) {
                        error = true;
                        errorMessage = "This e-mail address is already in use.";
                    }

                    if(!error) {
                        accountParams = {
                            email: form.email,                            
                            firstName: form.firstName,
                            lastName: form.lastName
                        };

                        if(trim(form.middleInitial) NEQ "") {
                            accountParams.middleInitial = form.middleInitial;
                        }

                        acct = new Prefiniti.Authentication.UserAccount(accountParams, true);
                    }

                </cfscript>
            </cfif>
            <cfif (submitting AND error) OR (!submitting)>
                <div>
                    <h1 class="logo-name"><img src="graphics/login-header.png"></h1>
                </div>
                <h3>Create Geodigraph Hub Account</h3>
                <form class="m-t" role="form" method="POST" action="register.cfm">
                    <cfif submitting AND error>
                        <h4 class="text-danger"><cfoutput>#errorMessage#</cfoutput></h4>
                    </cfif>
                    <input type="hidden" name="submit" value="0">
                    
                    <div class="form-group">
                        <input type="email" class="form-control" placeholder="E-Mail Address" name="email" required <cfif submitting><cfoutput>value="#form.email#"</cfoutput></cfif>>
                    </div>
                    <div class="form-group row">
                        <div class="col-lg-5">
                            <input type="text" class="form-control" placeholder="First Name" name="firstName" required <cfif submitting><cfoutput>value="#form.firstName#"</cfoutput></cfif>>
                        </div>
                        <div class="col-lg-2 p-0">
                            <input type="text" class="form-control" placeholder="Middle" maxlength="1" name="middleInitial" <cfif submitting><cfoutput>value="#form.middleInitial#"</cfoutput></cfif>>
                        </div>
                        <div class="col-lg-5">
                            <input type="text" class="form-control" placeholder="Last Name" name="lastName" required <cfif submitting><cfoutput>value="#form.lastName#"</cfoutput></cfif>>
                        </div>
                    </div>
                    <div class="form-group">
                            <div class="checkbox i-checks"><label> <input type="checkbox"><i></i> I agree to the terms of service/privacy policy</label></div>
                    </div>
                    <button type="submit" class="btn btn-primary block full-width m-b">Register</button>

                    <p class="text-muted text-center"><small>Already have an account?</small></p>
                    <a class="btn btn-sm btn-white btn-block" href="/login">Login</a>
                </form>
                <p class="m-t"> <small>Copyright &copy; 2018 Coherent Logic Development LLC</small> </p>
            <cfelse>
                <div>
                    <h1 class="logo-name"><img src="graphics/login-header.png"></h1>
                </div>
                <h3>Account Created</h3>

                <p>You will not be able to log in until you confirm your account.</p>
                <p>You should receive an e-mail at <strong><cfoutput>#form.email#</cfoutput></strong> containing an account confirmation link. Once you click this link, you will be able to log in to your account.</p>

                <a class="btn btn-sm btn-primary btn-block" href="/login">Login</a>
                <p class="m-t"> <small>Copyright &copy; 2018 Coherent Logic Development LLC</small> </p>
            </cfif>
        </div>
    </div>

    <!-- Mainly scripts -->
    <script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.js"></script>
    <!-- iCheck -->
    <script src="js/plugins/iCheck/icheck.min.js"></script>
    <script>
        $(document).ready(function(){
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });
        });
    </script>
</body>

</html>
