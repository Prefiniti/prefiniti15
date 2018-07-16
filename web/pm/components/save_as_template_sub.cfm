<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    <cfset project = new Prefiniti.ProjectManagement.Project(form.project_id)>
    <cfset result = {}>

    <cftry>
        <cfset project.saveToNewTemplate(form.template_name)>

        <cfset eventText = prefiniti.getLongname(session.user.id) & " has created template " & form.template_name & ".">
        <cfset prefiniti.writeUserEvent(session.user.id, "timeline_marker.png", eventText)>
    
        <cfset result.ok = true>
        <cfset result.message = "Template has been saved.">
        <cfset result.project_id = project.id>

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error saving template.">
            <cfset result.error = {message: cfcatch.message, detail: cfcatch.detail, other: cfcatch.sql}>  
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>                                