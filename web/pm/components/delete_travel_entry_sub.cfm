<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    <cfset project = new Prefiniti.ProjectManagement.Project(form.project_id)>
    <cfset result = {}>

    <cftry>

        <cfset project.deleteTravelEntry(form.id)>
        
        <cfset eventText = prefiniti.getLongname(session.user.id) & " has removed a travel entry on project " & project.project_name & ".">
        <cfset prefiniti.writeUserEvent(session.user.id, "car.png", eventText)>
    
        <cfset result.ok = true>
        <cfset result.message = "Travel entry has been removed.">
        <cfset result.project_id = project.id>

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error removing travel entry.">
            <cfset result.error = {message: cfcatch.message, detail: cfcatch.detail}>  
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>                                