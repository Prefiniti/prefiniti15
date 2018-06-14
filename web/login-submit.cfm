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
	
	<cfquery name="siteStatus" datasource="#session.datasource#">
		SELECT * FROM config
	</cfquery>
	
	<cfquery name="eventUsers" datasource="#session.datasource#">
		SELECT id FROM users
	</cfquery>
	
	<cfif #qryGetLogin.RecordCount# GT 0>
		<cfif #siteStatus.logins_disabled# EQ 1 AND #qryGetLogin.site_maintainer# EQ 0>
			<cfset session.message="Sign-in has been temporarily disabled for site maintenance.">
			<cflocation url="default.cfm" addtoken="no">
		</cfif>
		<cfif #qryGetLogin.account_enabled# EQ 1>
			
			<!---login success--->
			<cfif IsDefined("form.rememberMe")>
				<cfcookie name="wwcl_rememberMe" value="true" expires="never">
				<cfcookie name="wwcl_password" value="#qryGetLogin.password#" expires="never">
				<cfcookie name="wwcl_longName" value="#qryGetLogin.longName#" expires="never">
				<cfcookie name="wwcl_username" value="#qryGetLogin.username#" expires="never">
			<cfelse>
				<cfcookie name="wwcl_rememberMe" value="false">
			</cfif>
			<cfset session.message="Welcome, #qryGetLogin.longName#!">
			<cfset session.loggedin="yes">
			<cfset session.username="#qryGetLogin.username#">
			<cfset session.usertype="#qryGetLogin.type#">
			<cfset session.longname="#qryGetLogin.LongName#">
			<cfset session.userid="#qryGetLogin.id#">
			<cfset session.role="#qryGetLogin.role#">
			<cfset session.email="#qryGetLogin.email#">
			<cfset session.tcadmin="#qryGetLogin.tcadmin#">
			<cfset session.order_processor="#qryGetLogin.order_processor#">
			<cfset session.site_maintainer="#qryGetLogin.site_maintainer#">
			<cfset session.companyID="#qryGetLogin.company#">
            <cfset session.webware_admin=#qryGetLogin.webware_admin#>
			<cfset session.pwdiff=DateDiff("d", qryGetLogin.last_pwchange, Now())>
            
			<cfquery name="od" datasource="#session.datasource#">
				SELECT duedate FROM projects WHERE DATE_SUB(CURDATE(), INTERVAL 30 DAY) > duedate AND SubStatus <> "Closed";
			</cfquery>
			<cfquery name="setOnline" datasource="#session.datasource#">
				UPDATE users SET online=1, last_login=#CreateODBCDateTime(Now())# WHERE id=#qryGetLogin.id#
			</cfquery>
			
			<cfoutput query="eventUsers">
				<cfquery name="genLoginEvent" datasource="webwarecl"> 
					INSERT INTO rt_events (eventText, targetUser, viewed, timestamp) VALUES
					('#TimeFormat(Now(), "h:mm:tt")#: #qryGetLogin.longName# has signed on.', #id#, 0, #CreateODBCDateTime(Now())#)
				</cfquery>
			</cfoutput>

			<cfif #form.doRedirect# EQ "true">
				<cflocation url="#form.redir#" addtoken="no">
			<cfelse>
				<cflocation url="siteSelect.cfm" addtoken="no">
			</cfif>
		<cfelse>
			<cfset session.message="Your account has been disabled.">
			<cflocation url="default.cfm" addtoken="no">
		</cfif>
	<cfelse>
		<!---login failure--->
		<cfset session.message="Invalid username and/or password. Please try again">
		<cflocation url="default.cfm" addtoken="no">
	</cfif>
</body>
</html>
