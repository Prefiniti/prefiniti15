
	<cfparam name="suid" default="">
	<cfparam name="sln" default="">
	
	<cfquery name="eventUsers" datasource="webwarecl">
		SELECT * FROM Users
	</cfquery>
	
	<cfoutput query="eventUsers">
		<cfquery name="genLoginEvent" datasource="webwarecl"> 
			INSERT INTO rt_events (eventText, targetUser, viewed, timestamp) VALUES
			('#session.longName# has signed off.', #id#, 0, #CreateODBCDateTime(Now())#)
		</cfquery>
	</cfoutput>
    <cfif #session.userid# NEQ "">
		<cfquery name="setOffline" datasource="webwarecl">
			UPDATE Users SET online=0 WHERE id=#session.userid#
		</cfquery>
	</cfif>
<cfset suid=session.userid>
<cfset sln=session.longname>
	<cfset session.loggedin="no">
	<cfset session.username="">
	<cfset session.longname="">
	<cfset session.userid="">

	<cfif IsDefined("url.close")>
		<cfoutput>
		<script language="javascript">
			alert("Prefiniti is now exiting.");
			window.close();
		</script>
		</cfoutput>

	<cfelse>
		<cflocation url="default.cfm" addtoken="no">
	</cfif>
