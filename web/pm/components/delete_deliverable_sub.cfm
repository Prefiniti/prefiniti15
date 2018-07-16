<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    <cfset project = new Prefiniti.ProjectManagement.Project(form.project_id)>
    <cfset result = {}>

    <cftry>
        <cfset project.removeDeliverable(form.id)>

        <cfset eventText = prefiniti.getLongname(session.user.id) & " has removed a deliverable from " & project.project_name & ".">
        
        <cfset prefiniti.writeUserEvent(project.project_client.id, "file_remove.png", eventText)>
        <cfset prefiniti.writeUserEvent(project.project_employee.id, "file_remove.png", eventText)>
        <cfset prefiniti.writeUserEvent(session.user.id, "file_remove.png", eventText)>
    
        <cfset result.ok = true>
        <cfset result.message = "Deliverable has been deleted.">
        <cfset result.project_id = project.id>

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error deleting deliverable.">
            <cfset result.error = {message: cfcatch.message, detail: cfcatch.detail}>  
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>                                