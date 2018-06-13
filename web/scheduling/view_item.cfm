<cfinclude template="/scheduling/scheduling_udf.cfm">
<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfparam name="si" default="">
<cfset si=scItem(url.item_id)>

<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid #EFEFEF; background-color:white; clear:both;">
	<div style="float:left">
    	<h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> <cfoutput>#si.event_title#</cfoutput></h3>
    </div>
</div>

<cfoutput query="si">
	<cfif url.calledByUser EQ user_id>
    	<div style="clear:both;">
    	<img src="/graphics/date_edit.png" align="absmiddle" style="clear:both;"/> <a href="javascript:scEditEvent(#id#);">Edit Event</a>
        </div>
    </cfif>
    <table width="100%" cellspacing="0" cellpadding="10" style="clear:both;">
    	<tr>
        	<td style="color:##3399CC; font-weight:bold; clear:both;" colspan="2">Scheduled by #getLongname(scheduler_id)# on #DateFormat(scheduled_on, "mm/dd/yyyy")# at #TimeFormat(scheduled_on, "h:mm tt")#</td>
		</tr>            
        <tr>
        	<td valign="top"><strong>Description:</strong></td>
            <td valign="top">#event_description#</td>
		</tr>
        <tr>
        	<td valign="top"><strong>Date &amp; Time:</strong></td>
            <td valign="top">#DateFormat(date, "dddd mmmm d, yyyy")# #scTimeByBlock(start_block)#-#scTimeByBlock(end_block+1)#</td>
		</tr>
        <tr>
        	<td valign="top"><strong>Location:</strong></td>
            <td valign="top">#address#<br>#city#, #state# #zip#</td>
		</tr>                                               
    </table>
</cfoutput>