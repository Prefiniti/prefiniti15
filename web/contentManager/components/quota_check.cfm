<cfinclude template="/contentmanager/cm_udf.cfm">



<cfparam name="pQuot" default="">
<cfparam name="quota_size" default="">
<cfset pQuot=getQuotaUsed(#attributes.user_id#)>
<cfset quota_size=getQuota(#attributes.user_id#)/1024>
<cfset total_used=cmsTotalSpaceUsed(#attributes.user_id#)/1024>

<div style="border:1px solid #EFEFEF; padding-bottom:10px; padding-left:10px; padding-right:10px; margin:5px; width:400px;" align="left">
<img src="/graphics/disk_multiple.png" align="absmiddle"> <strong style="color:#3399CC;">Storage Space</strong>
	<table cellspacing="0" width="100%">
    	<tr>
        	<td>Usage:</td>
            <td>
            	<div style="border:2px solid gray; width:200px; height:20px; ">
                	<cfloop from="1" to="#pQuot#" index="i">
                		<div style="width:2px; height:20px; background-color:#3399CC; border:none; float:left;">&nbsp;</div>
                	</cfloop>
                </div>
            </td>
            <td><cfif pQuot EQ 100><font color="red"><cfelse><font></cfif>
            	<cfoutput>#pQuot#% full</cfoutput></font>
            </td>
        </tr>
        <tr>
        	<td>Your Quota:</td>
            <td><cfoutput>#quota_size#</cfoutput>MB</td>
		</tr>
        <tr>
        	<td>Total Space Used:</td>
            <td><cfoutput>#Round(total_used)#</cfoutput>MB</td>
        </tr>
    </table>
</div>