<cfquery name="dws" datasource="webwarecl">
    UPDATE users SET show_tour=0 WHERE id=#session.user.id#
</cfquery>

<cfset session.user.show_tour = 0>