<cfquery name="ews" datasource="webwarecl">
    UPDATE users SET show_tour=1 WHERE id=#session.user.id#
</cfquery>

<cfset session.user.show_tour = 1>