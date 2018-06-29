

<cffunction name="getMenus" returntype="query">
    <cfquery name="getMenus" datasource="webwarecl">
        SELECT * FROM menus
    </cfquery>

    <cfreturn getMenus>
</cffunction>

<cffunction name="getMenuItems" returntype="void">
	<cfargument name="pmenu_id" required="yes" type="numeric">
    <cfargument name="handle" required="yes" type="string">
    
    <cfparam name="i" default="0">
    
    <cfquery name="gMI" datasource="webwarecl">
    	SELECT * FROM menu_entries WHERE menu_id=#pmenu_id#
    </cfquery>
    
	<cfoutput query="gMI">
		<cfif getPermissionByKey('#perm_key#', #session.current_association#) EQ true>

            <cfif direct EQ 0>
                <li><a href="##" onclick="AjaxLoadPageToDiv('tcTarget', '#target#');">#caption#</a></li>
            <cfelse>
                <li><a href="#target#">#caption#</a></li>
			</cfif>				

        </cfif>
    </cfoutput> 
		
    
    <cfreturn>
</cffunction>
