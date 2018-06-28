<cfinclude template="/menus/menu_udf.cfm">
<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/workFlow/workflow_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<cfset profilePicture = getPicture(session.userid)>
<cfset longName = getLongname(session.userid)>
<cfset projects = getProjectsBySite(session.current_site_id)>
<cfset siteAssociations = getSiteAssociations(session.userid)>
<cfset lastSite = getLastSite(session.userid)>


<cfquery name="gUsers" datasource="webwarecl">
    SELECT longName, id FROM users WHERE type=1 ORDER BY lastName, firstName
</cfquery>

<cfquery name="qjnv" datasource="webwarecl">
    SELECT clsJobNumber, description FROM projects
</cfquery>

<cfset menus = getMenus()>

<div class="display: none;">
    <form id="ss-form" method="post" action="/siteSelectSubmit.cfm">
        <input type="hidden" id="ss-assoc" name="siteAssociation" value="">
    </form>
</div>

<nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top">
    <a class="navbar-brand" href="#" onclick="loadHomeView();"><img src="graphics/prefiniti-logo-white.png" alt="Prefiniti logo"></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-default" aria-controls="navbar-default" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbar-default">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" id="dropdown-user-menu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <cfoutput><img src="#profilePicture#" width="22" class="img-fluid rounded-circle"> #longName#</cfoutput>
                </a>
                <div class="dropdown-menu" aria-labelledby="dropdown-user-menu">
                    <cfoutput>                        
                        <a class="dropdown-item" href="##" onclick="viewProfile(#session.userid#);">View My Profile</a>                    
                        <a class="dropdown-item" href="##" onclick="AjaxLoadPageToDiv('tcTarget', '/socialnet/components/search_users.cfm');">Friend Search</a>
                        <div role="separator" class="dropdown-divider"></div>

                        <a class="dropdown-item" href="##" onclick="viewPictures(#session.userid#, true);">My Pictures</a>
                        <a class="dropdown-item" href="##" onclick="cmsBrowseFolder(#session.userid#, 'project_files', '', 'user', '');">My Files</a>
                        
                        <div role="separator" class="dropdown-divider"></div>

                        <a class="dropdown-item" href="##" onclick="AjaxLoadPageToDiv('tcTarget', '/businessnet/components/my_departments.cfm');">My Departments</a>
                        <a class="dropdown-item" href="##" onclick="AjaxLoadPageToDiv('tcTarget', '/scheduling/my_schedule.cfm?date=#DateFormat(Now(), "yyyy/mm/dd")#');">My Schedule</a>
                        
                        <div role="separator" class="dropdown-divider"></div>
                        <a class="dropdown-item" href="##" onclick="editUser(#session.userid#, 'basic_information.cfm');">Settings</a>

                        <div role="separator" class="dropdown-divider"></div>
                        <a class="dropdown-item" href="logoff.cfm">Sign Out</a>
                    </cfoutput>
                </div>
            </li>

            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" id="dropdown-sites-menu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Sites</a>
                <div class="dropdown-menu" aria-labelledby="dropdown-user-menu">
                    <cfoutput query="siteAssociations">
                        <a class="dropdown-item" href="##" onclick="Prefiniti.setAssociation(#id#);">#getSiteNameByID(site_id)# - 
                            <cfif #assoc_type# EQ 0>
                                Customer
                            <cfelse>
                                Employee
                            </cfif>
                            <cfif id EQ lastSite>
                                &nbsp;<strong>(Current)</strong>
                            </cfif>
                        </a>
                    </cfoutput>
                </div>
            </li>

            <cfoutput query="menus">
                <li class="nav-item dropdown">

                    <a class="nav-link dropdown-toggle" id="dropdown-#id#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">#caption#</a>
                    <div class="dropdown-menu" aria-labelledby="dropdown-#id#">
                        #getMenuItems(id, handle)#
                    </div>
                </li>
            </cfoutput>

            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" id="dropdown-mail" data-toggle="dropdown" href="#"><i class="fa fa-envelope"></i> <sup><span class="badge badge-secondary" id="badge-messages"></span></sup></a>
                <div class="dropdown-menu" aria-labelledby="dropdown-mail">
                    <div id="dropdown-mail-menu">
                        
                    </div>
                    <div role="separator" class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#" onclick="viewMailFolder('inbox', 1);">View All Messages</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#" onclick="AjaxLoadPageToDiv('tcTarget', '/socialnet/components/friend_requests.cfm');"><i class="fa fa-user-plus"></i> <sup><span class="badge badge-secondary" id="badge-friend-requests"></span></sup></a>
                
            </li>
            <li class="nav-item">
                <a class="nav-link" href="messages"><i class="fa fa-bell"></i> <sup><span class="badge badge-secondary" id="badge-notifications"></span></sup></a>
                
            </li>

        </ul>

        <form class="form-inline">
            <div class="input-group">
                <input type="text" class="form-control" id="search-text" aria-label="Text input with dropdown button" placeholder="Search">
                <div class="input-group-append">
                    <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span id="current-search-type">Projects</span></button>
                    <div class="dropdown-menu">

                        <div class="wrapper text-center" onclick="event.stopPropagation();">
                            <div class="btn-group" role="group" aria-label="Search type">
                                <button type="button" class="btn btn-success" onclick="Search.showProjects();">Projects</button>
                                <button type="button" class="btn btn-success" onclick="Search.showTimesheets();">Time Entry</button>
                            </div>
                        </div>

                        <div role="separator" class="dropdown-divider"></div>

                        <div id="project-locator" class="wrapper">
                            <a href="#" onclick="AjaxLoadPageToDiv('tcTarget', 'jobViews/priority.cfm');" class="dropdown-item"><img src="/graphics/report_add.png"> Priority projects</a>
                            <a href="#" onclick="AjaxLoadPageToDiv('tcTarget', 'jobViews/allIncomplete.cfm');" class="dropdown-item"><img src="/graphics/report_go.png"> All incomplete projects by customer</a>
                            <a href="#" onclick="AjaxLoadPageToDiv('tcTarget', 'jobViews/allByCustomer.cfm');" class="dropdown-item"><img src="/graphics/report_go.png"> All projects by customer</a>
                            
                            <div role="separator" class="dropdown-divider"></div>

                            <form class="px-4 py-3">
                                <div class="wrapper p-3">
                                    <h5>Search In</h5>
                                    <div class="pl-3">
                                        <div class="form-group">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" id="pl-project-number">
                                                <label class="form-check-label" for="pl-project-number">Project Number</label>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" id="pl-subdivision">
                                                <label class="form-check-label" for="pl-subdivision">Subdivision</label>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" id="pl-address">
                                                <label class="form-check-label" for="pl-address">Address</label>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" id="pl-section">
                                                <label class="form-check-label" for="pl-section">Section</label>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" id="pl-township">
                                                <label class="form-check-label" for="pl-township">Township</label>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" id="pl-range">
                                                <label class="form-check-label" for="pl-range">Range</label>
                                            </div>
                                        </div>
                                    </div>
                                    <h5 class="mt-3">Search Type</h5>
                                    <div class="pl-3">
                                        <div class="form-group">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="pl-search-type" id="pl-begins-with" checked>
                                                <label class="form-check-label" for="pl-begins-with">Begins With</label>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="pl-search-type" id="pl-contains">
                                                <label class="form-check-label" for="pl-contains">Contains</label>
                                            </div>
                                        </div>
                                    </div>                                   
                                </div>
                            </form>
                        </div>

                        <div id="timesheet-locator" style="display: none;">
                            <a href="#" onclick="AjaxLoadPageToDiv('tcTarget', 'tc/timesheet.cfm?action=add');" class="dropdown-item"><img src="/graphics/time_add.png"> New Timesheet</a>
                            <cfoutput>
                            <a href="##" onclick="loadTimesheetView('tcTarget', #session.userid# , '1/1/1980', '1/1/2999', 'Open', 'yes', '')" class="dropdown-item"><img src="/graphics/time_go.png"> My open timesheets</a>
                            </cfoutput>
                            <a href="#" onclick="AjaxLoadPageToDiv('tcTarget', 'tc/taskCodes.cfm');" class="dropdown-item"><img src="/graphics/book_edit.png"> Manage task codes</a>
                            
                            <div role="separator" class="dropdown-divider"></div>

                            <form class="px-4 py-3 override-inline" onclick="event.stopPropagation();">
                                <div class="form-group">                                    
                                    <label for="tl-employee-select">Employee</label>
                                    <select class="form-control" id="tl-employee-select">
                                        <option value="noUserFilter" selected>All users</option>
                                        <cfoutput query="gUsers">
                                            <option value="#id#">#longName#</option>
                                        </cfoutput>
                                    </select>
                                </div>
                                <div class="form-group mt-3">
                                    <label for="tl-fromdate">From</label>
                                    <input class="form-control" id="tl-fromdate" type="date">
                                </div> 
                                <div class="form-group">
                                    <label for="tl-todate">To</label>
                                    <input class="form-control" id="tl-todate" type="date">
                                </div> 
                                <div class="form-group mt-2">
                                    <button type="button" class="btn-primary btn-sm float-right">Current Week</button>
                                </div>

                                <h5>Filter By</h5>
                                <div class="pl-3">                                    
                                    <div class="form-group">
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="tc-filter" id="tc-view-all" checked>
                                            <label class="form-check-label" for="tc-view-all">View All</label>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="tc-filter" id="tc-signed-only">
                                            <label class="form-check-label" for="tc-signed-only">Signed Only</label>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="tc-filter" id="tc-open-only">
                                            <label class="form-check-label" for="tc-open-only">Open Only</label>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="tc-filter" id="tc-approved-only">
                                            <label class="form-check-label" for="tc-approved-only">Approved Only</label>
                                        </div>
                                    </div>                                                                 
                                </div>
                                <div class="form-group">
                                    <label for="tl-project">Project Number</label>
                                    <select class="form-control" id="tl-project">
                                        <option value="">No filter</option>
                                        <cfoutput query="projects">
                                            <option value="#id#">#clsJobNumber#</option>
                                        </cfoutput>                    
                                    </select>  
                                </div> 
                            </form>
                        </div>

                        <div role="separator" class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#" onclick>Save search options</a>
                    </div>
                </div>
            </div>   
        </form>
    </div>
</nav>