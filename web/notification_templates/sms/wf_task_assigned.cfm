<!---
<cfset this.notifyStakeholders("WF_TASK_ASSIGNED", {perpetrator: session.user, task_id: this.task_id, assignee: this.getUserByAssociationID(arguments.assignee_assoc_id), task_name: this.getTaskByID(this.task_id).task_name})>

--->
<cfoutput>#attributes.perpetrator.longName# has assigned task #attributes.task_name# on project #attributes.project.project_name# to #attributes.assignee.longName#</cfoutput>