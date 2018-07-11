<!--
    <wwaftitle>Get Associations</wwaftitle>
    <wwafbreadcrumbs>Geodigraph PM,Sites,Get Associations</wwafbreadcrumbs>
-->

<cfquery name="getAssoc" datasource="sites">
	SELECT * FROM site_associations WHERE site_id=#url.site_id#
</cfquery>

<cfparam name="RowNum" default="0">
<cfparam name="ColOdd" default="">
<cfparam name="ColColor" default="white">   
 
<h2><cfmodule template="/authentication/components/siteNameByID.cfm" id="#url.site_id#"></h2>    

<cfoutput><img src="/graphics/link_add.png"> <a href="/webware_admin/addAssociation.cfm?site_id=#url.site_id#">Add Association</a></cfoutput>
<table width="100%" cellspacing="0">
	<tr>
    	<th>User</th>
        <th>Association</th>
    </tr>
    
    <cfoutput query="getAssoc">
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
    	<td style="background-color:#ColColor#"><cfmodule template="/jobviews/components/custNameByID.cfm" id="#user_id#"></td>
        <td style="background-color:#ColColor#">
        	<cfif #assoc_type# EQ 0>
            	Customer
			<cfelse>
				Employee
			</cfif>
		</td>
	</tr>
    </cfoutput>                                                                    
</table>    

