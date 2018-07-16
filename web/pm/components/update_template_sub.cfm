<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    <cfset project = new Prefiniti.ProjectManagement.Project(form.project_id)>
    <cfset result = {}>

    <cftry>
        <cfset project.updateTemplate()>

        <cfset eventText = prefiniti.getLongname(session.user.id) & " has updated a template.">
        <cfset prefiniti.writeUserEvent(session.user.id, "timeline_marker.png", eventText)>
    
        <cfset result.ok = true>
        <cfset result.message = "Template has been updated.">
        <cfset result.project_id = project.id>

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error updating template.">
            <cfset result.error = {message: cfcatch.message, detail: cfcatch.detail, other: cfcatch.sql}>  
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>                                