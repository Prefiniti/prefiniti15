<cfoutput><a href="##" onclick="Prefiniti.Social.loadProfile(#attributes.perpetrator.id#);">#attributes.perpetrator.longName#</a> has deleted task <strong>#attributes.task_name#</strong> from project <a href="##" onclick="Prefiniti.Projects.view(#attributes.project.id#);">#attributes.project.project_name#</a></cfoutput>