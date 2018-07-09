<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    <cfset result = {}>

    <cftry>

        <cfset project = new Prefiniti.ProjectManagement.Project(form.project_id)>
        <cfset project.addStakeholder(form.assoc_id, form.stakeholder_type)>

        <cfset user = prefiniti.getUserByAssociationID(form.assoc_id)>

        <cfset eventText = prefiniti.getLongname(session.user.id) & " has added " & user.longName & " to project " & project.project_name & " as a " & form.stakeholder_type & ".">
        <cfset prefiniti.writeUserEvent(session.user.id, "user_add.png", eventText)>
    
        <cfset result.ok = true>
        <cfset result.message = eventText>
        <cfset result.project_id = project.id>

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error adding stakeholder to project.">  
            <cfset result.error = {message: cfcatch.message, detail: cfcatch.detail}>
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>                                