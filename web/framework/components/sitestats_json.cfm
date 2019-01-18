<cfheader name="Content-Type" value="application/json">
<cfinclude template="/framework/components/sitestats_udf.cfm">
<cfif isDefined("session.user")>
    <cfif isDefined("session.user.id")>
        <cfset siteStats = getSiteStats(session.current_site_id, session.user.id)>
        <cfoutput>#serializeJSON(siteStats)#</cfoutput>
    </cfif>
</cfif>