<cffunction name="getTaskCodeNameByID" returntype="string" output="false">
    <cfargument name="task_code_id" type="numeric" required="true">

    <cfquery name="getTaskCodeNameByID" datasource="webwarecl">
        SELECT item FROM task_codes WHERE id=#arguments.task_code_id#
    </cfquery>

    <cfreturn getTaskCodeNameByID.item>
</cffunction>