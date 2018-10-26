<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    <cfset project = new Prefiniti.ProjectManagement.Project(form.project_id)>
    <cfset result = {}>

    <cftry>
        <cfset startDate = form.start_date & " " & form.start_hour & ":" & form.start_minute & " " & form.start_ampm>

        <cfif NOT isDefined("form.time_open")>
            <cfset endDate = form.end_date & " " & form.end_hour & ":" & form.end_minute & " " & form.end_ampm>
            <cfset project.logTime(form.task_id, form.assoc_id, form.task_code_id, form.work_performed, startDate, endDate)>
        <cfelse>
            <cfset project.logTime(form.task_id, form.assoc_id, form.task_code_id, form.work_performed, startDate)>
        </cfif>
       
        <cfset result.ok = true>
        <cfset result.message = "Time has been logged.">
        <cfset result.project_id = project.id>

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error logging time.">
            <cfset result.error = {
                message: cfcatch.message,
                detail: cfcatch.detail
            }>
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>                                