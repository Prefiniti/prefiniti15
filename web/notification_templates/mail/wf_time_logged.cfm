<cfif attributes.perpetrator.id EQ attributes.user.id>
    <cfif attributes.closed EQ 0>
        <cfoutput><strong>#attributes.user.longName#</strong> has begun logging time on project <strong>#attributes.project.project_name#</strong>.</cfoutput>
    <cfelse>
        <cfoutput><strong>#attributes.user.longName#</strong> has logged time on project <strong>#attributes.project.project_name#</strong>.</cfoutput>
    </cfif>
<cfelse>
    <cfif attributes.closed EQ 0>
        <cfoutput><strong>#attributes.perpetrator.longName#</strong> has begun logging time for <strong>#attributes.user.longName#</strong> on project <strong>#attributes.project.project_name#</strong>.</cfoutput>
    <cfelse>
        <cfoutput><strong>#attributes.perpetrator.longName#</strong> has logged time for <strong>#attributes.user.longName#</strong> on project <strong>#attributes.project.project_name#</strong>.</cfoutput>
    </cfif>
</cfif>
