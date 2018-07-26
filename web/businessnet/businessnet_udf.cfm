<cffunction name="getTaskCodeNameByID" returntype="string" output="false">
    <cfargument name="task_code_id" type="numeric" required="true">

    <cfquery name="getTaskCodeNameByID" datasource="webwarecl">
        SELECT item FROM task_codes WHERE id=#arguments.task_code_id#
    </cfquery>

    <cfreturn getTaskCodeNameByID.item>
</cffunction>

<cffunction name="getServiceValue" returntype="numeric" output="false">
    <cfargument name="task_code_id" type="numeric" required="true">
    <cfargument name="units" type="numeric" required="true">

    <cfquery name="getTaskCodeRate" datasource="webwarecl">
        SELECT rate FROM task_codes WHERE id=#arguments.task_code_id#
    </cfquery>

    <cfset total = units * getTaskCodeRate.rate>

    <cfreturn total>
</cffunction>

<cffunction name="getTaskCodes" returntype="query" output="false">

    <cfquery name="getTaskCodes" datasource="webwarecl">
        SELECT * FROM task_codes WHERE site_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#session.current_site_id#">
        ORDER BY item
    </cfquery>

    <cfreturn getTaskCodes>
    
</cffunction>