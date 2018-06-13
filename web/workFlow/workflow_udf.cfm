<cffunction name="wfProjectNumberByID" returntype="string">
	<cfargument name="project_id" type="numeric" required="yes">
    
    <cfquery name="wfpnbi" datasource="webwarecl">
    	SELECT clsJobNumber FROM projects WHERE id=#project_id#
    </cfquery>
    
    <cfreturn #wfpnbi.clsJobNumber#>
</cffunction>

<cffunction name="wfSurveyGetSubdivisions" returntype="query">
</cffunction>