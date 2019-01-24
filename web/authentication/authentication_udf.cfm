<cffunction name="beginPasswordReset" returntype="void" output="false">
    <cfargument name="email" type="string" required="true">


    <cfquery name="acctExists" datasource="webwarecl">
        SELECT id FROM users WHERE username=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#" maxlength="255">
    </cfquery>

    <cfif acctExists.recordCount GT 0>

        <cfset requestID = createUUID()>
        <cfset expiration = dateAdd("h", 1, now())>

        <cfquery name="writeRequest" datasource="webwarecl">
            INSERT INTO password_reset_requests
                        (id,
                        user_id,
                        expiration)
            VALUES      (<cfqueryparam cfsqltype="cf_sql_varchar" value="#requestID#" maxlength="255">,
                        <cfqueryparam cfsqltype="cf_sql_bigint" value="#acctExists.id#">,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value="#expiration#">)
        </cfquery>
        <cfscript>
            var message = new Prefiniti.MailTemplate("password_reset", arguments.email, "Geodigraph Hub Password Reset", {
                requestID: requestID
            });

            message.send();
        </cfscript>
    </cfif>
</cffunction>

<cffunction name="confirmAccount" returntype="void" output="false">
    <cfargument name="confirm_id" type="string" required="true">
    <cfargument name="password" type="string" required="true">


    <cfquery name="setConfirmed" datasource="webwarecl">
        UPDATE users SET confirmed=1, account_enabled=1, password="#hash(arguments.password, "SHA-512")#" WHERE confirm_id="#arguments.confirm_id#"
    </cfquery>

    <cfquery name="resetConfID" datasource="webwarecl">
        UPDATE users SET confirm_id="#createUUID()#" WHERE confirm_id="#arguments.confirm_id#"
    </cfquery>

</cffunction>

<cffunction name="emailTaken" returntype="boolean" output="false">
    <cfargument name="emailAddress" type="string" required="true">

    <cfquery name="chkEmail" datasource="webwarecl">
        SELECT id FROM users WHERE username="#arguments.emailAddress#" OR email="#arguments.emailAddress#"
    </cfquery>

    <cfif chkEmail.recordCount GT 0>
        <cfreturn true>
    <cfelse>
        <cfreturn false>
    </cfif>
</cffunction>

<cffunction name="getUserByEmail" returntype="Prefiniti.Authentication.UserAccount">
    <cfargument name="email" type="string" required="true">

    <cfquery name="getUserID" datasource="webwarecl">
        SELECT id FROM users WHERE username="#arguments.email#" OR email="#arguments.email#"
    </cfquery>

    <cfreturn new Prefiniti.Authentication.UserAccount({id: getUserID.id}, false)>
</cffunction>

<cffunction name="getUserByAssociationID" returntype="Prefiniti.Authentication.UserAccount">
    <cfargument name="n_assoc_id" type="numeric" required="yes">

    <cfquery name="getUserID" datasource="sites">
        SELECT user_id FROM site_associations WHERE id=#arguments.n_assoc_id#
    </cfquery>

    <cfreturn new Prefiniti.Authentication.UserAccount({id: getUserID.user_id}, false)>
</cffunction>

<cffunction name="getTaskCodes" returntype="query">
    <cfargument name="site_id" type="numeric" required="true">

    <cfquery name="getTaskCodes" datasource="webwarecl">
        SELECT * FROM task_codes WHERE site_id=#arguments.site_id# ORDER BY item
    </cfquery>

    <cfreturn getTaskCodes>
</cffunction>

<cffunction name="getPermissionByKey" returntype="boolean">
	<cfargument name="sz_key" type="string" required="yes">
    <cfargument name="n_assoc_id" type="numeric" required="yes">

    <cfset user = getUserByAssociationID(n_assoc_id)>

    <cfif user.webware_admin EQ 1>
        <cfreturn true>
    </cfif>
   
   	<cfparam name="tperm_id" default="">
    
    <cfquery name="get_perm_id" datasource="sites">
    	SELECT * FROM permissions WHERE perm_key='#sz_key#'
   	</cfquery>
    
    <cfif get_perm_id.recordCount EQ 0>
        <cfreturn false>
    </cfif>

    <cfset tperm_id=#get_perm_id.id#>
    
    <cfquery name="get_entry" datasource="sites">
    	SELECT * FROM permission_entries WHERE perm_id=#tperm_id# AND assoc_id=#n_assoc_id#
	</cfquery>
    
    <cfif get_entry.RecordCount EQ 0>
    	<cfreturn "false">
    <cfelse>
    	<cfreturn "true">
	</cfif>                
