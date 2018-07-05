<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="AS_EDIT">


<cfquery name="getAssoc" datasource="sites">
	SELECT * FROM site_associations WHERE id=#url.id#
</cfquery>

<cfquery name="getAssocPerms" datasource="sites">
	SELECT * FROM permission_entries WHERE assoc_id=#url.id#
</cfquery>

<cfquery name="getAllPerms" datasource="sites">
	SELECT * FROM permissions ORDER BY perm_key
</cfquery>    

<h3><cfmodule template="/jobviews/components/custNameByID.cfm" id="#getAssoc.user_id#"></h3>
<h4>
    <cfif #getAssoc.assoc_type# EQ 0>
        Client Permissions
    <cfelse>
        Employee Permissions
    </cfif>
</h4>

<div style="max-height: 200px; overflow-y: scroll; overflow-x: hidden;">
    <table class="table table-striped">
    	<tbody>
    		<cfoutput query="getAllPerms">               	
            	<tr>
                	<td>#name#</td>
                    <td align="right">
                        <cfmodule template="/businessnet/components/permissions_checkbox.cfm" assoc_id="#getAssoc.id#" perm_id="#id#">                    
                    </td>
    			</tr>                        
            </cfoutput>                
        </tbody>
    </table>
</div>
            