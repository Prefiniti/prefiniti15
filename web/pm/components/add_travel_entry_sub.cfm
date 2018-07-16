<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    <cfset project = new Prefiniti.ProjectManagement.Project(form.project_id)>
    <cfset result = {}>

    <cftry>
        <!---
        <cffunction name="logTravel" returntype="numeric" output="false">
        <cfargument name="task_id" type="numeric" required="true">
        <cfargument name="assoc_id" type="numeric" required="true">
        <cfargument name="task_code_id" type="numeric" required="true">
        <cfargument name="travel_date" type="date" required="true">
        <cfargument name="travel_name" type="string" required="true">
        <cfargument name="odometer_start" type="numeric" required="true">
        <cfargument name="odometer_end" type="numeric" required="false">
        --->

        <cfset project.logTravel(form.task_id, form.assoc_id, form.task_code_id, form.travel_date, form.travel_name, form.odometer_start, form.odometer_end)>

        <cfset eventText = prefiniti.getLongname(session.user.id) & " has logged travel on project " & project.project_name & ".">
        <cfset prefiniti.writeUserEvent(session.user.id, "car.png", eventText)>
    
        <cfset result.ok = true>
        <cfset result.message = "Travel has been logged.">
        <cfset result.project_id = project.id>

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error logging travel.">
            <cfset result.error = {message: cfcatch.message, detail: cfcatch.detail}>  
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>                                