</cffunction>

<cffunction name="grantPermission" returntype="void">
	<cfargument name="sz_key" type="string" required="yes">
    <cfargument name="n_assoc_id" type="string" required="yes">
    
    <cfparam name="tperm_id" default="">
    
    <cfquery name="get_perm_id" datasource="sites">
    	SELECT * FROM permissions WHERE perm_key='#sz_key#'
   	</cfquery>
    
    <cfset tperm_id=#get_perm_id.id#>

	<cfquery name="set_perm" datasource="sites">
    	INSERT INTO permission_entries
        	(assoc_id,
            perm_id)
		VALUES
        	(#n_assoc_id#,
            #tperm_id#)
	</cfquery>
</cffunction>

<cffunction name="getEmployeeRecord" returntype="query">
    <cfargument name="assoc_id" type="numeric" required="yes">

    <cfquery name="chkRecord" datasource="sites">
        SELECT * FROM employees WHERE assoc_id=#arguments.assoc_id#
    </cfquery>

    <cfif chkRecord.RecordCount GT 0>
        <cfreturn chkRecord>
    <cfelse>
        <cfreturn createEmployeeRecord(arguments.assoc_id, "", "", "", "", "", "", "", "Active", "", 0, "")>
    </cfif>
</cffunction>

<cffunction name="createEmployeeRecord" returntype="query">
    <cfargument name="assoc_id" type="numeric" required="true">
    <cfargument name="application_date" type="string" required="true">
    <cfargument name="hire_date" type="string" required="true">
    <cfargument name="termination_date" type="string" required="true">
    <cfargument name="title" type="string" required="true">
    <cfargument name="application" type="string" required="true">
    <cfargument name="resume" type="string" required="true">
    <cfargument name="notes" type="string" required="true">
    <cfargument name="employment_status" type="string" required="true">
    <cfargument name="wage_basis" type="string" required="true">
    <cfargument name="wage" type="numeric" required="true">
    <cfargument name="payroll_frequency" type="string" required="true">

    <cfquery name="createEmployeeRecord" datasource="sites">
        INSERT INTO employees
            (assoc_id,
            <cfif arguments.application_date NEQ "">
            application_date,
            </cfif>
            <cfif arguments.hire_date NEQ "">
            hire_date,
            </cfif>
            <cfif arguments.termination_date NEQ "">
            termination_date,
            </cfif>
            title,
            application,
            resume,
            notes,
            employment_status,
            wage_basis,
            wage,
            payroll_frequency)
        VALUES
            (#arguments.assoc_id#,
            <cfif arguments.application_date NEQ "">
            #createODBCDate(arguments.application_date)#,
            </cfif>
            <cfif arguments.hire_date NEQ "">
            #createODBCDate(arguments.hire_date)#,
            </cfif>
            <cfif arguments.termination_date NEQ "">
            #createODBCDate(arguments.termination_date)#,
            </cfif>
            "#arguments.title#",
            "#arguments.application#",
            "#arguments.resume#",
            "#arguments.notes#",
            "#arguments.employment_status#",
            "#arguments.wage_basis#",
            #arguments.wage#,
            "#arguments.payroll_frequency#")
    </cfquery>

    <cfreturn getEmployeeRecord(arguments.assoc_id)>

</cffunction>

<cffunction name="getAssociationsByUser" returntype="query">
	<cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="gabu" datasource="sites">
		SELECT * FROM site_associations WHERE user_id=#user_id#
	</cfquery>

	<cfreturn #gabu#>
</cffunction>    
                            
<cffunction name="getPermissionNameByKey" returntype="string">
	<cfargument name="sz_key" type="string" required="yes">
    
    <cfquery name="gPermName" datasource="sites">
    	SELECT name FROM permissions WHERE perm_key='#sz_key#'
	</cfquery>
    
    <cfreturn #gPermName.name#>
</cffunction>

<cffunction name="getSiteNameByID" returntype="string">
	<cfargument name="site_id" type="numeric" required="yes">
    
    <cfquery name="gSiteName" datasource="sites">
    	SELECT SiteName FROM sites WHERE SiteID=#site_id#
    </cfquery>
    
    <cfreturn #gSiteName.SiteName#>
</cffunction>

<cffunction name="getSiteNameByAssociation" returntype="string">

</cffunction>

<cffunction name="getUserInformation" returntype="query">
	<cfargument name="user_id" type="numeric" required="yes">
    
	<cfquery name="gbi" datasource="webwarecl">
    	SELECT * FROM users WHERE id=#user_id#
    </cfquery>    
    
    <cfreturn #gbi#>
</cffunction>    

<cffunction name="getUserLocations" returntype="query">
	<cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="gul" datasource="webwarecl">
    	SELECT * FROM locations WHERE user_id=#user_id#
    </cfquery>
    
    <cfreturn #gul#>
</cffunction>

<cffunction name="getPublicUserLocations" returntype="query">
	<cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="gul" datasource="webwarecl">
    	SELECT * FROM locations WHERE user_id=#user_id# AND public_location=1
    </cfquery>
    
    <cfreturn #gul#>
</cffunction>
                           


<cffunction name="getSiteInformation" returntype="query">
	<cfargument name="site_id" type="numeric" required="yes">

	<cfquery name="gsi" datasource="sites">
    	SELECT * FROM sites WHERE SiteID=#site_id#
	</cfquery>
    
    <cfreturn #gsi#>
</cffunction>

<cffunction name="getIndustryByID" returntype="string">
	<cfargument name="industry_id" type="numeric" required="yes">
    
    <cfquery name="gibi" datasource="sites">
    	SELECT industry_name FROM industries WHERE id=#industry_id#
	</cfquery>
    
    <cfreturn #gibi.industry_name#>
</cffunction>   

<cffunction name="wwGetDepartments" returntype="query">
	<cfargument name="site_id" type="numeric" required="yes">
    
    <cfquery name="wwgd" datasource="sites">
    	SELECT * FROM departments WHERE site_id=#site_id#
	</cfquery>
    
    <cfreturn #wwgd#>
</cffunction>

<cffunction name="wwGetDepartmentMembers" returntype="query">
	<cfargument name="department_id" type="numeric" required="yes">
    
    <cfquery name="wwgdm" datasource="sites">
    	SELECT * FROM department_entries WHERE department_id=#department_id#
	</cfquery>
    
    <cfreturn #wwgdm#>
</cffunction>

<cffunction name="wwCreateDepartment" returntype="void">
	<cfargument name="site_id" type="numeric" required="yes">
    <cfargument name="department_name" type="string" required="yes">
    
    <cfquery name="wwcd" datasource="sites">
    	INSERT INTO departments
        	(site_id,
            department_name)
		VALUES 
        	(#site_id#,
            '#department_name#')
	</cfquery>
</cffunction> 

<cffunction name="wwCreateDepartmentMember" returntype="void">
	<cfargument name="department_id" type="numeric" required="yes">
    <cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="checkDMExists" datasource="sites">
    	SELECT * FROM department_entries WHERE department_id=#department_id# AND user_id=#user_id#
	</cfquery>
    
    <cfif checkDMExists.RecordCount GT 0>
    	<cfreturn>
	</cfif>                
    
    <cfquery name="wwcdm" datasource="sites">
    	INSERT INTO department_entries
        	(department_id,
            user_id)
		VALUES
        	(#department_id#,
            #user_id#)
	</cfquery>
</cffunction>

<cffunction name="wwSetDepartmentManager" returntype="void">
	<cfargument name="department_id" type="numeric" required="yes">
    <cfargument name="user_id" type="numeric" required="yes">
    
    <cfquery name="wwsdm" datasource="sites">
    	UPDATE departments
        SET		manager_id=#user_id#
        WHERE	id=#department_id#
	</cfquery>
</cffunction>            

<cffunction name="wwDeleteDepartmentMember" returntype="void">
	<cfargument name="id" type="numeric" required="yes">
    
    <cfquery name="wwddm" datasource="sites">
    	DELETE FROM department_entries WHERE id=#id#
	</cfquery>
</cffunction>            

<cffunction name="wwGetEmployeesBySite" returntype="query">
	<cfargument name="site_id" type="numeric" required="yes">
    
    <cfquery name="wwgebs" datasource="sites">
    	SELECT * FROM site_associations WHERE site_id=#site_id# AND assoc_type=1
	</cfquery>
    
    <cfreturn #wwgebs#>
</cffunction>    

<cffunction name="wwGetCustomersBySite" returntype="query">
    <cfargument name="site_id" type="numeric" required="yes">
    
    <cfquery name="wwgebs" datasource="sites">
        SELECT * FROM site_associations WHERE site_id=#site_id# AND assoc_type=0
    </cfquery>
    
    <cfreturn #wwgebs#>
</cffunction>         

                            
<cffunction name="wwIsUserInDepartment" returntype="boolean">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="department_id" type="numeric" required="yes">
    
    <cfquery name="wwiuid" datasource="sites">
    	SELECT * FROM department_entries WHERE department_id=#department_id# and user_id=#user_id#
	</cfquery>
    
    <cfif wwiuid.RecordCount NEQ 0>
    	<cfreturn true>
    <cfelse>
    	<cfreturn false>
	</cfif>                
    
</cffunction>  

<cffunction name="wwIsUserDepartmentManager" returntype="boolean">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="department_id" type="numeric" required="yes">
    
    <cfquery name="wwiudm" datasource="sites">
    	SELECT * FROM departments WHERE id=#department_id# AND manager_id=#user_id#
	</cfquery>
    
    <cfif wwiudm.RecordCount NEQ 0>
    	<cfreturn true>
	<cfelse>
    	<cfreturn false>
	</cfif>
    
</cffunction>                                                  

<cffunction name="wwDepartmentName" returntype="string">
	<cfargument name="department_id" type="numeric" required="yes">
    
    <cfquery name="wwdn" datasource="sites">
    	SELECT department_name FROM departments WHERE id=#department_id#
    </cfquery>
    
    <cfreturn #wwdn.department_name#>
</cffunction>	    

<cffunction name="wwDepartmentManager" returntype="numeric">
	<cfargument name="department_id" type="numeric" required="yes">
    
    <cfquery name="wwdm1" datasource="sites">
    	SELECT manager_id FROM departments WHERE id=#department_id#
	</cfquery>

	<cfreturn #wwdm1.manager_id#>
</cffunction>                

<cffunction name="getUserIDs" returntype="array">

    <cfquery name="getUsers" datasource="webwarecl">
        SELECT id FROM users
    </cfquery>

    <cfset outputArray = arrayNew()>

    <cfloop query="#getUsers#">
        <cfset outputArray.append(getUsers.id)>
    </cfloop>

    <cfreturn outputArray>

</cffunction>

<cffunction name="userIDExists" returntype="boolean">
    <cfargument name="user_id" type="numeric" required="true">

    <cfquery name="userIDExists" datasource="webwarecl">
    SELECT id FROM users WHERE id=#arguments.user_id#
    </cfquery>

    <cfif userIDExists.RecordCount GT 0>
        <cfreturn true>
    <cfelse>
        <cfreturn false>
    </cfif>

</cffunction>

<cffunction name="getSiteAssociations" returntype="query">
    <cfargument name="user_id" type="numeric" required="true">

    <cfquery name="getSiteAssociations" datasource="sites">
        SELECT * FROM site_associations WHERE user_id=#arguments.user_id#
    </cfquery>

    <cfreturn getSiteAssociations>
</cffunction>

<cffunction name="getLastSite" returntype="numeric">
    <cfargument name="user_id" type="numeric" required="true">

    <cfquery name="getLastSite" datasource="webwarecl">
        SELECT last_site_id FROM users WHERE id=#arguments.user_id# 
    </cfquery> 

    <cfreturn getLastSite.last_site_id>
</cffunction>

