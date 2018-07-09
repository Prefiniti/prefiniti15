<cfoutput>
<!--
<wwaftitle>Account Settings</wwaftitle>
<wwafbreadcrumbs>Prefiniti,Account Settings</wwafbreadcrumbs>
-->
</cfoutput>


<table width="100%">
	<tr>
    	<td valign="top" width="200">c
        	<cfoutput>
        	<div style="width:200px; background-color:##EFEFEF; -moz-border-radius:5px; padding:5px; margin:5px;">
                <div style="padding-bottom:4px;">
                	<i class="fa fa-info-circle"></i> <a href="javascript:editUser(#url.calledByUser#, 'basic_information.cfm');">Basic Information</a>
                </div>

                <div style="padding-bottom:4px;">
	                <i class="fa fa-tag"></i> <a href="javascript:editUser(#url.calledByUser#, 'background.cfm');">Background &amp; Interests</a>
    			</div>

                <div style="padding-bottom:4px;">
	                <i class="fa fa-address-card"></i> <a href="javascript:editUser(#url.calledByUser#, 'contact_info.cfm');">Contact Information</a>
    			</div>
                
                <div style="padding-bottom:4px;">
	                <i class="fa fa-map-marker-alt"></i> <a href="javascript:editUser(#url.calledByUser#, 'locations.cfm');">My Locations</a>
    			</div>
                
                <div style="padding-bottom:4px;">
	                <i class="fa fa-bell"></i> <a href="javascript:editUser(#url.calledByUser#, 'notifications.cfm');">Notifications</a>
    			</div>
				<div style="padding-bottom:4px;">
	                <i class="fa fa-shield-alt"></i> <a href="javascript:editUser(#url.calledByUser#, 'privacy.cfm');">Privacy Settings</a>
    			</div>
                           
            	<div id="userActionTarget"></div>    
            </div>
            
			</cfoutput>            
        </td>
		<td valign="top">
        	<cfmodule template="/socialnet/components/profile_manager/#url.section#" user_id="#url.calledByUser#">
        </td>
    </tr>        
</table>



