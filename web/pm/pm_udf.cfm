<cffunction name="getProjectTemplates" returntype="query">

    <cfquery name="getProjectTemplates" datasource="webwarecl">
        SELECT * FROM pm_templates WHERE template_site=#session.current_site_id# OR template_site=0
    </cfquery>

    <cfreturn getProjectTemplates>
</cffunction>

<cffunction name="getProjectsByClientAssoc" returntype="array" output="false">
    <cfargument name="assoc_id" type="numeric" required="yes">

    <cfset result = []>

    <cfquery name="getProjectsByClientAssoc" datasource="webwarecl">
        SELECT id FROM pm_projects WHERE client_assoc=#arguments.assoc_id#
    </cfquery>

    <cfsilent>
        <cfoutput query="#getProjectsByClientAssoc#">
            <cfset result.append(new Prefiniti.ProjectManagement.Project(id))>
        </cfoutput>
    </cfsilent>

    <cfreturn result>
</cffunction>

<cffunction name="getProjectsByEmployeeAssoc" returntype="array" output="false">
    <cfargument name="assoc_id" type="numeric" required="yes">

    <cfset result = []>

    <cfquery name="getProjectsByEmployeeAssoc" datasource="webwarecl">
        SELECT id FROM pm_projects WHERE employee_assoc=#arguments.assoc_id#
    </cfquery>

    <cfsilent>
        <cfoutput query="#getProjectsByEmployeeAssoc#">
            <cfset result.append(new Prefiniti.ProjectManagement.Project(id))>
        </cfoutput>
    </cfsilent>

    <cfreturn result>
</cffunction>