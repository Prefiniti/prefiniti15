<cfquery name="setInitialPW" datasource="webwarecl">
	UPDATE users
	SET		password='#Hash(url.password)#',
    		last_pwchange=#CreateODBCDateTime(Now())#
	WHERE	id=#url.id#
</cfquery>

<cfset session.pwdiff=0>

<p style="color:red">Password set.</p>