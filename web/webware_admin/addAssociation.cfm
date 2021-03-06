<!--
    <wwaftitle>Add Association</wwaftitle>
  <wwafbreadcrumbs>Geodigraph Hub,Sites,Add Association</wwafbreadcrumbs>
-->

<h2><cfmodule template="/authentication/components/siteNameByID.cfm" id="#url.site_id#"></h2>

<form name="addAssoc" action="/webware_admin/addAssociationSubmit.cfm" method="post" target="addAssocTgt">
<table width="600">
	<tr>
    	<td>User:</td>
        <td><span id="user_name">[None Selected]</span>
        	<cfoutput><input type="hidden" name="site_id" value="#url.site_id#"></cfoutput>
        	<input type="hidden" name="user_id" id="user_id">
			<div id="userPicker">
				<cfmodule template="/authentication/components/userPicker.cfm" nameTgt="user_name" idTgt="user_id">
			</div>
		</td>
	</tr>
    <tr>
    	<td>Association with <cfmodule template="/authentication/components/siteNameByID.cfm" id="#url.site_id#">:</td>
       	<td>
        	<label><input type="radio" name="assoc_type" value="0" checked>Customer</label><br>
            <label><input type="radio" name="assoc_type" value="1">Employee</label>
		</td>
	</tr>                            
    <tr>
    	<td colspan="2" align="right">
        	<input class="normalButton" type="submit" name="submit" value="Add Association">
		</td>
	</tr>                            
</table>                
</form>                    

<iframe name="addAssocTgt" id="addAssocTgt"></iframe>    
    
    