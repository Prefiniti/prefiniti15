<!--
    <wwaftitle>View Task</wwaftitle>
    <wwafbreadcrumbs>Geodigraph PM, Projects, View Task</wwafbreadcrumbs>
-->

<cfset prefiniti = new Prefiniti.Base()>
<cfset project = new Prefiniti.ProjectManagement.Project(url.project_id)>
<cfset employee = prefiniti.getUserByAssociationID(project.employee_assoc)>
<cfset p_client = prefiniti.getUserByAssociationID(project.client_assoc)>

<cfset task = project.getTaskByID(url.id)>
<cfset assignee = prefiniti.getUserByAssociationID(task.assignee_assoc_id)>

<cfset id = url.id>

<cfscript>
    class = "";

    switch(task.task_priority) {
        case "Wish List": class = "label-info"; break;
        case "Low": class = "label-info"; break;
        case "Medium": class = "label-success"; break;
        case "Normal": class = "label-success"; break;
        case "High": class = "label-warning"; break;
        case "Critical": class = "label-danger"; break; 
    }

    switch(task.task_complete) {
        case 0: completeness = "To-Do"; break;
        case 1: completeness = "In Progress"; break;
        case 2: completeness = "Done"; break;
    }
</cfscript>

<cfoutput>
    <div class="row">
        <div class="col-lg-9">
            <div class="wrapper wrapper-content animated fadeInUp">
                <div class="ibox">
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="m-b-md">
                                    <div class="btn-group float-right">
                                   
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-white btn-sm" onclick="Prefiniti.Projects.view(#project.id#);"><i class="fa fa-arrow-left"></i> Project View</button>
                                        <button type="button" class="btn btn-white btn-sm dropdown-toggle" data-toggle="dropdown"><i class="fa fa-info-circle"></i> Status</button>
                                        <div class="dropdown-menu">
                                            <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.setTaskComplete(#id#, 0);">To-Do</button>
                                            <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.setTaskComplete(#id#, 1);">In Progress</button>
                                            <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.setTaskComplete(#id#, 2);">Done</button>
                                        </div>
                                    </div>

                                    <div class="btn-group">
                                        <button type="button" class="btn btn-white btn-sm dropdown-toggle" data-toggle="dropdown"><i class="fa fa-list"></i> Priority</button>
                                        <div class="dropdown-menu">
                                            <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.setTaskPriority(#id#, 'Wish List');">Wish List</button>
                                            <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.setTaskPriority(#id#, 'Low');">Low</button>
                                            <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.setTaskPriority(#id#, 'Medium');">Medium</button>
                                            <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.setTaskPriority(#id#, 'Normal');">Normal</button>
                                            <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.setTaskPriority(#id#, 'High');">High</button>
                                            <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.setTaskPriority(#id#, 'Critical');">Critical</button>
                                            
                                        </div>
                                    </div>

                                    <div class="btn-group">
                                        <button type="button" class="btn btn-white btn-sm dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cogs"></i></button>
                                        <div class="dropdown-menu">                              
                                            <button class="dropdown-item" type="button" onclick="todo();">Log Time...</button>
                                            <button class="dropdown-item" type="button" onclick="todo();">Log Travel...</button>
                                            <div class="dropdown-divider"></div>
                                            <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.deleteTask(#id#);">Delete Task</button>
                                        </div>  
                                    </div>
                                </div>
                                    
                                    <h2>#project.id#-#task.id#: #task.task_name#</h2> <span class="label label-info">#completeness#</span> <span class="label #class#">#task.task_priority#</span>
                                </div>

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-10">
                                <div class="row">
                                    <div class="col-lg-1">
                                        <img alt="image" class="rounded-circle avatar" onclick="Prefiniti.Social.loadProfile(#assignee.id#);" src="#assignee.getPicture()#"></a>
                                    </div>
                                    <div class="col-lg-11">
                                        <h3> Assigned to <a href="##" onclick="Prefiniti.Social.loadProfile(#assignee.id#);">#assignee.longName#</a></h3>
                                        <p class="font-bold text-muted">#assignee.status#</p>
                                    </div>
                                </div>                                                                                        
                            </div>
                           
                        </div>
                        
                        <div class="row m-t-sm">
                            <div class="col-lg-12">
                                <div class="panel blank-panel">
                                    <div class="panel-heading">
                                        <div class="panel-options">
                                            <ul class="nav nav-tabs">                                                
                                                <li><a class="nav-link active" href="##tab-comments" data-toggle="tab"><i class="fa fa-comments"></i> Comments</a></li>
                                                <li><a class="nav-link" href="##tab-dispatches" data-toggle="tab"><i class="fa fa-truck"></i> Dispatches</a></li>
                                                <li><a class="nav-link" href="##tab-time" data-toggle="tab"><i class="fa fa-clock"></i> Time Log</a></li>
                                                <li><a class="nav-link" href="##tab-travel" data-toggle="tab"><i class="fa fa-car"></i> Travel Log</a></li>                                                
                                            </ul>
                                        </div>
                                    </div>

                                    <div class="panel-body">

                                        <div class="tab-content">
                                            <div class="tab-pane active" id="tab-comments">
                                                <cfset taskComments = project.getTaskComments(id)>

                                                    
                                                <div class="row mb-3 mt-5">                                                        
                                                    <div class="col-lg-12">
                                                        <div id="user-post-comment-task-#id#">
                                                            <cfmodule template="/socialnet/components/new_post_form.cfm" author_id="#session.user.id#" recipient_id="#id#" post_class="TASK" base_id="task-#id#">
                                                        </div>
                                                        <cfloop array="#taskComments#" item="post">
                                                            <cfmodule template="/socialnet/components/view_post.cfm" id="#post.id#">
                                                        </cfloop>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="tab-pane" id="tab-dispatches">
                                            </div>

                                            <div class="tab-pane" id="tab-time">
                                            </div>

                                            <div class="tab-travel" id="tab-travel">
                                            </div>

                                            

                                        </div>

                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <div class="col-lg-3">
            <div class="wrapper wrapper-content project-manager">
                <h4>Task Description</h4>

                <p class="small">
                    #task.task_description#
                </p>
                
            </div>
        </div>
    </div>
</cfoutput>