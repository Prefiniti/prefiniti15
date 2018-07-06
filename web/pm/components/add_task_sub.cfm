<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    <cfset project = new Prefiniti.ProjectManagement.Project(form.project_id)>
    <cfset result = {}>

    <cftry>
        <cfset project.addTask(form.task_name)>

        <cfset eventText = prefiniti.getLongname(session.user.id) & " has added a task to project " & project.project_name & ".">
        <cfset prefiniti.writeUserEvent(session.user.id, "timeline_marker.png", eventText)>
    
        <cfset result.ok = true>
        <cfset result.message = "Task has been added.">
        <cfset result.project_id = project.id>

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error adding task.">
            <cfset result.error = {message: cfcatch.message, detail: cfcatch.detail}>  
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>                                