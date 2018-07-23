<cfif attributes.perpetrator.id EQ attributes.user.id>
    <cfif attributes.closed EQ 0>
        <cfoutput><a href="##" onclick="Prefiniti.Social.loadProfile(#attributes.user.id#);"><strong>#attributes.user.longName#</strong></a> has begun logging time on project <a href="##" onclick="Prefiniti.Projects.view(#attributes.project.id#)"><strong>#attributes.project.project_name#</strong></a>.</cfoutput>
    <cfelse>
        <cfoutput><a href="##" onclick="Prefiniti.Social.loadProfile(#attributes.user.id#);"><strong>#attributes.user.longName#</strong></a> has logged time on project <a href="##" onclick="Prefiniti.Projects.view(#attributes.project.id#)"><strong>#attributes.project.project_name#</strong></a>.</cfoutput>
    </cfif>
<cfelse>
    <cfif attributes.closed EQ 0>
        <cfoutput><a href="##" onclick="Prefiniti.Social.loadProfile(#attributes.perpetrator.id#);"><strong>#attributes.perpetrator.longName#</strong></a> has begun logging time for <a href="##" onclick="Prefiniti.Social.loadProfile(#attributes.user.id#)"><strong>#attributes.user.longName#</strong></a> on project <a href="##" onclick="Prefiniti.Projects.view(#attributes.project.id#)"><strong>#attributes.project.project_name#</strong></a>.</cfoutput>
    <cfelse>
        <cfoutput><a href="##" onclick="Prefiniti.Social.loadProfile(#attributes.perpetrator.id#);"><strong>#attributes.perpetrator.longName#</strong></a> has logged time for <a href="##" onclick="Prefiniti.Social.loadProfile(#attributes.user.id#)"><strong>#attributes.user.longName#</strong></a> on project <a href="##" onclick="Prefiniti.Projects.view(#attributes.project.id#)"><strong>#attributes.project.project_name#</strong></a>.</cfoutput>
    </cfif>
</cfif>
