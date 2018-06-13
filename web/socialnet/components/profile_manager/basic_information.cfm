<cfinclude template="/authentication/authentication_udf.cfm">

<div class="homeHeader"><img src="/graphics/page.png" align="absmiddle" /> Basic Information</div>

<cfparam name="u" default="">
<cfset u=getUserInformation(#attributes.user_id#)>

<cfoutput query="u">
<div style="padding-left:20px;">
<form name="updateBasic" id="updateBasic">
<input type="hidden" name="user_id" id="user_id" value="#attributes.user_id#" />
	<table width="100%">
    	<tr>
        	<td>First Name:</td>
    		<td>
            	<input type="text" name="firstName" id="firstName" maxlength="255"  value="#firstName#"/>
                <label>Middle Initial: <input name="middleInitial" type="text" id="middleInitial" width="2" maxlength="1" value="#middleInitial#"/></label>
                <label>Last: <input type="text" name="lastName" id="lastName" maxlength="255" value="#lastName#"/></label>
            </td>
		</tr>            
    	<tr>
        	<td>Gender:</td>
            <td>
            	<p>
			    <label>
			      <input type="radio" name="gender" value="M" <cfif gender EQ "M">checked</cfif>>
			      Male</label>
			    <br>
			    <label>
			      <input type="radio" name="gender" value="F"  <cfif gender EQ "F">checked</cfif>>
			      Female</label>
			    <br>
			    </p>
            </td>
		</tr>            
        <tr>
			<td>Birthday:</td>
			<td><cfmodule template="/controls/date_picker.cfm" ctlname="birthday" startdate="#birthday#"></td>
		</tr>
        <tr>
        	<td colspan="2" align="right">
            	<input type="button" class="normalButton" name="submit" value="Save Changes" onclick="AjaxSubmitForm(AjaxGetElementReference('updateBasic'), '/socialnet/components/profile_manager/basic_information_sub.cfm', 'userActionTarget');" />
            </td>
		</tr>            
    </table>
</form>
</div>
</cfoutput>