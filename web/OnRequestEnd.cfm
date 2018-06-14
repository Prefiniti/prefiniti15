<cfabort>
<cfif NOT IsDefined("url.supressApplication")>
<cfif #session.usertype# EQ 1>
	<cfif #session.loggedin# EQ "yes">
		
			<!---<cfinclude template="itemAttention.cfm">--->
		
	</cfif>
</cfif>
</div>
<div id="scrBot"></div>

<cfif #session.loggedIn# EQ "yes">
<cfquery name="gPic" datasource="webwarecl">
	SELECT picture FROM users WHERE id=#session.userid#
</cfquery> 

<cfoutput>
<div style="position:absolute; margin-bottom:30px; bottom:0; left:0; width:250px; height:400px; z-index:300; display:none; background-color:##EFEFEF; -moz-opacity:.90; border-top:1px solid silver; border-right:1px solid silver;  border-left:1px solid silver; -moz-border-radius-topright:10px; -moz-border-radius-topleft:10px; padding-top:12px; padding-left:5px; padding-right:5px;" id="appMenu" onclick="hideDiv('appMenu');">
	<table width="100%" cellspacing="0">
	<tr>
	<td style="padding:8px; background-color:##EFEFEF; -moz-opacity:.90;"><cfif #gPic.picture# EQ "">
										<img src="/graphics/no_pic.gif" width="80" height="80">
									<cfelse>
										<img src="/authentication/profile_images/#gPic.picture#" width="80" height="80">
									</cfif></td>
	<td style="padding:8px; background-color:##EFEFEF; -moz-opacity:.90;" valign="top" align="right"><h3 align="right" style="font-family: 'Times New Roman', Times, serif; color:##3399CC; font-weight:lighter; font-size:24px; margin-top:3px; margin-bottom:0px; padding-botton:2px;">#session.longname#</h3></td>
	</tr></table>
	<hr />
	<div width="100%" style="background-color:white; border:none; padding:0px; margin:0px;">
	<table width="100%" cellpadding="3" cellspacing="0">
		<tr>
			<td><img src="/graphics/folder_go.png" align="absmiddle"/> <a href="javascript:showFileBrowser('#session.userid#', 0);">SmartDesk Information Manager</a></td>
		</tr>
		<tr>
			<td><img src="/graphics/user_edit.png" align="absmiddle"/> <a href="javascript:editUser('#session.userid#');">Edit My Profile</a></td>
		</tr>
		<tr>
			<td style="background-color:##EFEFEF; border-top:1px solid silver;"><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><img src="/graphics/door_out.png" align="absmiddle"/> <a href="logoff.cfm">Sign Out...</a></td>
		</tr>
	</table>
	</div>

</div>
</cfoutput>

<div style="position:absolute; bottom:0; left:0; width:100%; height:30px; background-color:#EFEFEF;" id="tBar">
<table width="100%" cellspacing="0" cellpadding="0">
	<tr>
		<td align="left"  valign="middle" style="background-color:#EFEFEF;">
										<img src="/graphics/webwareclmenu.png" onclick="showDiv('appMenu');">									</td>
		<td align="right" style="background-color:#EFEFEF;"><span id="cmp_invalid" style="display:inline;"><img src="/graphics/lock_open.png" align="absmiddle"/></span><span id="cmp_valid" style="display:none;"><img src="/graphics/lock.png" align="absmiddle" /></span> <span id="updateIcon"></span><span id="newMailIcon"></span><span id="clock"></span></td>
	</tr>
</table>
</div>
</cfif>

<!--- <div class="bodyWrapper" style="clear:both">
<table class="copyrightTable">
	<tr>
		<td>Copyright &copy; 2007 Center Line Services, LLC<br />Powered by <a href="/webware/default.cfm">WebWare 1.0</a> </td>
		<td align="right"><img src="graphics/webware.png" /></td>
	</tr>
</table>
	<div class="bottomLinks"><a href="##">Privacy</a>| <a href="##">Terms of Use</a></div>

	
</div> --->
</cfif>

