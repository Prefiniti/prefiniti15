<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfparam name="c" default="">
<cfset c=#getComments(attributes.user_id)#>

<cfif attributes.user_id EQ attributes.calledByUser>
	<cfoutput>#setCommentsRead(attributes.user_id)#</cfoutput>
</cfif>    

<div style="padding-left:30px;">
<cfif c.RecordCount EQ 0>
	<strong>No comments.</strong>
<cfelse>    
	<cfoutput><strong>#getLongName(attributes.user_id)# has #c.RecordCount# comments.</strong><br /></cfoutput>
    <cfmodule template="/controls/record_scroller.cfm" attributecollection="#attributes#" record_count="#c.RecordCount#" records_per_page="#attributes.records_per_page#" scroller_id="cms" loadpage="/socialnet/components/read_comments.cfm"> 
	<cfoutput query="c" startrow="#attributes.start_row#" maxrows="#attributes.records_per_page#">
    <div style="margin:10px; padding:5px; background-color:##EFEFEF; -moz-border-radius:5px; width:400px;">
    <table cellspacing="0" width="400">
	
    	<tr>
        	<td rowspan="2"><a href="javascript:viewProfile(#c.from_id#);"><img src="#getPicture(c.from_id)#" height="50" border="0" /></a><br />#getOnline(c.from_id)#</td>
            <td valign="top">
            	<a href="javascript:viewProfile(#c.from_id#);"><strong>#getLongname(c.from_id)#</strong></a> - #DateFormat(c.sent_date, "mmmm dd, yyyy")# #TimeFormat(c.sent_date, "h:mm tt")#
		
            </td>
		</tr>
    	<tr>
    	  <td valign="bottom" style="border-bottom:1px solid ##EFEFEF;>            	<div style="width:300px; overflow:auto;">
                	
                    <p style="width:300px;"><strong>#c.body#</strong></p>
                </div>	</td>
  	  </tr>			                            
    
    </table>
    </div>
    </cfoutput>
</cfif>    
</div>

