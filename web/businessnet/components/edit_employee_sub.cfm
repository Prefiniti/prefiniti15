<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>
    <cfset employee = prefiniti.getUserByAssociationID(form.assoc_id)>
    <cfset result = {}>

    <cftry>
        <cfquery name="update_employee_record" datasource="sites">
            UPDATE  employees
            SET     <cfif form.application_date NEQ "">application_date=#createODBCDate(form.application_date)#,</cfif>
                    <cfif form.hire_date NEQ "">hire_date=#createODBCDate(form.hire_date)#,</cfif>
                    <cfif form.termination_date NEQ "">termination_date=#createODBCDate(form.termination_date)#,</cfif>
                    title="#form.title#",
                    application="#form.application#",
                    resume="#form.resume#",
                    notes="#form.notes#",
                    employment_status="#form.employment_status#",
                    wage_basis="#form.wage_basis#",
                    wage=#form.wage#,
                    payroll_frequency="#form.payroll_frequency#"
            WHERE   assoc_id=#form.assoc_id#
        </cfquery>        

        <cfset eventText = prefiniti.getLongname(session.user.id) & " has updated employee information for " & employee.longName & ".">
        <cfset prefiniti.writeUserEvent(session.user.id, "user_edit.png", eventText)>
        <cfset prefiniti.writeUserEvent(employee.id, "user_edit.png", eventText)>

        <cfset result.ok = true>
        <cfset result.message = "Employee information has been updated.">

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error updating employee information.">  
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>                                