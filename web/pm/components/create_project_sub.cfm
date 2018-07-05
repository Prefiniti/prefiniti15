<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    <cfset result = {}>

    <cftry>

        <cfset project = new Prefiniti.ProjectManagement.Project(0, form.template_id)>
        <cfset project.employee_assoc = session.current_association>
        <cfset project.client_assoc = form.client_assoc>
        <cfset project.project_name = form.project_name>
        <cfset project.project_start_date = createODBCDateTime(form.project_start_date)>
        <cfset project.project_due_date = createODBCDateTime(form.project_due_date)>
        <cfset project.project_description = form.project_description>
        
        <cfset project.save()>

        <cfset eventText = prefiniti.getLongname(session.user.id) & " has created a project.">
        <cfset prefiniti.writeUserEvent(session.user.id, "timeline_marker.png", eventText)>
    
        <cfset result.ok = true>
        <cfset result.message = "Project has been created.">
        <cfset result.project_id = project.id>

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error updating employee information. " & cfcatch.detail & " HARK HARK HARK!">  
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>                                