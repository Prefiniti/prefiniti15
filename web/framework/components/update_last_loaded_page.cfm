<cfset prefiniti = new Prefiniti.Base()>

<cfif prefiniti.loggedIn()>
    <cfquery name="updateLastLoadedPage" datasource="webwarecl">
    UPDATE users SET last_loaded_page="#form.url#" WHERE id=#session.user.id#
    </cfquery>
</cfif>