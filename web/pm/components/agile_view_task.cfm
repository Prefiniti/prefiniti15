<cfset project = new Prefiniti.ProjectManagement.Project(attributes.project_id)>
<cfset task = project.getTaskByID(attributes.id)>

<cfscript>
class = "";

switch(task.task_priority) {
	case "Wish List": class = "info-element"; break;
	case "Low": class = "info-element"; break;
	case "Medium": class = "success-element"; break;
	case "Normal": class = "success-element"; break;
	case "High": class = "warning-element"; break;
	case "Critical": class = "danger-element"; break; 
}

switch(task.task_complete) {
	case 0: completeness = "To-Do"; break;
	case 1: completeness = "In Progress"; break;
	case 2: completeness = "Done"; break;
}
</cfscript>

<cfoutput query="task">
    <cfif assignee_assoc_id NEQ 0>
	    <cfset assignee = project.getUserByAssociationID(assignee_assoc_id)>
        <cfset assigned = true>
    <cfelse>
        <cfset assigned = false>
    </cfif>
	<li class="#class#" id="agile-task-#id#">
        <a href="##" onclick="Prefiniti.Projects.viewTask(#id#);">#attributes.project_id#-#id#</a>
        #task_name#
        <div class="agile-detail pb-4">
            <cfif assigned>
                Assigned to <strong>#assignee.longName#</strong>.
            <cfelse>
                <span class="text-danger">Not yet assigned!</span>
            </cfif>
			<div class="btn-group float-right">
				<!---<cfswitch expression="#task_complete#"
                <cfif task_complete EQ 0>
                    <button class="btn btn-primary btn-sm" type="button" onclick="Prefiniti.Projects.setTaskComplete(#id#, 1);"><i class="fa fa-check"></i></button>
                <cfelse>
                    <button class="btn btn-primary btn-sm" type="button" onclick="Prefiniti.Projects.setTaskComplete(#id#, 0);"><i class="fa fa-undo"></i></button>
                </cfif>--->
                                                                                                                     
                <cfif project.checkPermission(session.user.id, "TASK_EDIT")>
                    <div class="btn-group">
                    	<button type="button" class="btn btn-white btn-xs dropdown-toggle" data-toggle="dropdown">#completeness#</button>
                    	<div class="dropdown-menu">
                    		<button class="dropdown-item" type="button" onclick="Prefiniti.Projects.setTaskComplete(#id#, 0);">To-Do</button>
                    		<button class="dropdown-item" type="button" onclick="Prefiniti.Projects.setTaskComplete(#id#, 1);">In Progress</button>
                    		<button class="dropdown-item" type="button" onclick="Prefiniti.Projects.setTaskComplete(#id#, 2);">Done</button>
                    	</div>
                    </div>

                    <div class="btn-group">
                    	<button type="button" class="btn btn-white btn-xs dropdown-toggle" data-toggle="dropdown">#task_priority#</button>
                    	<div class="dropdown-menu">
                    		<button class="dropdown-item" type="button" onclick="Prefiniti.Projects.setTaskPriority(#id#, 'Wish List');">Wish List</button>
                    		<button class="dropdown-item" type="button" onclick="Prefiniti.Projects.setTaskPriority(#id#, 'Low');">Low</button>
                    		<button class="dropdown-item" type="button" onclick="Prefiniti.Projects.setTaskPriority(#id#, 'Medium');">Medium</button>
                    		<button class="dropdown-item" type="button" onclick="Prefiniti.Projects.setTaskPriority(#id#, 'Normal');">Normal</button>
                    		<button class="dropdown-item" type="button" onclick="Prefiniti.Projects.setTaskPriority(#id#, 'High');">High</button>
                    		<button class="dropdown-item" type="button" onclick="Prefiniti.Projects.setTaskPriority(#id#, 'Critical');">Critical</button>
                    		
                    	</div>
                    </div>
                <cfelse>
                    <button type="button" class="btn btn-white btn-xs" disabled>#completeness#</button>
                    <button type="button" class="btn btn-white btn-xs" disabled>#task_priority#</button>                    
                </cfif>

                <div class="btn-group">
	                <button type="button" class="btn btn-white btn-xs dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cogs"></i></button>
	                <div class="dropdown-menu">
                        <cfif project.checkPermission(session.user.id, "TASK_EDIT")>
                            <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.assignTask(#id#);">Assign Task...</button>
                            <div class="dropdown-divider"></div>
                        </cfif>
                        <cfif project.checkPermission(session.user.id, "TIME_LOG")>                            
	                       <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.logTime(#id#);">Log Time...</button>
                        </cfif>
                        <cfif project.checkPermission(session.user.id, "TRAVEL_LOG")>
	                       <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.logTravel(#id#);">Log Travel...</button>
                        </cfif>
                        <cfif project.checkPermission(session.user.id, "TASK_DELETE")>
	                       <div class="dropdown-divider"></div>
	                       <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.deleteTask(#id#);">Delete Task</button>
                        </cfif>
	                </div>  
            	</div>
            </div>

        </div>
    </li>
</cfoutput>