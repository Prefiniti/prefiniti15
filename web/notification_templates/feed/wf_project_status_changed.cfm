<!---
oldStatus: orig_status, 
newStatus: form.stage, 
perpetrator: session.user
--->            
<cfoutput>
    <a href="##" onclick="Prefiniti.Social.loadProfile(#attributes.perpetrator.id#);">#attributes.perpetrator.longName#</a> has changed the status of project <a href="##" onclick="Prefiniti.Projects.view(#attributes.project.id#)">#attributes.project.project_name#</a> from <strong>#attributes.oldStatus#</strong> to <strong>#attributes.newStatus#</strong>
</cfoutput>