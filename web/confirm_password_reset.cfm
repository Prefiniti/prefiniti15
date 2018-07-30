<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Geodigraph PM | Reset Password</title>

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet">

    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">

    <link rel="shortcut icon" href="/graphics/geodigraph_icon.png?v=2">
</head>
<body class="gray-bg">
    <cfset prefiniti = new Prefiniti.Base()>
    <div class="passwordBox animated fadeInDown" style="max-width: 800px;">
        <div class="row">
            <div class="col-md-12">
                <div class="ibox-content">                                        
                    <cfif NOT isDefined("form.submit")>

                        <h2 class="font-bold">Reset Password</h2>
                    
                        <cfif isDefined("url.id")>    
                            <cfquery name="getReq" datasource="webwarecl">
                                SELECT * FROM password_reset_requests WHERE id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.id#" maxlength="255">
                            </cfquery>

                            <cfif getReq.recordCount EQ 0>
                                <p class="text-danger">Invalid password reset link. Please use the link contained in your password reset e-mail.</p>
                            <cfelse>

                                <cfif now() GE getReq.expiration>
                                    <p class="text-danger">This password reset link is expired. Please go to the <a href="/forgot_password.cfm">Forgot Password</a> page to begin the reset process again.</p>
                                <cfelse>
                                    <!--- url.id defined and valid; request not expired --->

                                    <cfset user = new Prefiniti.Authentication.UserAccount({id: getReq.user_id}, false)>                                
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <form class="m-t" id="reset-password" role="form" method="POST" action="/confirm_password_reset.cfm">
                                                <cfoutput>
                                                    <input type="hidden" name="user_id" value="#user.id#">
                                                    <input type="hidden" name="request_id" value="#url.id#">
                                                </cfoutput>
                                                <div class="form-group row">
                                                    <div class="col-lg-12 text-danger font-bold text-center" id="reset-error"></div>
                                                </div>
                                                <div class="form-group row">
                                                    <label class="col-lg-3 col-form-label">Password Question</label>
                                                    <div class="col-lg-9">
                                                        <p class="font-bold"><cfoutput>#user.password_question#</cfoutput></p>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <label class="col-lg-3 col-form-label">Answer</label>
                                                    <div class="col-lg-9">
                                                        <input autocomplete="off" type="text" name="password_answer" id="password-answer" class="form-control" placeholder="Please enter the answer to your password question" required>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <label class="col-lg-3 col-form-label">New Password</label>
                                                    <div class="col-lg-9">
                                                        <input autocomplete="off" type="password" name="new_password" id="new-password" class="form-control" placeholder="New password" required>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <label class="col-lg-3 col-form-label">Confirm Password</label>
                                                    <div class="col-lg-9">
                                                        <input autocomplete="off" type="password" name="new_password_confirm" id="new-password-confirm" class="form-control" placeholder="Confirm new password" required>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <div class="col-lg-12">
                                                        <button type="submit" name="submit" class="btn btn-primary block full-width m-b">Reset Password</button>
                                                
                                            </form>
                                        </div>
                                    </div>
                                </cfif>
                            </cfif>

                        <cfelse>
                            <p class="text-danger">Invalid password reset link. Please use the link contained in your password reset e-mail.</p>
                        </cfif>
                    <cfelse>
                        <cfset user = new Prefiniti.Authentication.UserAccount({id: form.user_id}, false)>

                        <cfif (form.password_answer EQ user.password_answer) AND (form.new_password EQ form.new_password_confirm)>

                            <cfset passwordHash = hash(form.new_password, "SHA-512")>

                            <cfquery name="setPassword" datasource="webwarecl">
                                UPDATE users 
                                SET password=<cfqueryparam cfsqltype="cf_sql_varchar" value="#passwordHash#" maxlength="255">
                                WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#form.user_id#">
                            </cfquery>             

                            <cfquery name="removeRequest" datasource="webwarecl">
                                DELETE FROM password_reset_requests 
                                WHERE id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.request_id#" maxlength="255">
                            </cfquery>                   

                            <h2 class="font-bold">Password Reset Complete</h2>

                            <p>Your password has been successfully reset. You may now <a href="/login">log in</a>.</p>
                        <cfelse>
                            <h2 class="font-bold">Password Reset Error</h2>

                            <p class="text-danger font-bold">You have incorrectly answered your security question.</p>
                            <cfoutput>
                                <p>Please <a href="/confirm_password_reset.cfm?id=#form.request_id#">try again</a>.</p>
                            </cfoutput>
                        </cfif>

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

    <script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script> 
    
    <script>
        $(document).ready(function() {
            $("#reset-password").submit(function(e) {

                var password = $("#new-password").val();
                var passwordConfirm = $("#new-password-confirm").val();

                if(password === passwordConfirm) {
                    return true;
                }
                else {
                    $("#reset-error").html("Passwords do not match.");
                    $("#new-password").val("");
                    $("#new-password-confirm").val("");
                    $("#new-password").focus();
                    event.preventDefault();
                    return false;
                }

            });
        });
    </script>
</body>
</html>
