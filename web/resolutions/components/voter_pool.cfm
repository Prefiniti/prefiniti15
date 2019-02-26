<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset site = new Prefiniti.Authentication.Site(session.current_site_id)>
    <cfscript>
    result = {
        employees: site.employees().len(),
        clients: site.clients().len(),
        everyone: site.everyone().len()
    };
    </cfscript>
</cfsilent>
<cfoutput>#serializeJSON(result)#</cfoutput>