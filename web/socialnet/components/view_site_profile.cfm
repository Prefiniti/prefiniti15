<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">



<cfparam name="si" default="">
<cfset si=getSiteInformation(url.site_id)>
<cfoutput>
<!--
	<wwafcomponent>#si.SiteName# Company Profile</wwafcomponent>
-->    
</cfoutput>

<cfoutput query="si">
	<table width="100%">
    	<tr>
        	<td width="200" valign="top">
            	<div style="padding:5px; margin:3px; background-color:##EFEFEF; -moz-border-radius:5px;">
				<cfif logo NEQ "">
                	<img src="/SiteContent/#url.site_id#/#logo#" width="200">
				</cfif>
                <strong>Industry: </strong>#getIndustryByID(industry)#<br>
                </div>
			</td>
        	<td valign="top">
    			<h3 class="stdHeader" style="padding-bottom:0px; margin-bottom:0px;">#SiteName#</h3>            
    <em>&quot;#slogan#&quot;</em>
    
                    <div class="homeHeader"><a href="/news/rss.cfm?current_site_id=#url.current_site_id#" target="_blank"><img src="graphics/feed.png" align="absmiddle" border="0"/></a> Site News</div>
                <div style="padding-left:30px;">
                <cfmodule template="/news/components/newsView.cfm"  site_id="#SiteID#">
                </div>
    		</td>
		</tr>
	</table>                    
</cfoutput>
