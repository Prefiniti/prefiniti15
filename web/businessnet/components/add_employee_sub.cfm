<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>    
    <cfset result = {}>

    <cftry>
        
        <cfif form.new_account EQ 1>
            <cfset accountParams = {
                email: form.email,
                firstName: form.firstName,
                lastName: form.lastName
            }>

            <cfif trim(form.middleInitial) NEQ "">
                <cfset accountParams.middleInitial = form.middleInitial>
            </cfif>

            <cfset account = new Prefiniti.Authentication.UserAccount(accountParams, true)>
        <cfelse>
            <cfset account = prefiniti.getUserByEmail(form.email)>
        </cfif>

        <cfset assoc_id = account.addSiteAssociation(session.current_site_id, "employee")>

        <cfset initialPerms = ["AS_LOGIN",
                               "MA_VIEW",
                               "MA_WRITE",
                               "WF_CREATE",
                               "WF_EDIT",
                               "WF_VIEW",
                               "WF_VIEWSTATS"]>

        <cfloop array="#initialPerms#" item="permKey">
            <cfset account.grantPermission(assoc_id, permKey)>
        </cfloop>           

        <cfscript>
            prefiniti.createEmployeeRecord(assoc_id,
                                           form.application_date,
                                           form.hire_date,
                                           form.termination_date,
                                           form.title,
                                           "",
                                           "",
                                           "",
                                           form.employment_status,
                                           form.wage_basis,
                                           form.wage,
                                           form.payroll_frequency);
        </cfscript>

        <cfset eventText = prefiniti.getLongname(session.user.id) & " has added a new employee.">
        <cfset prefiniti.writeUserEvent(session.user.id, "user_add.png", eventText)>
        <cfset prefiniti.writeUserEvent(account.id, "user_add.png", eventText)>

        <cfset result.ok = true>
        <cfset result.message = "Employee has been added.">

        <cfcatch type="any">
            <cfset result.ok = false>
            <cfset result.message = "Error adding employee.">
            <cfset result.tagContext = cfcatch.tagContext> 
            <cfset result.message = cfcatch.message & cfcatch.detail>
            <cfset result.detail = cfcatch.detail> 

            <cfif cfcatch.type EQ "database">
                <cfset result.sql = cfcatch.sql>
            </cfif>
        </cfcatch>
    </cftry>
</cfsilent>
<cfoutput>#serializeJson(result)#</cfoutput>                                