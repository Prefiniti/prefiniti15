<cfset prefiniti = new Prefiniti.Base()>

<cfif prefiniti.loggedIn()>
    <cfquery name="updateLastLoadedPage" datasource="webwarecl">
    UPDATE users SET last_loaded_page="#form.url#", last_loaded_page_onload="#form.onload#", last_loaded_page_onerror="#form.onerror#" WHERE id=#session.user.id#
    </cfquery>
</cfif>