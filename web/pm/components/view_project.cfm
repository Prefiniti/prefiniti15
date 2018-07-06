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
<cfset stakeholders = project.getStakeholders()>


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
                                                    <button class="dropdown-item" type="button">Update original template</button>
                                                </cfif>
                                                <button class="dropdown-item" type="button">Save as template</button>
                                                <div class="dropdown-divider"></div>
                                                <button class="dropdown-item" type="button"><span class="text-danger">Delete Project</span></button>
                                            </div>
                                        </div>
                                        
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-white btn-sm dropdown-toggle" data-toggle="dropdown"><i class="fa fa-plus"></i> Add</button>
                                            <div class="dropdown-menu">
                                                <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.addTask();">Task</button>
                                                <button class="dropdown-item" type="button">Deliverable</button>
                                                <button class="dropdown-item" type="button">Location</button>
                                                <button class="dropdown-item" type="button">Stakeholder</button>
                                                <button class="dropdown-item" type="button">Filed Document</button>
                                            </div>
                                        </div>
                                        
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-white btn-sm dropdown-toggle" data-toggle="dropdown"><i class="fa fa-truck"></i> Dispatch</button>
                                            <div class="dropdown-menu">
                                                <button class="dropdown-item" type="button">Employee</button>                                            
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
                                                <button class="dropdown-item" type="button">Time</button>
                                                <button class="dropdown-item" type="button">Travel</button>
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
                                    <div class="col-sm-8 text-sm-left"><dd class="mb-1">#project.getStatus()#</dd></div>
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
                                        <dt>Stakeholders:</dt>
                                    </div>
                                    <div class="col-sm-8 text-sm-left">
                                        <dd class="project-people mb-1">
                                            <cfloop array="#stakeholders#" item="stakeholder">
                                                <a href="##" data-toggle="tooltip" data-placement="bottom" title="#stakeholder.user.longName# (#stakeholder.type#)"><img alt="image" class="rounded-circle" src="#stakeholder.user.getPicture()#"></a>
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
                                            <small>Project is <strong>#project.getPercentComplete()#%</strong> complete. [#project.getCompleteTaskCount()# of #project.getTaskCount()# tasks complete]</small>
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
                                                <li><a class="nav-link active" href="##tab-tasks" data-toggle="tab">Tasks</a></li>
                                                <li><a class="nav-link" href="##tab-comments" data-toggle="tab">Comments</a></li>
                                                <li><a class="nav-link" href="##tab-activities" data-toggle="tab">Activities</a></li>
                                                <li><a class="nav-link" href="##tab-stakeholders" data-toggle="tab">Stakeholders</a></li>
                                                <li><a class="nav-link" href="##tab-locations" data-toggle="tab">Locations</a></li>
                                                <li><a class="nav-link" href="##tab-documents" data-toggle="tab">Filed Documents</a></li>
                                            </ul>
                                        </div>
                                    </div>

                                    <div class="panel-body">

                                        <div class="tab-content">
                                            <div class="tab-pane active" id="tab-tasks">
                                                
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
                                                                    <button class="dropdown-item" type="button">Log Time</button>
                                                                    <button class="dropdown-item" type="button">Log Travel</button>
                                                                    <div class="dropdown-divider"></div>
                                                                    <button class="dropdown-item" type="button">Delete Task</button>
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

                                            </div>

                                            <div class="tab-pane" id="tab-comments">
                                                <cfmodule template="/socialnet/components/new_post_form.cfm" author_id="#session.user.id#" recipient_id="#project.id#" post_class="PJCT" base_id="project-#project.id#">
                                                <cfloop array="#posts#" item="post">
                                                    <cfmodule template="/socialnet/components/view_post.cfm" id="#post.id#">
                                                </cfloop>
                                            </div>

                                            <div class="tab-pane" id="tab-activities">

                                                <table class="table table-striped">
                                                    <thead>
                                                        <tr>
                                                            <th>Status</th>
                                                            <th>Title</th>
                                                            <th>Start Time</th>
                                                            <th>End Time</th>
                                                            <th>Comments</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td>
                                                                <span class="label label-primary"><i class="fa fa-check"></i> Completed</span>
                                                            </td>
                                                            <td>
                                                               Create project in webapp
                                                           </td>
                                                           <td>
                                                               12.07.2014 10:10:1
                                                           </td>
                                                           <td>
                                                            14.07.2014 10:16:36
                                                        </td>
                                                        <td>
                                                            <p class="small">
                                                                Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable.
                                                            </p>
                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <span class="label label-primary"><i class="fa fa-check"></i> Accepted</span>
                                                        </td>
                                                        <td>
                                                            Various versions
                                                        </td>
                                                        <td>
                                                            12.07.2014 10:10:1
                                                        </td>
                                                        <td>
                                                            14.07.2014 10:16:36
                                                        </td>
                                                        <td>
                                                            <p class="small">
                                                                Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).
                                                            </p>
                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <span class="label label-primary"><i class="fa fa-check"></i> Sent</span>
                                                        </td>
                                                        <td>
                                                            There are many variations
                                                        </td>
                                                        <td>
                                                            12.07.2014 10:10:1
                                                        </td>
                                                        <td>
                                                            14.07.2014 10:16:36
                                                        </td>
                                                        <td>
                                                            <p class="small">
                                                                There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which
                                                            </p>
                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <span class="label label-primary"><i class="fa fa-check"></i> Reported</span>
                                                        </td>
                                                        <td>
                                                            Latin words
                                                        </td>
                                                        <td>
                                                            12.07.2014 10:10:1
                                                        </td>
                                                        <td>
                                                            14.07.2014 10:16:36
                                                        </td>
                                                        <td>
                                                            <p class="small">
                                                                Latin words, combined with a handful of model sentence structures
                                                            </p>
                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <span class="label label-primary"><i class="fa fa-check"></i> Accepted</span>
                                                        </td>
                                                        <td>
                                                            The generated Lorem
                                                        </td>
                                                        <td>
                                                            12.07.2014 10:10:1
                                                        </td>
                                                        <td>
                                                            14.07.2014 10:16:36
                                                        </td>
                                                        <td>
                                                            <p class="small">
                                                                The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.
                                                            </p>
                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <span class="label label-primary"><i class="fa fa-check"></i> Sent</span>
                                                        </td>
                                                        <td>
                                                            The first line
                                                        </td>
                                                        <td>
                                                            12.07.2014 10:10:1
                                                        </td>
                                                        <td>
                                                            14.07.2014 10:16:36
                                                        </td>
                                                        <td>
                                                            <p class="small">
                                                                The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.
                                                            </p>
                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <span class="label label-primary"><i class="fa fa-check"></i> Reported</span>
                                                        </td>
                                                        <td>
                                                            The standard chunk
                                                        </td>
                                                        <td>
                                                            12.07.2014 10:10:1
                                                        </td>
                                                        <td>
                                                            14.07.2014 10:16:36
                                                        </td>
                                                        <td>
                                                            <p class="small">
                                                                The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested.
                                                            </p>
                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <span class="label label-primary"><i class="fa fa-check"></i> Completed</span>
                                                        </td>
                                                        <td>
                                                            Lorem Ipsum is that
                                                        </td>
                                                        <td>
                                                            12.07.2014 10:10:1
                                                        </td>
                                                        <td>
                                                            14.07.2014 10:16:36
                                                        </td>
                                                        <td>
                                                            <p class="small">
                                                                Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable.
                                                            </p>
                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <span class="label label-primary"><i class="fa fa-check"></i> Sent</span>
                                                        </td>
                                                        <td>
                                                            Contrary to popular
                                                        </td>
                                                        <td>
                                                            12.07.2014 10:10:1
                                                        </td>
                                                        <td>
                                                            14.07.2014 10:16:36
                                                        </td>
                                                        <td>
                                                            <p class="small">
                                                                Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical
                                                            </p>
                                                        </td>

                                                    </tr>

                                                </tbody>
                                            </table>

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
                                                        </tr>                                                            
                                                    </cfloop> 
                                                </tbody>
                                            </table>                                           
                                        </div>

                                        <div class="tab-pane" id="tab-locations">
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
            <h5>Project Tags</h5>
            <ul class="tag-list" style="padding: 0;">
                <cfloop array="#tags#" item="tag">
                <li><a href="##"><i class="fa fa-tag"></i> #tag#</a></li>
                </cfloop>
            </ul>
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
        </div>
    </div>
</div>
</cfoutput>
