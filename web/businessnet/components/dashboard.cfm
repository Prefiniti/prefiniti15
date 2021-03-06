<!--
    <wwaftitle>Dashboard</wwaftitle>
    <wwafbreadcrumbs>Geodigraph Hub,Dashboard</wwafbreadcrumbs>
-->

<cfset prefiniti = new Prefiniti.Base()>
<cfset projects = prefiniti.getProjectsByAssoc(session.current_association)>

<cfset projectCount = 0>
<cfset overdueProjects = 0>
<cfset onTimeProjects = 0>
<cfset delinquentProjects = 0>
<cfset nonDelinquentProjects = 0>
<cfset activeProjects = 0>
<cfset billedProjects = 0>
<cfset paidProjects = 0>
<cfset closedProjects = 0>

<cfquery name="getPriorityTasks" datasource="webwarecl">
    SELECT * FROM pm_tasks WHERE assignee_assoc_id=#session.current_association# AND task_complete!=2 ORDER BY task_priority
</cfquery>

<cfloop array="#projects#" item="projectEntry">

    <cfset project = projectEntry.project>

    <cfset projectCount = projectCount + 1>

    <cfif project.isOverdue()>
        <cfset overdueProjects = overdueProjects + 1>
    </cfif>

    <cfswitch expression="#project.project_status#">
        <cfcase value="Active">
            <cfset activeProjects = activeProjects + 1>
        </cfcase>
        <cfcase value="Billed">
            <cfset billedProjects = billedProjects + 1>
        </cfcase>
        <cfcase value="Paid">
            <cfset paidProjects = paidProjects + 1>
        </cfcase>
        <cfcase value="Delinquent">
            <cfset delinquentProjects = delinquentProjects + 1>
        </cfcase>
        <cfcase value="Closed">
            <cfset closedProjects = closedProjects + 1>
        </cfcase>
    </cfswitch>
</cfloop>

<cfset onTimeProjects = projectCount - overdueProjects>
<cfset nonDelinquentProjects = projectCount - delinquentProjects>


<div class="row  border-bottom white-bg dashboard-header">

    <div class="col-md-3">
        <h2>Welcome, <cfoutput>#session.user.firstName#</cfoutput>!</h2>
        <small>You have <cfoutput>#session.user.getUnreadMessageCount()#</cfoutput> unread messages.</small>
        
        
            <ul class="list-group clear-list m-t">
                <cfoutput query="getPriorityTasks" maxrows="5">
                    <li class="list-group-item fist-item">
                        <span class="float-right">
                            <cfif task_complete EQ 0>
                                To-Do
                            <cfelse>
                                In Progress
                            </cfif>
                        </span>
                        <span class="label label-success">#task_priority#</span> <a href="##" onclick="Prefiniti.Dashboard.viewTask(#project_id#, #id#);">#task_name#</a>
                    </li>
                </cfoutput>                
            </ul>
        
    </div>
    <div class="col-md-6">
        <cfif prefiniti.getPermissionByKey("WF_VIEWSTATS", session.current_association)>
            <cfoutput>
                <div class="flot-chart dashboard-chart">
                    <div class="flot-chart-content" id="flot-dashboard-chart"></div>
                </div>
                <div class="row">
                    <div class="col-md-6 text-left pl-4">
                        <small class="text-muted">#session.site.SiteName# Task Changes (Current Week)</small>
                    </div>
                    <div class="col-md-6 text-right pr-4">
                        <small class="text-muted">Legend: <span style="color: red;">To-Do</span>/<span style="color: blue;">Done</span></small>
                    </div>
                </div>
                <div class="row text-left">
                    <div class="col">
                        <div class=" m-l-md">
                            <span class="h5 font-bold m-t block">#activeProjects#</span>
                            <small class="text-muted m-b block">Active projects</small>
                        </div>
                    </div>
                    <div class="col">
                        <span class="h5 font-bold m-t block">#billedProjects#</span>
                        <small class="text-muted m-b block">Billed projects</small>
                    </div>
                    <div class="col">
                        <span class="h5 font-bold m-t block">#paidProjects#</span>
                        <small class="text-muted m-b block">Paid projects</small>
                    </div>
                    <div class="col">
                        <span class="h5 font-bold m-t block">#overdueProjects#</span>
                        <small class="text-muted m-b block">Overdue projects</small>
                    </div>
                    <div class="col">
                        <span class="h5 font-bold m-t block">#delinquentProjects#</span>
                        <small class="text-muted m-b block">Delinquent projects</small>
                    </div>

                </div>
            </cfoutput>
        </cfif>
    </div>
    <div class="col-md-3">
        <cfif prefiniti.getPermissionByKey("WF_VIEWSTATS", session.current_association)>
            <div class="statistic-box">
                <h4>
                    Project Statistics
                </h4>
                <p>
                    This data represents the overall status of your projects.
                </p>
                <div class="row text-center">
                    <div class="col-lg-6">
                        <cfoutput>
                            <canvas id="overdue-projects" data-labels="On-Time,Overdue" data-colors="##9cc3da,##dbb1cd" data-data="#onTimeProjects#,#overdueProjects#" width="80" height="80" style="margin: 18px auto 0"></canvas>
                        </cfoutput>
                        <h5 >Overdue Projects</h5>
                    </div>
                    <div class="col-lg-6">
                        <cfoutput>
                        <canvas id="delinquent-projects" data-labels="Total Projects,Delinquent Projects" data-colors="##9cc3da,##dbb1cd" data-data="#nonDelinquentProjects#,#delinquentProjects#"  width="80" height="80" style="margin: 18px auto 0"></canvas>
                        </cfoutput>
                        <h5 >Delinquent Projects</h5>
                    </div>
                </div>
                <div class="m-t">
                    <small>Note that this data is subject to change. Please click the <i class="fa fa-redo"></i> button above to refresh.</small>
                </div>

            </div>
        </cfif>
    </div>

