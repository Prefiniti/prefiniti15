<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="AS_VIEW">
<!--
<wwaftitle>Manage Site Memberships</wwaftitle>
<wwafbreadcrumbs>Prefiniti,Manage Site Membershipts</wwafbreadcrumbs>
-->

<cfquery name="getAssocs" datasource="sites">
	SELECT * FROM site_associations WHERE site_id=#url.current_site_id#
</cfquery>

<cfparam name="RowNum" default="0">
<cfparam name="ColOdd" default="">
<cfparam name="ColColor" default="white">


<div style="padding-left:30px;">
<table width="100%" cellspacing="0">
	<tr>
    	<th>Prefiniti User</th>
        <th>Membership Type</th>
        <th>&nbsp;</th>
    </tr>
    	<cfoutput query="getAssocs">
    		<cfset RowNum=RowNum + 1>
		<cfset ColOdd=RowNum mod 2>
		
		<cfswitch expression="#ColOdd#">
			<cfcase value=1>
				<cfset ColColor="##EFEFEF">
			</cfcase>
			<cfcase value=0>
				<cfset ColColor="white">
			</cfcase>
		</cfswitch>
    	<tr>
        	<td style="background-color:#ColColor#"><cfmodule template="/jobviews/components/custNameByID.cfm" id="#user_id#"></td>
            <td style="background-color:#ColColor#">
            	<cfif assoc_type EQ 0>
                	Customer
                <cfelse>
                	Employee
				</cfif>
			</td>
            <td style="background-color:#ColColor#">
            	<img src="/graphics/link_edit.png" align="absmiddle"/> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/authentication/components/editAssociation.cfm?id=#id#');">Edit Permissions</a>
            </td>                                    
        </tr>
    </cfoutput>
</table>
</div>