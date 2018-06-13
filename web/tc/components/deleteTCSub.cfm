<cfquery name="dtc" datasource="webwarecl">
	DELETE FROM time_card WHERE id='#url.id#'
</cfquery>

<table width="100%">
	<tr>
		<th>Timesheet Deleted</th>
	</tr>
	<tr>
		<td align="center"><p class="VPLink">Timesheet deleted</p></td>
	</tr>
</table>