</div>
<div class="row">
    <div class="col-lg-12">
        <div class="wrapper wrapper-content">
            <div class="row">
                <div class="col-lg-4">
                    <div class="ibox">
                        <div class="ibox-title">
                            <h5>Friends Online</h5>
                            <div class="ibox-tools">
                                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                    <i class="fa fa-wrench"></i>
                                </a>
                                <ul class="dropdown-menu dropdown-user">
                                    <li><a href="#" class="dropdown-item" onclick="Prefiniti.Social.friendSearch();">Friend Search...</a>
                                    </li>                                   
                                </ul>                                
                            </div>
                        </div>
                        <div class="ibox-content no-padding">
                            <cfmodule template="/socialnet/components/view_online_friends.cfm">
                        </div>
                    </div>
                    <div class="ibox ">
                        <div class="ibox-title">
                            <h5>WebGrams</h5>
                            <div class="ibox-tools">
                                <span class="label label-warning-light float-right"><i class="fa fa-bullhorn"></i></span>
                            </div>
                        </div>
                        <div class="ibox-content">
                            <cfmodule template="/socialnet/components/view_webgrams.cfm" maxrows="10">
                        </div>
                    </div>
                    <!---
                    <div class="ibox ">
                        <div class="ibox-title">
                            <h5>News Feed</h5>                            
                        </div>
                        <div class="ibox-content">
                            <cfmodule template="/socialnet/components/view_newsfeed.cfm" count="10">
                        </div>
                    </div>
                    --->                    
                </div>
                
                <div class="col-lg-8">                    
                    <div class="ibox">
                        <div class="ibox-title">
                            <h5>My Projects</h5>
                            <div class="ibox-tools">
                                <cfif prefiniti.getPermissionByKey("WF_CREATE", session.current_association)>
                                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                        <i class="fa fa-wrench"></i>
                                    </a>
                                    <ul class="dropdown-menu dropdown-user">
                                        <li><a href="#" class="dropdown-item" onclick="Prefiniti.Projects.create();">New Project...</a>
                                        </li>
                                        
                                    </ul>
                                </cfif>
                            </div>
                        </div>
                        <div class="ibox-content">
                            <cfoutput>
                                <cfmodule template="/pm/components/user_project_overview.cfm" role_id="#session.current_association#">
                            </cfoutput>
                        </div>
                    </div>
                    <div class="ibox">
                        <div class="ibox-title">
                            <h5>Resolutions</h5>
                            <div class="ibox-tools">
                                <cfif prefiniti.getPermissionByKey("RES_CREATE", session.current_association)>
                                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                        <i class="fa fa-wrench"></i>
                                    </a>
                                    <ul class="dropdown-menu dropdown-user">
                                        <li><a href="#" class="dropdown-item" onclick="Prefiniti.Resolutions.create();">New Resolution...</a>
                                        </li>                                        
                                    </ul>
                                </cfif>
                            </div>
                        </div>
                        <div class="ibox-content">
                            <cfoutput>
                                <cfmodule template="/resolutions/components/resolutions_overview.cfm" role_id="#session.current_association#">
                            </cfoutput>
                        </div>
                    </div>
                </div>

            </div>
        </div>

    </div>
</div>

