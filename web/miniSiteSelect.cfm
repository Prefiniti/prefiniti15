<cfquery name="getSites" datasource="sites">
	SELECT * FROM site_associations WHERE user_id=#session.userid#
</cfquery>

<div id="siteSelectWrapper" style="width:100%; background-color:#EFEFEF;">
<form name="siteSelect" action="/siteSelectSubmit.cfm" method="post" style="display:inline;">
	<label style="font-size:xx-small;">Current Site:
    <select name="siteAssociation" style="width:200px;">
    	<cfoutput query="getSites">
        	<option value="#id#" <cfif #id# EQ #session.current_association#>selected</cfif>>
            	<cfmodule template="/authentication/components/siteNameByID.cfm" id="#site_id#">
				<cfif #assoc_type# EQ 0>
                    &nbsp;- Customer
                <cfelse>
                    &nbsp;- Employee
                </cfif>
            </option>
        </cfoutput>
    </select></label>
    <input type="submit" class="normalButton" name="submitSiteSel" value="Switch Sites" />
</form>    
<cfif session.webware_admin EQ 1>
<img src="/graphics/group_edit.png" align="absmiddle"> <a href="/webware_admin/manageSites.cfm">Manage Sites</a> | <img src="/graphics/sound.png" align="absmiddle"> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/socialnet/components/postWebgram.cfm');">Post WebGram</a> | <img src="/graphics/wand.png" align="absmiddle" /> <a href="/prefiniti_framework_base.cfm">Reload Framework</a> | <img src="/graphics/lorry.png" align="absmiddle"/> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/framework/components/dump_url.cfm');">Dump URL</a><label style="color:black;"><input type="text" id="pageTest" /></label><input type="button" class="normalButton" onclick="AjaxLoadPageToDiv('tcTarget', GetValue('pageTest'));" value="Load to Content Bar"/><input type="button" class="normalButton" onclick="AjaxLoadPageToDiv('sbTarget', GetValue('pageTest'));" value="Load to Sidebar"/>
<!---<cfoutput>#getPermissionByKey("AS_LOGIN", session.current_association)#</cfoutput>--->
</cfif>

							
</div>
<div id="sbtTarget" style="height:20px; background-color:#EFEFEF; width:100%; border-top:1px solid #C0C0C0; vertical-align:bottom;"></div>
