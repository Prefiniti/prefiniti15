<cfif #session.loggedin# EQ "yes">
<div id="headBar"><table width="100%" cellspacing="0"><tr><th align="left"><a href="##"  onclick="return clickreturnvalue()" onmouseover="dropdownmenu(this, event, appMenu, '150px')" onmouseout="delayhidemenu()"><img src="graphics/pi-16x16.png" border="0" align="absmiddle"/></a> Prefiniti - <cfmodule template="/authentication/components/siteNameByID.cfm" id="#session.current_site_id#"></th><th align="right" style="text-align:right;"><a href="javascript:closeWebware();"><img src="graphics/cross.png" border="0" align="absmiddle" /></a></th></tr></table></div><cfelse>
<div style="padding-left:30px;">
<table width="800" cellpadding="0" cellspacing="0" style="border-bottom:1px solid #EFEFEF;">
	<tr>
    	<td align="left" width="40%" style="padding-top:30px;" valign="bottom">
			<a href="/default.cfm"><img id="plogo" src="graphics/prefiniti.png" style="vertical-align:middle; height:56px; opacity:0;" height="56" align="absmiddle" border="0"></a>
        </td>
        <td align="right" width="60%" valign="bottom" style="vertical-align:bottom;">
        	<a href="##">Documentation</a> | <a href="##">About Us</a> | <a href="##">Business Account Inquiry</a>
        </td> 
	</tr>
</table>
</div>
</cfif>