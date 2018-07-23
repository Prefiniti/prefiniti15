<cfif #session.userid# NEQ "">
	<cfquery name="setOffline" datasource="webwarecl">
		UPDATE users SET online=0 WHERE id=#session.userid#
	</cfquery>
</cfif>

<cfset session.loggedin="no">
<cfset session.username="">
<cfset session.longname="">
<cfset session.userid="">
<cfset session.user = "">
<cfset session.message = "Come back soon!">

<cflocation url="/login" addtoken="no">

