<cfif attributes.perpetrator.id EQ attributes.user.id>
    <cfif attributes.closed EQ 0>
        <cfoutput>#attributes.user.longName# has begun logging time on project #attributes.project.project_name#.</cfoutput>
    <cfelse>
        <cfoutput>#attributes.user.longName# has logged time on project #attributes.project.project_name#.</cfoutput>
    </cfif>
<cfelse>
    <cfif attributes.closed EQ 0>
        <cfoutput>#attributes.perpetrator.longName# has begun logging time for #attributes.user.longName# on project #attributes.project.project_name#.</cfoutput>
    <cfelse>
        <cfoutput>#attributes.perpetrator.longName# has logged time for #attributes.user.longName# on project #attributes.project.project_name#.</cfoutput>
    </cfif>
</cfif>
