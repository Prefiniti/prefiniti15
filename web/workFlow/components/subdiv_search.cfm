<cfquery name="qrySubs" datasource="webwarecl">
	SELECT * FROM subdivisions WHERE site_id=#url.current_site_id# AND name LIKE '%#url.name#%' AND approved=1 ORDER BY name
</cfquery>


<select name="subSelect" size="5" onchange="" id="subList">
	<cfoutput query="qrySubs">
		<option value="#id#">#name#</option>
	</cfoutput>
</select>