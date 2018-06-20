<cffunction name="wfProjectNumberByID" returntype="string">
	<cfargument name="project_id" type="numeric" required="yes">
    
    <cfquery name="wfpnbi" datasource="webwarecl">
    	SELECT clsJobNumber FROM projects WHERE id=#project_id#
    </cfquery>
    
    <cfreturn #wfpnbi.clsJobNumber#>
</cffunction>

<cffunction name="wfSurveyGetSubdivisions" returntype="query">
</cffunction>

<cffunction name="getProjectsBySite" returntype="query">
    <cfargument name="site_id" type="numeric" required="true">

    <cfquery name="getProjectsBySite" datasource="#session.datasource#">
        SELECT * FROM projects WHERE site_id=#arguments.site_id# ORDER BY clsJobNumber ASC
    </cfquery>

    <cfreturn getProjectsBySite>
</cffunction>   

