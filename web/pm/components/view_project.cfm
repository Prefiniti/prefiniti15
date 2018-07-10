<!--
    <wwaftitle>View Project</wwaftitle>
    <wwafbreadcrumbs>Prefiniti,View Project</wwafbreadcrumbs>
-->
<cfset prefiniti = new Prefiniti.Base()>
<cfset project = new Prefiniti.ProjectManagement.Project(url.id)>
<cfset employee = prefiniti.getUserByAssociationID(project.employee_assoc)>
<cfset p_client = prefiniti.getUserByAssociationID(project.client_assoc)>
<cfset posts = project.getComments()>
<cfset tags = project.getTags()>
<cfset tasks = project.getTasks()>
<cfset tasksTotal = tasks.recordCount>

<cfset todoProjects = project.getTasksByCompletion(0)>
<cfset inProgressProjects = project.getTasksByCompletion(1)>
<cfset doneProjects = project.getTasksByCompletion(2)>

<cfset stakeholders = project.getStakeholders()>
<cfset locations = project.getLocations()>

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
                                            <button type="button" class="btn btn-white btn-sm dropdown-toggle" data-toggle="dropdown"><i class="fa fa-pencil-alt"></i> Project</button>
                                            <div class="dropdown-menu">
                                                <button class="dropdown-item" type="button">Edit</button>
                                                <cfif project.template_id NEQ 0>
                                                    <button class="dropdown-item" type="button" onclick="todo();">Update original template</button>
                                                </cfif>
                                                <button class="dropdown-item" type="button" onclick="todo();">Save as template</button>
                                                <div class="dropdown-divider"></div>
                                                <button class="dropdown-item" type="button" onclick="todo();"><span class="text-danger">Delete Project</span></button>
                                            </div>
                                        </div>
                                        
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-white btn-sm dropdown-toggle" data-toggle="dropdown"><i class="fa fa-plus"></i> Add</button>
                                            <div class="dropdown-menu">
                                                <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.addTask();">Task</button>
                                                <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.addDeliverable();">Deliverable</button>
                                                <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.addLocation();">Location</button>
                                                <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.addStakeholder();">Stakeholder</button>
                                                <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.addFiledDocument();">Filed Document</button>
                                            </div>
                                        </div>
                                        
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-white btn-sm dropdown-toggle" data-toggle="dropdown"><i class="fa fa-truck"></i> Dispatch</button>
                                            <div class="dropdown-menu">
                                                <button class="dropdown-item" type="button" onclick="todo();">Employee</button>                                            
                                            </div>
                                        </div>
                                        
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-white btn-sm dropdown-toggle" data-toggle="dropdown"><i class="fa fa-check"></i> Workflow</button>
                                            <div class="dropdown-menu">
                                                <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.setWorkflow('Active');">Active</button>
                                                <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.setWorkflow('Billed');">Billed</button>
                                                <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.setWorkflow('Paid');">Paid</button>
                                                <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.setWorkflow('Delinquent');">Delinquent</button>
                                                <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.setWorkflow('Closed');">Closed</button>                                        
                                            </div>
                                        </div>
                                        
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-white btn-sm dropdown-toggle" data-toggle="dropdown"><i class="fa fa-clipboard-list"></i> Log</button>
                                            <div class="dropdown-menu">
                                                <button class="dropdown-item" type="button" onclick="todo();">Time</button>
                                                <button class="dropdown-item" type="button" onclick="todo();">Travel</button>
                                            </div>  
                                        </div>                                      
                                    </div>
                                    
                                    <h2>#project.project_name#</h2>
                                </div>

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-6">
                                <dl class="row mb-0">
                                    <div class="col-sm-4 text-sm-right"><dt>Status:</dt> </div>
                                    <div class="col-sm-8 text-sm-left">
                                        <dd class="mb-1">
                                            #project.getStatus()#
                                            <cfif project.isOverdue()>
                                                <span class="label label-danger">Overdue</span>
                                            </cfif>
                                        </dd>
                                    </div>
                                </dl>
                                <dl class="row mb-0">
                                    <div class="col-sm-4 text-sm-right"><dt>Created by:</dt> </div>
                                    <div class="col-sm-8 text-sm-left"><dd class="mb-1">#employee.longName#</dd> </div>
                                </dl>
                                <dl class="row mb-0">
                                    <div class="col-sm-4 text-sm-right"><dt>Messages:</dt> </div>
                                    <div class="col-sm-8 text-sm-left"> <dd class="mb-1">  #posts.len()#</dd></div>
                                </dl>
                                <dl class="row mb-0">
                                    <div class="col-sm-4 text-sm-right"><dt>Client:</dt> </div>
                                    <div class="col-sm-8 text-sm-left"> <dd class="mb-1">#p_client.longName#</dd></div>
                                </dl>                                

                            </div>
                            <div class="col-lg-6" id="cluster_info">
                                <dl class="row mb-0">
                                    <div class="col-sm-4 text-sm-right">
                                        <dt>Created:</dt>
                                    </div>
                                    <div class="col-sm-8 text-sm-left">
                                        <dd class="mb-1">#prefiniti.getFriendlyDuration(project.project_created)#</dd>
                                    </div>
                                </dl>
                                <dl class="row mb-0">
                                    <div class="col-sm-4 text-sm-right">
                                        <dt>Start Date:</dt>
                                    </div>
                                    <div class="col-sm-8 text-sm-left">
                                        <dd class="mb-1">#dateFormat(project.project_start_date, "mmmm d, yyyy")#</dd>
                                    </div>
                                </dl>
                                <dl class="row mb-0">
                                    <div class="col-sm-4 text-sm-right">
                                        <dt>Stakeholders:</dt>
                                    </div>
                                    <div class="col-sm-8 text-sm-left">
                                        <dd class="project-people mb-1">
                                            <cfloop array="#stakeholders#" item="stakeholder">
                                                <a href="##" data-toggle="tooltip" data-placement="bottom" onclick="viewProfile(#stakeholder.user.id#);" title="#stakeholder.user.longName# (#stakeholder.type#)"><img alt="image" class="rounded-circle" src="#stakeholder.user.getPicture()#"></a>
                                            </cfloop>
                                        </dd>
                                    </div>
                                </dl>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <dl class="row mb-0">
                                    <div class="col-sm-2 text-sm-right">
                                        <dt>Completed:</dt>
                                    </div>
                                    <div class="col-sm-10 text-sm-left">
                                        <dd>
                                            <div class="progress m-b-1">
                                                <div style="width: #project.getPercentComplete()#%;" class="progress-bar progress-bar-striped progress-bar-animated"></div>
                                            </div>
                                            <small>Project is <strong>#project.getPercentComplete()#%</strong> complete. [#project.getCompleteTaskCount()# of #project.getTaskCount()# tasks complete]</small><br>
                                            <cfset dueIn = dateDiff("d", now(), project.project_due_date)>
                                            <cfif project.project_status NEQ "Closed">
                                                <cfif dueIn EQ 0>
                                                    <small class="text-warning">Project is due today.</small>
                                                </cfif>
                                                <cfif dueIn GT 0>
                                                    <small class="text-info">Project is due in #dueIn# days.</small>
                                                </cfif>
                                                <cfif dueIn LT 0>
                                                    <small class="text-danger">Project was due #abs(dueIn)# days ago.</small>
                                                </cfif>
                                            <cfelse>
                                                <small class="text-info">Project is closed.</small>
                                            </cfif>
                                        </dd>
                                    </div>
                                </dl>
                            </div>
                        </div>
                        <div class="row m-t-sm">
                            <div class="col-lg-12">
                                <div class="panel blank-panel">
                                    <div class="panel-heading">
                                        <div class="panel-options">
                                            <ul class="nav nav-tabs">
                                                <li><a class="nav-link active" href="##tab-tasks" data-toggle="tab"><i class="fa fa-list-alt"></i> Tasks</a></li>
                                                <li><a class="nav-link" href="##tab-comments" data-toggle="tab"><i class="fa fa-comments"></i> Comments</a></li>
                                                <li><a class="nav-link" href="##tab-dispatches" data-toggle="tab"><i class="fa fa-truck"></i> Dispatches</a></li>
                                                <li><a class="nav-link" href="##tab-time" data-toggle="tab"><i class="fa fa-clock"></i> Time Log</a></li>
                                                <li><a class="nav-link" href="##tab-travel" data-toggle="tab"><i class="fa fa-car"></i> Travel Log</a></li>
                                                <li><a class="nav-link" href="##tab-stakeholders" data-toggle="tab"><i class="fa fa-user"></i> Stakeholders</a></li>
                                                <li><a class="nav-link" href="##tab-locations" data-toggle="tab"><i class="fa fa-map-marker-alt"></i> Locations</a></li>
                                                <li><a class="nav-link" href="##tab-documents" data-toggle="tab"><i class="fa fa-file-alt"></i> Filed Documents</a></li>
                                            </ul>
                                        </div>
                                    </div>

                                    <div class="panel-body">

                                        <div class="tab-content">
                                            <div class="tab-pane active" id="tab-tasks">
                                                <div class="row">
                                                    <div class="col-sm-4">
                                                        <div class="ibox">
                                                            <div class="ibox-content">
                                                                <h3>To-Do</h3>

                                                                <ul class="sortable-list connectList agile-list" id="todo">
                                                                    <cfoutput query="todoProjects">
                                                                        <cfmodule template="/pm/components/agile_view_task.cfm" id="#id#" project_id="#url.id#">
                                                                    </cfoutput>
                                                                </ul>

                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="ibox">
                                                            <div class="ibox-content">
                                                                <h3>In Progress</h3>

                                                                <ul class="sortable-list connectList agile-list" id="in-progress">
                                                                    <cfoutput query="inProgressProjects">
                                                                        <cfmodule template="/pm/components/agile_view_task.cfm" id="#id#" project_id="#url.id#">
                                                                    </cfoutput>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="ibox">
                                                            <div class="ibox-content">
                                                                <h3>Done</h3>

                                                                <ul class="sortable-list connectList agile-list" id="done">
                                                                    <cfoutput query="doneProjects">
                                                                        <cfmodule template="/pm/components/agile_view_task.cfm" id="#id#" project_id="#url.id#">
                                                                    </cfoutput>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                                <!---
                                                <cfoutput query="tasks">

                                                    <cfset taskComments = project.getTaskComments(id)>

                                                    <div class="row">
                                                        <div class="col-lg-1">
                                                            <cfif task_complete EQ 0>
                                                                <span class="label label-danger">Incomplete</span>
                                                            <cfelse>
                                                                <span class="label label-success">Complete</span>
                                                            </cfif>
                                                        </div>
                                                        <div class="col-lg-8">
                                                            <h4>#task_name#</h4>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <div class="btn-group float-right">
                                                                <cfif task_complete EQ 0>
                                                                    <button class="btn btn-primary btn-sm" type="button" onclick="Prefiniti.Projects.setTaskComplete(#id#, 1);"><i class="fa fa-check"></i></button>
                                                                <cfelse>
                                                                    <button class="btn btn-primary btn-sm" type="button" onclick="Prefiniti.Projects.setTaskComplete(#id#, 0);"><i class="fa fa-undo"></i></button>
                                                                </cfif>
                                                                <button type="button" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cogs"></i></button>
                                                                <div class="dropdown-menu">   
                                                                    <button class="dropdown-item" type="button" onclick="Prefiniti.revealCommentBox('task-#id#');">Post Comment</button>
                                                                    <div class="dropdown-divider"></div>                            
                                                                    <button class="dropdown-item" type="button" onclick="todo();">Log Time</button>
                                                                    <button class="dropdown-item" type="button" onclick="todo();">Log Travel</button>
                                                                    <div class="dropdown-divider"></div>
                                                                    <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.deleteTask(#id#);">Delete Task</button>
                                                                </div>  
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row mb-3 mt-5">                                                        
                                                        <div class="col-lg-11 offset-lg-1">
                                                            <div style="display: none;" id="user-post-comment-task-#id#">
                                                                <cfmodule template="/socialnet/components/new_post_form.cfm" author_id="#session.user.id#" recipient_id="#id#" post_class="TASK" base_id="task-#id#">
                                                            </div>
                                                            <cfloop array="#taskComments#" item="post">
                                                                <cfmodule template="/socialnet/components/view_post.cfm" id="#post.id#">
                                                            </cfloop>
                                                        </div>
                                                    </div>
                                                </cfoutput>
                                                --->

                                            </div>

                                            <div class="tab-pane" id="tab-comments">
                                                <cfmodule template="/socialnet/components/new_post_form.cfm" author_id="#session.user.id#" recipient_id="#project.id#" post_class="PJCT" base_id="project-#project.id#">
                                                <cfloop array="#posts#" item="post">
                                                    <cfmodule template="/socialnet/components/view_post.cfm" id="#post.id#">
                                                </cfloop>
                                            </div>

                                            <div class="tab-pane" id="tab-dispatches">
                                            </div>

                                            <div class="tab-pane" id="tab-time">
                                            </div>

                                            <div class="tab-travel" id="tab-travel">
                                            </div>

                                            <div class="tab-pane" id="tab-stakeholders">
                                                <table class="table table-striped table-hover">
                                                    <tbody>
                                                        <cfloop array="#stakeholders#" item="stakeholder">
                                                            <tr>
                                                                <td class="client-avatar"><img alt="image" src="#stakeholder.user.getPicture()#"></td>
                                                                <td><a class="client-link" href="##" onclick="viewProfile(#stakeholder.user.id#)">#stakeholder.user.longName#</a></td>
                                                                <td class="client-status">
                                                                    <span class="label label-primary">#stakeholder.type#</span>
                                                                </td>
                                                                <td class="text-right">
                                                                    <button type="button" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cogs"></i></button>
                                                                    <div class="dropdown-menu">   
                                                                        <button class="dropdown-item" type="button" onclick="todo();">Send Message</button>
                                                                        <div class="dropdown-divider"></div>
                                                                        <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.deleteStakeholder(#stakeholder.id#);">Delete Stakeholder</button>
                                                                    </div>  
                                                                </td>
                                                            </tr>                                                            
                                                        </cfloop> 
                                                    </tbody>
                                                </table>                                           
                                            </div>

                                            <div class="tab-pane" id="tab-locations">
                                                <table class="table table-striped table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>Location</th>
                                                            <th>Address</th>
                                                            <th>City</th>
                                                            <th>State</th>
                                                            <th>ZIP</th>
                                                            <th>Subdivision</th>
                                                            <th>Lot</th>
                                                            <th>Block</th>
                                                            <th>PLSS</th>
                                                            <th>Geographic</th>
                                                            <th><i class="fa fa-cogs"></i></th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <cfoutput query="locations">
                                                            <tr>
                                                                <td>#location_name#</td>
                                                                <td>#address#</td>
                                                                <td>#city#</td>
                                                                <td>#state#</td>
                                                                <td>#zip#</td>
                                                                <td>#subdivision#</td>
                                                                <td>#lot#</td>
                                                                <td>#block#</td>
                                                                <td>
                                                                    <cfif trs_township NEQ "" AND trs_section NEQ "" AND trs_range NEQ "">
                                                                        T#trs_township#S#trs_section#R#trs_range#; #trs_meridian# Meridian
                                                                    <cfelse>
                                                                        Not Supplied
                                                                    </cfif>
                                                                </td>
                                                                <td>
                                                                    <cfif latitude NEQ "" AND longitude NEQ "">
                                                                        Lat: #latitude#, Lon: #longitude#
                                                                        <cfif elevation NEQ "">
                                                                        , Elev: #elevation#
                                                                        </cfif>
                                                                    <cfelse>
                                                                        Not Supplied
                                                                    </cfif>
                                                                </td>

                                                                <td>
                                                                    <button type="button" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cogs"></i></button>
                                                                    <div class="dropdown-menu">
                                                                        <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.deleteLocation(#id#);">Delete Location</button>
                                                                    </div>  
                                                                </td>
                                                            </tr>
                                                        </cfoutput>
                                                    </tbody>
                                                </table>
                                            </div>

                                            <div class="tab-pane" id="tab-documents">
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
                <h4>Project Description</h4>

                <p class="small">
                    #project.project_description#
                </p>
                <p class="small font-bold">
                    #project.getPriority()#
                </p>

                <h5 class="mt-5">Project Files</h5>
                <ul class="list-unstyled project-files">
                    <li><a href=""><i class="fa fa-file"></i> Project_document.docx</a></li>
                    <li><a href=""><i class="fa fa-file-picture-o"></i> Logo_zender_company.jpg</a></li>
                    <li><a href=""><i class="fa fa-stack-exchange"></i> Email_from_Alex.mln</a></li>
                    <li><a href=""><i class="fa fa-file"></i> Contract_20_11_2014.docx</a></li>
                </ul>
                <div class="text-center m-t-md">
                    <a href="##" class="btn btn-xs btn-primary">Add files</a>
                    <a href="##" class="btn btn-xs btn-primary">Report contact</a>
                </div>

                <h5>Project Tags</h5>
                <ul class="tag-list" style="padding: 0;">
                    <cfloop array="#tags#" item="tag">
                        <li><a href="##"><i class="fa fa-tag"></i> #tag#</a></li>
                    </cfloop>
                </ul>
            </div>
        </div>
    </div>
</cfoutput>
