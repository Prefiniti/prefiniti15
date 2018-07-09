<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    <cfset project = new Prefiniti.ProjectManagement.Project(form.project_id)>
    <cfset result = {}>

    <cftry>
        <!---
        <cfargument name="location_name" type="string" required="yes">
        <cfargument name="address" type="string" required="yes">
        <cfargument name="city" type="string" required="yes">
        <cfargument name="state" type="string" required="yes">
        <cfargument name="zip" type="string" required="yes">
        <cfargument name="subdivision" type="string" required="yes">
        <cfargument name="lot" type="string" required="yes">
        <cfargument name="block" type="string" required="yes">
        <cfargument name="trs_section" type="string" required="yes">
        <cfargument name="trs_township" type="string" required="yes">
        <cfargument name="trs_range" type="string" required="yes">
        <cfargument name="trs_meridian" type="string" required="yes">
        <cfargument name="latitude" type="string" required="yes">
        <cfargument name="longitude" type="string" required="yes">
        <cfargument name="elevation" type="string" required="yes">

        --->

        <cfset trs_township = form.township_number & form.township_direction>
        <cfset trs_range = form.range_number & form.range_direction>

        <cfscript>
         project.addLocation(form.location_name,
                            form.address,
                            form.city,
                            form.state,
                            form.zip,
                            form.subdivision,
                            form.lot,
                            form.block,
                            form.section,
                            trs_township,
                            trs_range,
                            form.trs_meridian,
                            form.latitude,
                            form.longitude,
                            form.elevation);
        </cfscript>                       

        <cfset eventText = prefiniti.getLongname(session.user.id) & " has added location <strong>" & form.location_name & "</strong> to project " & project.project_name & ".">
        
        <cfset prefiniti.writeUserEvent(project.project_client.id, "map_add.png", eventText)>
        <cfset prefiniti.writeUserEvent(project.project_employee.id, "map_add.png", eventText)>
        <cfset prefiniti.writeUserEvent(session.user.id, "map_add.png", eventText)>
    
        <cfset result.ok = true>
        <cfset result.message = "Location added.">
        <cfset result.project_id = project.id>

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error adding location.">
            <cfset result.error = {message: cfcatch.message, detail: cfcatch.detail}>  
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>                                