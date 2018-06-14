<cfquery name="cn" datasource="webwarecl">
	SELECT company FROM users WHERE id=#attributes.id#
</cfquery>

<cfmodule template="/jobViews/components/companyByCompanyID.cfm" id="#cn.company#">