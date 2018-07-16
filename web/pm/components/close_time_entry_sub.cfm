<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    <cfset project = new Prefiniti.ProjectManagement.Project(form.project_id)>
    <cfset result = {}>

    <cftry>

        <cfset project.closeTimeEntry(form.id)>
        
        <cfset eventText = prefiniti.getLongname(session.user.id) & " has logged time on project " & project.project_name & ".">
        <cfset prefiniti.writeUserEvent(session.user.id, "time_add.png", eventText)>
    
        <cfset result.ok = true>
        <cfset result.message = "Time has been logged.">
        <cfset result.project_id = project.id>

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error logging time.">
            <cfset result.error = {message: cfcatch.message, detail: cfcatch.detail, other: cfcatch.sql}>  
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>                                