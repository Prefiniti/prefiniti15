<cffunction name="getPermissionByKey" returntype="boolean">
	<cfargument name="sz_key" type="string" required="yes">
    <cfargument name="n_assoc_id" type="numeric" required="yes">
   
   	<cfparam name="tperm_id" default="">
    
    <cfquery name="get_perm_id" datasource="sites">
    	SELECT * FROM permissions WHERE perm_key='#sz_key#'
   	</cfquery>
    
    <cfset tperm_id=#get_perm_id.id#>
    
    <cfquery name="get_entry" datasource="sites">
    	SELECT * FROM permission_entries WHERE perm_id=#tperm_id# AND assoc_id=#n_assoc_id#
	</cfquery>
    
    <cfif get_entry.RecordCount EQ 0>
    	<cfreturn "false">
    <cfelse>
    	<cfreturn "true" >
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
	<cfargument name="site_id" required="yes">
    
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