<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    <cfset project = new Prefiniti.ProjectManagement.Project(form.project_id)>
    <cfset result = {}>

    <cftry>
        <cfset project.removeStakeholderByID(form.id)>

        <cfset eventText = prefiniti.getLongname(session.user.id) & " has removed a stakeholder from " & project.project_name & ".">
        
        <cfset prefiniti.writeUserEvent(project.project_client.id, "timeline_marker.png", eventText)>
        <cfset prefiniti.writeUserEvent(project.project_employee.id, "timeline_marker.png", eventText)>
        <cfset prefiniti.writeUserEvent(session.user.id, "timeline_marker.png", eventText)>
    
        <cfset result.ok = true>
        <cfset result.message = "Stakeholder has been deleted.">
        <cfset result.project_id = project.id>

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error deleting stakeholder.">
            <cfset result.error = {message: cfcatch.message, detail: cfcatch.detail}>  
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>                                