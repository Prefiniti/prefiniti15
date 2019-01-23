<!--
    <wwaftitle>Get Associations</wwaftitle>
    <wwafbreadcrumbs>Geodigraph Hub,Sites,Get Associations</wwafbreadcrumbs>
-->

<cfset prefiniti = new Prefiniti.Base()>

<cfquery name="getAssoc" datasource="sites">
	SELECT * FROM site_associations WHERE site_id=#url.site_id#
</cfquery>
 
 
<h2><cfoutput>#prefiniti.getSiteNameByID(url.site_id)#</cfoutput></h2>    

<cfoutput><img src="/graphics/link_add.png"> <a href="/webware_admin/addAssociation.cfm?site_id=#url.site_id#">Add</a></cfoutput>
<table class="table table-striped table-hover">
	<tr>
    	<th>User</th>
        <th>Role</th>
    </tr>
    
    <cfoutput query="getAssoc">
        <cfset user = getUserByAssociationID(user_id)>
      	<tr>
        	<td>#user.longName#</td>
            <td>
            	<cfif #assoc_type# EQ 0>
                	Customer
    			<cfelse>
    				Employee
    			</cfif>
    		</td>
    	</tr>
    </cfoutput>                                                                    
</table>    

