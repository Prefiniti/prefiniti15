<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    <cfset project = new Prefiniti.ProjectManagement.Project(form.project_id)>
    <cfset result = {}>

    <cftry>
        <cfset orig_status = project.project_status>
        <cfset project.project_status = form.stage>
        <cfset project.save()>

        <cfset eventText = prefiniti.getLongname(session.user.id) & " has changed project " & project.project_name & "'s status from <strong>" & orig_status & "</strong> to <strong>" & form.stage & "</strong>.">
        <cfset prefiniti.writeUserEvent(project.project_client.id, "timeline_marker.png", eventText)>
        <cfset prefiniti.writeUserEvent(project.project_employee.id, "timeline_marker.png", eventText)>
        <cfset prefiniti.writeUserEvent(session.user.id, "timeline_marker.png", eventText)>
        
        <cfset result.ok = true>
        <cfset result.message = "Project status has been changed.">
        <cfset result.project_id = project.id>

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error modifying project status.">
            <cfset result.error = {message: cfcatch.message, detail: cfcatch.detail}>  
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>                                