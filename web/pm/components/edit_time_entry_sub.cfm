<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    <cfset project = new Prefiniti.ProjectManagement.Project(form.project_id)>
    <cfset result = {}>

    <cftry>
        <cfset startDate = form.start_date & " " & form.start_hour & ":" & form.start_minute & " " & form.start_ampm>

        <cfquery name="updateTime" datasource="webwarecl">
            UPDATE  pm_time_entries
            SET     start_time=#createODBCDateTime(startDate)#,
                    work_performed="#form.work_performed#",
                    task_code_id=#form.task_code_id#
            WHERE   id=#form.id#
        </cfquery>


        <cfif isDefined("form.end_date")>
            <cfset endDate = form.end_date & " " & form.end_hour & ":" & form.end_minute & " " & form.end_ampm>
        
            <cfquery name="updateEndDate" datasource="webwarecl">
                UPDATE  pm_time_entries
                SET     end_time=#createODBCDateTime(endDate)#
                WHERE   id=#form.id#
            </cfquery>                    

        </cfif>

        <cfif isDefined("form.assoc_id")>
            <cfquery name="updateAssocID" datasource="webwarecl">
                UPDATE  pm_time_entries
                SET     assoc_id=#form.assoc_id#
                WHERE   id=#form.id#
            </cfquery>  
        </cfif>
         
        <cfset result.ok = true>
        <cfset result.message = "Time log updated.">
        <cfset result.project_id = project.id>

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error updating time log.">
            <cfset result.error = {
                message: cfcatch.message,
                detail: cfcatch.detail
            }>
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>                                