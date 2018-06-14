<cfquery name="smh" datasource="webwarecl">
	UPDATE users SET masthead_closed=#url.value# WHERE id=#url.userid#
</cfquery>