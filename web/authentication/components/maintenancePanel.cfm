<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="WW_SITEMAINTAINER">
<!--
<wwaftitle>Geodigraph Hub Site Maintenance</wwaftitle>
<wwafbreadcrumbs>Geodigraph Hub,Sites,Site Maintenance</wwafbreadcrumbs>
-->



<table width="100%">
	<tr>
    	<td valign="top" width="200">
        	<cfoutput>
        	<div style="width:200px; background-color:##EFEFEF; -moz-border-radius:5px; padding:5px; margin:5px;">
                
                <div style="padding-bottom:4px;">
                	<img src="/graphics/group_edit.png" align="absmiddle"> <a href="javascript:editSite(#url.current_site_id#, 'departments.cfm');">Departments</a>
                </div>
                <div style="padding-bottom:4px;">
                	<img src="/graphics/lightning.png" align="absmiddle"> <a href="javascript:editSite(#url.current_site_id#, 'order_settings.cfm');">Business Events</a>
                </div>
               
                
            	<div id="userActionTarget">
            	</div>    
            </div>
            
			</cfoutput>            
        </td>
		<td valign="top">
        	<cfmodule template="/authentication/components/site_manager/#url.section#" site_id="#url.current_site_id#">
        </td>
    </tr>        
</table>
