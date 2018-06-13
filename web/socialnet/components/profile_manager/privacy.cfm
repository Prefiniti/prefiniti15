<cfinclude template="/authentication/authentication_udf.cfm">

<div class="homeHeader"><img src="/graphics/lock.png" align="absmiddle" /> Privacy Settings</div>

<cfparam name="u" default="">
<cfset u=getUserInformation(#attributes.user_id#)>

<cfoutput>
<div style="padding-left:20px;">
	<form name="updatePrivacy" id="updatePrivacy">
	<input type="hidden" name="user_id" id="user_id" value="#attributes.user_id#" />
    <table width="100%">
    	<tr>
        	<td>Profile Search:</td>
    		<td><label><input type="checkbox" id="allowSearch" name="allowSearch"value="1" <cfif #u.allowSearch# EQ 1>checked</cfif>>Allow users to search for me</label></td>
        </tr>
        <tr>
        	<td colspan="2" align="right"><input type="button" class="normalButton" name="submit" value="Save Changes" onclick="AjaxSubmitForm(AjaxGetElementReference('updatePrivacy'), '/socialnet/components/profile_manager/privacy_sub.cfm', 'userActionTarget');" /></td>
    </table>
    </form>
</div>
</cfoutput>