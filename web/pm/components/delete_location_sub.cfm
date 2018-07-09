<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    <cfset project = new Prefiniti.ProjectManagement.Project(form.project_id)>
    <cfset result = {}>

    <cftry>
        <cfset project.removeLocation(form.id)>

        <cfset eventText = session.user.longName & " has removed a location from " & project.project_name & ".">
        
        <cfset prefiniti.writeUserEvent(project.project_client.id, "map_delete.png", eventText)>
        <cfset prefiniti.writeUserEvent(project.project_employee.id, "map_delete.png", eventText)>
        <cfset prefiniti.writeUserEvent(session.user.id, "map_delete.png", eventText)>
    
        <cfset result.ok = true>
        <cfset result.message = "Location has been deleted.">
        <cfset result.project_id = project.id>

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error deleting location.">
            <cfset result.error = {message: cfcatch.message, detail: cfcatch.detail}>  
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>                                