<!---
oldStatus: orig_status, 
newStatus: form.stage, 
perpetrator: session.user
--->            
<cfoutput>
    <strong>#attributes.perpetrator.longName#</strong> has changed the status of project <strong>#attributes.project.project_name#</strong> from <strong>#attributes.oldStatus#</strong> to <strong>#attributes.newStatus#</strong>
</cfoutput>