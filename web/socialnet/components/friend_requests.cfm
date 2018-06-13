
<cfinclude template="/socialnet/socialnet_udf.cfm">
<h3 class="stdHeader">Friend Requests</h3>

<cfparam name="fReq" default="">
<cfset fReq=StructNew()>
<cfset fReq=getRequests(#url.calledByUser#)>

<cfoutput query="fReq">
	<div style="padding:5px; margin:10px; background-color:##EFEFEF; -moz-border-radius:5px; width:200px; float:left;">
    	<table width="100%" cellspacing="0">
        	<tr>
            	<td width="50" rowspan="2" style="background-color:##EFEFEF">
        			<img src="#getPicture(fReq.source_id)#" width="50" height="50" />  
                    #getOnline(fReq.source_id)#
				
                      		</td>
				<td align="right" valign="top">              
                    <strong><a href="javascript:viewProfile('#fReq.source_id#');">#getLongname(fReq.source_id)#</a></strong><br>
                    #DateDiff("yyyy", getBirthday(fReq.source_id), Now())# years old<br>
                    Request sent on #DateFormat(fReq.request_date, "mm/dd/yyyy")#
                    <br><span id="frBlock_#fReq.id#"><a href="javascript:acceptFriend(#fReq.id#)">Accept Friend</a> | <a href="javascript:rejectFriend(#fReq.id#)">Reject Friend</a></span>
                    				</td>
			</tr>
        	<tr>
        	  <td align="right" valign="bottom">
              <a href="javascript:mailTo(#id#, '#longName#');">Send Message</a></td>
      	  </tr>
		</table>                                            
	</div>

</cfoutput>