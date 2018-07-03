<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="AS_EDIT">
<!--
<wwaftitle>Edit Site Member Permissions</wwaftitle>
<wwafbreadcrumbs>Prefiniti,Sites,Edit Site Member Permissions</wwafbreadcrumbs>
-->
<cfparam name="RowNum" default="0">
<cfparam name="ColOdd" default="">
<cfparam name="ColColor" default="white">

<cfquery name="getAssoc" datasource="sites">
	SELECT * FROM site_associations WHERE id=#url.id#
</cfquery>

<cfquery name="getAssocPerms" datasource="sites">
	SELECT * FROM permission_entries WHERE assoc_id=#url.id#
</cfquery>

<cfquery name="getAllPerms" datasource="sites">
	SELECT * FROM permissions ORDER BY perm_key
</cfquery>    


<table width="500" cellspacing="0" cellpadding="5">
    <tr>
    	<td>Prefiniti User:</td>
        <td><cfmodule template="/jobviews/components/custNameByID.cfm" id="#getAssoc.user_id#"></td>
    </tr>
    <tr>
    	<td>Association Type:</td>
        <td>
        	<cfif #getAssoc.assoc_type# EQ 0>
            	Customer
			<cfelse>
            	Employee
			</cfif>   
        </td>
	</tr>
    <tr>
    	<td>Permissions:</td>
        <td>
        	<div style="height:200px; width:320px; overflow:auto; border:1px solid silver;">
        	<table width="100%" cellspacing="0">
           		
				<cfoutput query="getAllPerms">
                	<cfset RowNum=RowNum + 1>
					<cfset ColOdd=RowNum mod 2>
                    
                    <cfswitch expression="#ColOdd#">
                        <cfcase value=1>
                            <cfset ColColor="silver">
                        </cfcase>
                        <cfcase value=0>
                            <cfset ColColor="white">
                        </cfcase>
                    </cfswitch>
                	<tr>
                    	<td style="background-color:#ColColor#">#name#</td>
                        <td style="background-color:#ColColor#" align="right">
                        <cfmodule template="/authentication/components/permCheckbox.cfm" assoc_id="#getAssoc.id#" perm_id="#id#">
                        
                        </td>
					</tr>                        
                </cfoutput>                
              
            </table>
            </div>
        </td>
	</tr>
</table>