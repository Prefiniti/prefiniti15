<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    <cfset project = new Prefiniti.ProjectManagement.Project(form.project_id)>
    <cfset result = {}>

    <cftry>
        <cfset project.assignTask(form.task_id, form.assignee_assoc_id)>

        <cfset eventText = prefiniti.getLongname(session.user.id) & " has reassigned a task in project " & project.project_name & ".">
        <cfset prefiniti.writeUserEvent(session.user.id, "user_edit.png", eventText)>
    
        <cfset result.ok = true>
        <cfset result.message = "Task has been assigned.">
        <cfset result.project_id = project.id>

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error assigning task.">
            <cfset result.error = {message: cfcatch.message, detail: cfcatch.detail}>  
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>                                