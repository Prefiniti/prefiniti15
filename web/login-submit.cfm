<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>

<body>
	<cfquery name="qryGetLogin" datasource="#session.datasource#">
		SELECT * FROM users WHERE username='#form.username#' AND password='#Hash(form.password)#'
	</cfquery>
	
	<cfquery name="eventUsers" datasource="#session.datasource#">
		SELECT id FROM users
	</cfquery>
	
	<cfif #qryGetLogin.RecordCount# GT 0>
		
		<cfif #qryGetLogin.account_enabled# EQ 1>
			
			<!---login success--->
			<cfif IsDefined("form.rememberMe")>
				<cfcookie name="wwcl_rememberMe" value="true" expires="never">				
				<cfcookie name="wwcl_longName" value="#qryGetLogin.longName#" expires="never">
				<cfcookie name="wwcl_username" value="#qryGetLogin.username#" expires="never">
			<cfelse>
				<cfcookie name="wwcl_rememberMe" value="false">
			</cfif>

			<cfset session.loggedin = true>
			<cfset session.username = "#qryGetLogin.username#">
			<cfset session.longname = "#qryGetLogin.LongName#">
			<cfset session.userid = "#qryGetLogin.id#">
			<cfset session.email = "#qryGetLogin.email#">
            <cfset session.webware_admin=#qryGetLogin.webware_admin#>
			
			<cfset session.user = new Prefiniti.Authentication.UserAccount({username: session.username}, false)>
            			
			<cfquery name="setOnline" datasource="#session.datasource#">
				UPDATE users SET online=1, last_login=#CreateODBCDateTime(Now())# WHERE id=#qryGetLogin.id#
			</cfquery>
						

			<cflocation url="/go" addtoken="no">			
		<cfelse>
			<cfset session.message="Your account has been disabled.">
			<cflocation url="/login" addtoken="no">
		</cfif>
	<cfelse>
		<!---login failure--->
		<cfset session.loggedin = false>
		<cfset session.message="Invalid username and/or password. Please try again">
		<cflocation url="/login" addtoken="no">
	</cfif>
</body>
</html>
