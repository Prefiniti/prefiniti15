<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    <cfset project = new Prefiniti.ProjectManagement.Project(form.project_id)>
    <cfset result = {}>

    <cftry>
        <cfset project.setDeliverableFileID(form.deliverable_id, form.deliverable_file_id)>

        <cfset eventText = session.user.longName & " has attached a file for a deliverable to project " & project.project_name & ".">
        <cfset prefiniti.writeUserEvent(session.user.id, "file_add.png", eventText)>
    
        <cfset result.ok = true>
        <cfset result.message = "Deliverable has been set.">
        <cfset result.project_id = project.id>

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error updating deliverable. #cfcatch.message# #cfcatch.detail#">
            <cfset result.error = {message: cfcatch.message, detail: cfcatch.detail}>  
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput> 