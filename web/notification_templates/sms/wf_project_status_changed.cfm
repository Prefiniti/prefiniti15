<!---
oldStatus: orig_status, 
newStatus: form.stage, 
perpetrator: session.user
--->            
<cfoutput>#attributes.perpetrator.longName# has changed the status of project #attributes.project.project_name# from #attributes.oldStatus# to #attributes.newStatus#</cfoutput>