<div class="wwaf-metadata">
    <wwaftitle>All Projects</wwaftitle>
    <wwafbreadcrumbs>Geodigraph PM,All Projects</wwafbreadcrumbs>
</div>

<cfset projects = session.site.projects()>

<div class="wrapper wrapper-content animated fadeInUp">
    <div class="ibox">
        <div class="ibox-title">
            <h5>All Projects</h5>
            <div class="ibox-tools">
                <a href="#" class="btn btn-primary btn-xs" onclick="Prefiniti.Projects.create();">Create Project</a>
            </div>
        </div>
        <div class="ibox-content">
            <div class="row m-b-sm m-t-sm">
                <div class="col-md-1">
                    <button type="button" id="loading-example-btn" class="btn btn-white btn-sm" onclick="Prefiniti.Projects.viewAll();"><i class="fa fa-redo"></i> Refresh</button>
                </div>
                <div class="col-md-11">
                    <div class="input-group">
                        <input type="text" placeholder="Search" class="form-control-sm form-control" id="search-projects" onkeyup="Prefiniti.Projects.search();">
                        <div class="input-group-append">
                            <button type="button" class="btn btn-sm btn-primary">Search</button> 
                        </div>
                    </div>
                </div>
            </div>
            <div class="row m-b-sm m-t-sm">
                <div class="col-md-1">
                </div>
                <div class="col-md-11">
                    <div class="btn-group-toggle" data-toggle="buttons">
                        <label class="btn btn-xs btn-primary btn-outline mr-3" onchange="Prefiniti.Projects.setFilters();">
                            <input type="checkbox" class="search-filter" data-filter-type="project-status" data-filter-term="Active" id="filter-active"> Active
                        </label>
                        <label class="btn btn-xs btn-primary btn-outline mr-3" onchange="Prefiniti.Projects.setFilters();">
                            <input type="checkbox" class="search-filter" data-filter-type="project-status" data-filter-term="Billed" id="filter-billed"> Billed
                        </label>
                        <label class="btn btn-xs btn-primary btn-outline mr-3" onchange="Prefiniti.Projects.setFilters();">
                            <input type="checkbox" class="search-filter" data-filter-type="project-status" data-filter-term="Paid" id="filter-paid"> Paid
                        </label>
                        <label class="btn btn-xs btn-primary btn-outline mr-3" onchange="Prefiniti.Projects.setFilters();">
                            <input type="checkbox" class="search-filter" data-filter-type="project-status" data-filter-term="Delinquent" id="filter-delinquent"> Delinquent
                        </label>
                        <label class="btn btn-xs btn-primary btn-outline mr-3" onchange="Prefiniti.Projects.setFilters();">
                            <input type="checkbox" class="search-filter" data-filter-type="project-status" data-filter-term="Closed" id="filter-closed"> Closed
                        </label>
                        <label class="btn btn-xs btn-primary btn-outline mr-3" onchange="Prefiniti.Projects.setFilters();">
                            <input type="checkbox" class="search-filter" data-filter-type="project-overdue" data-filter-term="false" id="filter-ontime"> On-Time
                        </label>
                        <label class="btn btn-xs btn-primary btn-outline mr-3" onchange="Prefiniti.Projects.setFilters();">
                            <input type="checkbox" class="search-filter" data-filter-type="project-overdue" data-filter-term="true" id="filter-overdue"> Overdue
                        </label>
                    </div>
                </div>
            </div>

            <div class="project-list">

                <table class="table table-hover">
                    <tbody>
                        <cfloop struct="#projects#" key="id">
                            <cfset stakeholders = projects[id].project.getStakeholders()>
                            <cfif projects[id].project.isOverdue()>
                                <cfset overdue = "true">
                            <cfelse>
                                <cfset overdue = "false">
                            </cfif>

                            <cfoutput>
                                <tr class="project-row" id="project-#id#" data-project-name="#projects[id].project.project_name#" data-project-status="#projects[id].project.project_status#" data-project-overdue="#overdue#">
                                    <td class="project-status">
                                        #projects[id].project.getStatus()#
                                    </td>
                                    <td class="project-title">
                                        <a href="##" onclick="Prefiniti.Projects.view(#id#);">#projects[id].project.project_name#</a>
                                        <br/>
                                        <small>Created #dateFormat(projects[id].project.project_created, "m.dd.yyyy")#</small>
                                    </td>
                                    <td class="project-completion">
                                        <small>Completion: #projects[id].project.getPercentComplete()#%</small>
                                        <div class="progress progress-mini">
                                            <div style="width: #projects[id].project.getPercentComplete()#%;" class="progress-bar"></div>
                                        </div>
                                    </td>
                                    <td class="project-people">
                                        <cfloop array="#stakeholders#" item="stakeholder">
                                            <a href="##" data-toggle="tooltip" data-placement="bottom" onclick="Prefiniti.Social.loadProfile(#stakeholder.user.id#);" title="#stakeholder.user.longName# (#stakeholder.type#)"><img alt="image" class="rounded-circle" src="#stakeholder.user.getPicture()#"></a>
                                        </cfloop>                                        
                                    </td>
                                    <td class="project-actions">
                                        <a href="##" class="btn btn-white btn-sm" onclick="Prefiniti.Projects.view(#id#);"><i class="fa fa-folder"></i> View </a>
                                    </td>
                                </tr>
                            </cfoutput>
                        </cfloop>                    
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

