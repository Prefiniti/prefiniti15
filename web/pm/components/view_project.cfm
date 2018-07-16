<!--
    <wwaftitle>View Project</wwaftitle>
    <wwafbreadcrumbs>Geodigraph PM,View Project</wwafbreadcrumbs>
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
<cfset deliverables = project.getDeliverables()>

<cfset effectivePermissions = project.getEffectivePermissions(session.user.id)>
<cfset permArray = project.getAllPermissionKeys(session.user.id)>

<cfif project.template_id NEQ 0>
    <cfset projectTemplate = new Prefiniti.ProjectManagement.Template()>   
    <cfset projectTemplate.open(project.template_id)>
    <cfset templateName = projectTemplate.template_name>
<cfelse>
    <cfset templateName = "Blank Project">
</cfif>

<cfif project.client_assoc EQ project.employee_assoc>
    <cfset internalProject = true>
<cfelse>
    <cfset internalProject = false>
</cfif>

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
                                                <cfif project.checkPermission(session.user.id, "PRJ_EDIT")>
                                                    <button class="dropdown-item" type="button" onclick="todo();">Edit Project...</button>                                                                                                   
                                                    <cfif project.template_id NEQ 0>
                                                        <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.updateTemplate();">Update original template</button>
                                                    </cfif>
                                                    <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.saveAsNewTemplate();">Save as new template...</button>
                                                    <div class="dropdown-divider"></div>
                                                </cfif>
                                                <cfif project.checkPermission(session.user.id, "PRJ_DELETE")>
                                                    <button class="dropdown-item" type="button" onclick="todo();"><span class="text-danger">Delete Project</span></button>
                                                </cfif>
                                            </div>
                                        </div>
                                        
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-white btn-sm dropdown-toggle" data-toggle="dropdown"><i class="fa fa-plus"></i> Add</button>
                                            <div class="dropdown-menu">
                                                <cfif project.checkPermission(session.user.id, "TASK_ADD")>
                                                    <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.addTask();">Task...</button>
                                                </cfif>
                                                <cfif project.checkPermission(session.user.id, "DEL_ADD")>
                                                    <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.addDeliverable();">Deliverable...</button>
                                                </cfif>
                                                <cfif project.checkPermission(session.user.id, "LOC_ADD")>
                                                    <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.addLocation();">Location...</button>
                                                </cfif>
                                                <cfif project.checkPermission(session.user.id, "SH_ADD")>
                                                    <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.addStakeholder();">Stakeholder...</button>
                                                </cfif>
                                                <cfif project.checkPermission(session.user.id, "DOC_ADD")>
                                                    <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.addFiledDocument();">Filed Document...</button>
                                                </cfif>
                                            </div>
                                        </div>
                                        
                                        <cfif project.checkPermission(session.user.id, "DISP_ADD")>
                                            <div class="btn-group">
                                                <button type="button" class="btn btn-white btn-sm dropdown-toggle" data-toggle="dropdown"><i class="fa fa-truck"></i> Dispatch</button>
                                                <div class="dropdown-menu">
                                                    <button class="dropdown-item" type="button" onclick="todo();">Employee...</button>                                            
                                                </div>
                                            </div>
                                        </cfif>
                                        
                                        <div class="btn-group">
                                            <cfif project.checkPermission(session.user.id, "PRJ_EDIT")>
                                                <button type="button" class="btn btn-white btn-sm dropdown-toggle" data-toggle="dropdown"><i class="fa fa-check"></i> Workflow</button>
                                                <div class="dropdown-menu">
                                                    <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.setWorkflow('Active');">Active</button>
                                                    <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.setWorkflow('Billed');">Billed</button>
                                                    <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.setWorkflow('Paid');">Paid</button>
                                                    <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.setWorkflow('Delinquent');">Delinquent</button>
                                                    <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.setWorkflow('Closed');">Closed</button>                                        
                                                </div>
                                            </cfif>
                                        </div>
                                        
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-white btn-sm dropdown-toggle" data-toggle="dropdown"><i class="fa fa-clipboard-list"></i> Log</button>
                                            <div class="dropdown-menu">
                                                <cfif project.checkPermission(session.user.id, "TIME_LOG")>
                                                    <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.logTime(0);">Time...</button>
                                                </cfif>
                                                <cfif project.checkPermission(session.user.id, "TRAVEL_LOG")>
                                                    <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.logTravel(0);">Travel...</button>
                                                </cfif>
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

                                            <cfif internalProject>
                                                <span class="label label-info">Internal</span>
                                            </cfif>
                                        </dd>
                                    </div>
                                </dl>
                                <dl class="row mb-0">
                                    <div class="col-sm-4 text-sm-right"><dt>Created by:</dt> </div>
                                    <div class="col-sm-8 text-sm-left"><dd class="mb-1">#employee.longName# from template <em>#templateName#</em></dd></div>
                                </dl>
                                <dl class="row mb-0">
                                    <div class="col-sm-4 text-sm-right"><dt>Messages:</dt> </div>
                                    <div class="col-sm-8 text-sm-left"> <dd class="mb-1">  #posts.len()#</dd></div>
                                </dl>
                                <cfif NOT internalProject>
                                    <dl class="row mb-0">
                                        <div class="col-sm-4 text-sm-right"><dt>Client:</dt> </div>
                                        <div class="col-sm-8 text-sm-left"> <dd class="mb-1">#p_client.longName#</dd></div>
                                    </dl>                     
                                </cfif>           

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
                                                <a href="##" data-toggle="tooltip" data-placement="bottom" onclick="Prefiniti.Social.loadProfile(#stakeholder.user.id#);" title="#stakeholder.user.longName# (#stakeholder.type#)"><img alt="image" class="rounded-circle" src="#stakeholder.user.getPicture()#"></a>
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
                                            <small>Project is <strong>#project.getPercentComplete()#%</strong> complete. [#project.getCompleteTaskCount()# of #project.getRequiredTaskCount()# required tasks complete]</small><br>
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

                                            </div>

                                            <div class="tab-pane" id="tab-comments">
                                                <cfif project.checkPermission(session.user.id, "PRJ_VIEW")>
                                                    <cfmodule template="/socialnet/components/new_post_form.cfm" author_id="#session.user.id#" recipient_id="#project.id#" post_class="PJCT" base_id="project-#project.id#">
                                                </cfif>
                                                <cfloop array="#posts#" item="post">
                                                    <cfmodule template="/socialnet/components/view_post.cfm" id="#post.id#">
                                                </cfloop>
                                            </div>

                                            <div class="tab-pane" id="tab-dispatches">
                                            </div>

                                            <div class="tab-pane" id="tab-time">
                                                <cfmodule template="/pm/components/view_time_entries.cfm" project_id="#project.id#">
                                            </div>

                                            <div class="tab-pane" id="tab-travel">
                                                <cfmodule template="/pm/components/view_travel_entries.cfm" project_id="#project.id#">
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

                                                                        <cfif project.checkPermission(session.user.id, "SH_DELETE")>
                                                                            <div class="dropdown-divider"></div>
                                                                            <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.deleteStakeholder(#stakeholder.id#);">Delete Stakeholder</button>
                                                                        </cfif>
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
                                                                    <cfif project.checkPermission(session.user.id, "LOC_DELETE")>
                                                                        <button type="button" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cogs"></i></button>
                                                                        <div class="dropdown-menu">
                                                                            <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.deleteLocation(#id#);">Delete Location</button>
                                                                        </div>  
                                                                    </cfif>
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

                <h5 class="mt-5">Deliverables</h5>
                <p class="text-small">These are files to be delivered to stakeholders.</p>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Deliverable</th>                            
                            <th><i class="fa fa-cogs"></i></th>
                        </tr>
                    </thead>
                    <tbody>
                        <cfoutput query="deliverables">
                            <cfif deliverable_file_id EQ 0>
                                <cfset needsUploading = true>
                            <cfelse>
                                <cfset needsUploading = false>
                            </cfif>

                            <tr>
                                <td>
                                    <cfif needsUploading>
                                        <span class="text-danger">#deliverable_name#</span>
                                    <cfelse>
                                        <a href="#prefiniti.cmsUserFileURL(deliverable_file_id)#" target="_blank">#deliverable_name#</a>
                                    </cfif>
                                </td>                                
                                <td align="right">
                                    <div class="btn-group">
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cogs"></i></button>
                                            <div class="dropdown-menu">
                                                <cfif needsUploading>
                                                    <cfif project.checkPermission(session.user.id, "DEL_EDIT")>
                                                        <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.chooseDeliverable(#id#, 'Fulfill Deliverable');">Fulfill Deliverable...</button>
                                                    </cfif>
                                                <cfelse>
                                                    <cfif project.checkPermission(session.user.id, "DEL_EDIT")>
                                                        <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.chooseDeliverable(#id#, 'Replace Deliverable');">Replace Deliverable...</button>
                                                        <!---<button class="dropdown-item" type="button" onclick="Prefiniti.Projects.notifyDeliverable(#id#);">Finalize &amp; Send...</button>--->
                                                    </cfif>
                                                </cfif>
                                                <cfif project.checkPermission(session.user.id, "DEL_DELETE")>
                                                    <div class="dropdown-divider"></div>
                                                    <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.deleteDeliverable(#id#);">Delete Deliverable</button>
                                                </cfif>
                                            </div> 
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </cfoutput>
                    </tbody>
                </table>
                <cfif project.checkPermission(session.user.id, "DEL_ADD")>
                    <div class="text-center m-t-md">
                        <a href="##" class="btn btn-xs btn-primary" onclick="Prefiniti.Projects.addDeliverable();">Add Deliverable</a>                    
                    </div>
                </cfif>
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
