<cfif #url.allowSearch# EQ "true">
<cfquery name="updatePrivacy" datasource="webwarecl">
	UPDATE Users SET allowSearch=1 WHERE id=#url.user_id#
</cfquery>
<cfelse>
<cfquery name="updatePrivacy" datasource="webwarecl">
	UPDATE Users SET allowSearch=0 WHERE id=#url.user_id#
</cfquery> 
</cfif>
Profile updated.