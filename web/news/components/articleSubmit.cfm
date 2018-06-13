<cfquery name="as" datasource="webwarecl">
	INSERT INTO news_items (date, headline, body)
	VALUES		(#CreateODBCDateTime(url.date)#,
				'#url.headline#',
				'#url.body#')
</cfquery>

<cfquery name="gSMS" datasource="webwarecl">
	SELECT * FROM Users WHERE smsNumber != ""
</cfquery>

<cfoutput query="gSMS">
	<cfmail from="news@centerlineservices.biz" to="#smsNumber#" subject="#url.headline#">
		#url.body#
	</cfmail>
</cfoutput>

<table width="100%">
	<tr>
		<td align="center"><p class="VPLink">Article has been posted.</p></td>
	</tr>
</table>