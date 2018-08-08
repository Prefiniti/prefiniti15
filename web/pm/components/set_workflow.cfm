<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    <cfset project = new Prefiniti.ProjectManagement.Project(form.project_id)>
    <cfset result = {}>

    <cftry>
        <cfset orig_status = project.project_status>
        <cfset project.project_status = form.stage>
        <cfset project.save()>

        <cfset project.notifyStakeholders("WF_PROJECT_STATUS_CHANGED", {
            oldStatus: orig_status, 
            newStatus: form.stage, 
            perpetrator: session.user})>
        
        <cfset result.ok = true>
        <cfset result.message = "Project status has been changed.">
        <cfset result.project_id = project.id>

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error modifying project status.">
            <cfset result.error = {message: cfcatch.message, detail: cfcatch.detail}>  
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>                                