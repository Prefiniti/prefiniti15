<cfquery name="pnUpdate" datasource="webwarecl">
	UPDATE projects
	SET		clsJobNumber='#url.clsJobNumber#'
	WHERE	id=#url.id#
</cfquery>