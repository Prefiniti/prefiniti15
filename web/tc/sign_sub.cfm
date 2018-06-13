<cfquery name="sign" datasource="webwarecl">
	UPDATE time_card SET
		closed=1,
		initials='#url.initials#'
	WHERE id=#url.id#
</cfquery>

<cfoutput>
	<table width="100%">
		<tr>
			<td align="center">
				<h2>Timesheet Signed.</h2>
				<p class="VPLink"><a href="javascript:loadTimesheetView('tcTarget', #url.calledByUser#, '1/1/1980', '1/1/2999', 'Open', '#url.isTCAdmin#', '')">My Open Timesheets</a></p>
			</td>
		</tr>
	</table>
</cfoutput>