<cfoutput><strong>#attributes.perpetrator.longName#</strong> has set changed the status of task <a href="##" onclick="Prefiniti.Projects.viewTask(#attributes.taskId#);"><strong>#attributes.taskName#</strong></a> on project <a href="##" onclick="Prefiniti.Projects.view(#attributes.project.id#);"><strong>#attributes.project.project_name#</strong></a> from <strong>#attributes.previousStatus#</strong> to <strong>#attributes.currentStatus#</strong></cfoutput>