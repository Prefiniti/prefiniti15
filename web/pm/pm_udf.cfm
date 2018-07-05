<cffunction name="getProjectTemplates" returntype="query">

    <cfquery name="getProjectTemplates" datasource="webwarecl">
        SELECT * FROM pm_templates WHERE template_site=#session.current_site_id# OR template_site=0
    </cfquery>

    <cfreturn getProjectTemplates>
</cffunction>