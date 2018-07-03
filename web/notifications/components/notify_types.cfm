<cfset prefiniti = new Prefiniti.Base()>

<cfset ntypes = prefiniti.ntAllTypes()>

<table class="table table-striped table-bordered table-hover datatables" cellspacing="0">
	<thead>
		<tr>
	    	<th>Event</th>
	        <th>Prefiniti Mail</th>
	        <th>E-Mail</th>
	        <th>Text Message</th>
	    </tr>
	</thead>
	<tbody>
		<cfoutput query="ntypes">
	    	<tr>
	        	<td>#description#</td>
	            <cfmodule template="/notifications/components/notify_methods.cfm" user_id="#attributes.user_id#" event_id="#id#">
			</tr>
		</cfoutput>
	</tbody>
</table>