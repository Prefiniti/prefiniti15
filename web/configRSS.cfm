<cfset prefiniti = new Prefiniti.Base()>
<link rel="shortcut icon" href="/graphics/geodigraph_icon.png?v=2">
<cfoutput>	
    <link rel="alternate" type="application/rss+xml" title="#prefiniti.getSiteNameByID(session.current_site_id)# RSS" href="/news/rss.cfm?current_site_id=#session.current_site_id#">
</cfoutput>