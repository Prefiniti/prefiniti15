<cfquery name="smh" datasource="webwarecl">
	UPDATE Users SET masthead_closed=#url.value# WHERE id=#url.userid#
</cfquery>