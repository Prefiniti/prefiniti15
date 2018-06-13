

<cfquery name="CreateTimesheet" datasource="webwarecl">
	INSERT INTO time_card 
		(emp_id,
		date,
		clsJobNumber,
		JobDescription,
		startTime,
		submitID,
        site_id)
	VALUES (#url.emp_id#,
			#CreateODBCDateTime(url.date)#,
			'#url.JobNumSel#',
			'#url.JobDescription#',
			#CreateODBCDateTime(url.startTime)#,
			'#url.submitID#',
            #url.current_site_id#)		
</cfquery>

<cfquery name="gTSid" datasource="webwarecl">
	SELECT id FROM time_card WHERE submitID='#url.submitID#'
</cfquery>

<cfoutput>
<table width="100%">
	<tr>
		<td align="center">
			<h1>Timesheet Created Successfully</h1>
			<p class="VPLink"><a href="javascript:openTS(#gTSid.id#, 'tcTarget');">Go to Timesheet View</a></p>
		</td>
	</tr>
</table>
</cfoutput>
