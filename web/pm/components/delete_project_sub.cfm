<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    <cfset project = new Prefiniti.ProjectManagement.Project(form.project_id)>
    <cfset result = {}>

    <cftry>
        <cfset project.delete()>

        <cfset eventText = session.user.longName & " has deleted project " & project.project_name & ".">
        <cfset prefiniti.writeUserEvent(session.user.id, "file_delete.png", eventText)>
    
        <cfset result.ok = true>
        <cfset result.message = "Project has been deleted.">
        <cfset result.project_id = project.id>

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error deleting project.">
            <cfset result.error = {message: cfcatch.message, detail: cfcatch.detail}>  
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>                                