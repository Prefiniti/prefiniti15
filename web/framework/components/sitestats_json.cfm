<cfheader name="Content-Type" value="application/json">
<cfinclude template="/framework/components/sitestats_udf.cfm">

<cfset siteStats = getSiteStats(session.current_site_id, session.user.id)>
<cfoutput>#serializeJSON(siteStats)#</cfoutput>