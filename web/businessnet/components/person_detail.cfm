<cfset person = new Prefiniti.Authentication.UserAccount({id: url.user_id}, false)>
<cfset prefiniti = new Prefiniti.Base()>
<cfset userEvents = prefiniti.getUserEvents(url.user_id)>
<cfset roles = person.getRoles()>

<cfif url.mode EQ "Employees">
    <cfset key = "employee">
<cfelse>
    <cfset key = "client">
</cfif>

<cfset role_id = roles[session.current_site_id][key]>
<cfif url.mode EQ "Employees">
    <cfset employee = prefiniti.getEmployeeRecord(role_id)>
<cfelse>
    <!-- TODO: get client record -->
</cfif>

<cfoutput>
    <div class="row m-b-lg">
        <div class="col-lg-4 text-center">
            <h2>#person.longName#</h2>


            <div class="m-b-sm">
                <img alt="image" class="rounded-circle" src="#person.getPicture()#"
                style="width: 62px">
            </div>
        </div>
        <div class="col-lg-8">
            <cfif url.mode EQ "Employees">
                <p><strong>#employee.title#</strong></p>
            <cfelse>
                <!-- What to put here for clients? -->
            </cfif>
            
            <p>
                <cfif url.mode EQ "Employees">
                    <cfif employee.employment_status EQ "Active">
                        <span class="label label-success">Active</span>
                    <cfelse>
                        <span class="label label-warning">#employee.employment_status#</span>
                    </cfif>
                </cfif>
                        
                <cfif person.online EQ 1>
                    <span class="label label-primary">Online</span>
                <cfelse>
                    <span class="label label-warning">Offline</span>
                </cfif>
                <cfif getPermissionByKey('WW_SITEMAINTAINER', roles[session.current_site_id][key]) EQ true>
                    <span class="label label-success">Site Admin</span>
                </cfif>      
                <cfif person.webware_admin EQ 1>
                    <span class="label label-info">Global Admin</span>
                </cfif>
            </p>
            
            <p>#person.status#</p>

            <div class="btn-group">
                <button type="button" class="btn btn-primary btn-sm" onclick="Prefiniti.Social.loadProfile(#person.id#);"><i class="fa fa-user"></i> Profile</button>
                <button type="button" class="btn btn-primary btn-sm" onclick="Prefiniti.Mail.writeMessage(#person.id#);"><i
                    class="fa fa-envelope"></i> Message
                </button>
                <cfif getPermissionByKey('WW_SITEMAINTAINER', #session.current_association#) EQ true>
                    <cfif url.mode EQ "Employees">
                        <button class="btn btn-primary btn-sm dropdown-toggle" type="button" id="edit-button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fa fa-cog"></i> Edit
                        </button>
                        <div class="dropdown-menu" aria-labelledby="edit-button">
                            <a class="dropdown-item" href="##" onclick="Prefiniti.dialog('/businessnet/components/edit_permissions.cfm?id=#role_id#');">Permissions</a>
                            <a class="dropdown-item" href="##" onclick="Prefiniti.loadPage('/businessnet/components/edit_employee_records.cfm?id=#role_id#');">Employee Records</a>                            
                        </div>
                    <cfelse>
                        <button class="btn btn-primary btn-sm dropdown-toggle" type="button" id="edit-button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fa fa-cog"></i> Edit
                        </button>
                        <div class="dropdown-menu" aria-labelledby="edit-button">
                            <a class="dropdown-item" href="##" onclick="Prefiniti.dialog('/businessnet/components/edit_permissions.cfm?id=#role_id#');">Permissions</a>
                            <a class="dropdown-item" href="##" onclick="Prefiniti.loadPage('/businessnet/components/edit_client_records.cfm?id=#role_id#');">Client Records</a> 
                            <a class="dropdown-item" href="##" onclick="Prefiniti.Projects.create(#role_id#);">Create Project...</a>                           
                        </div>
                    </cfif>
                </cfif>
            </div>
        </div>
    </div>
    <div class="client-detail">
        <hr>
        <cfif url.mode EQ "Employees">
            <div class="row mb-1">
                <div class="col-lg-4">
                    <strong>Employment Status:</strong>
                </div>
                <div class="col-lg-8">
                    #employee.employment_status#
                </div>
            </div>
            <div class="row mb-1">
                <div class="col-lg-4">
                    <strong>Applied:</strong>
                </div>
                <div class="col-lg-8">
                    #dateFormat(employee.application_date, "mmm dd, yyyy")#
                </div>
            </div>
            <div class="row mb-1">
                <div class="col-lg-4">
                    <strong>Hired:</strong>
                </div>
                <div class="col-lg-8">
                    #dateFormat(employee.hire_date, "mmm dd, yyyy")#
                </div>
            </div>
            <cfif employee.employment_status EQ "Terminated">
                <div class="row mb-1">
                    <div class="col-lg-4">
                        <strong>Terminated:</strong>
                    </div>
                    <div class="col-lg-8">
                        #dateFormat(employee.termination_date, "mmm dd, yyyy")#
                    </div>
                </div>
            </cfif>
            <div class="row mb-1">
                <div class="col-lg-4">
                    <strong>Wage:</strong>
                </div>
                <div class="col-lg-8">
                    #employee.wage# (#employee.wage_basis#, paid #employee.payroll_frequency#)
                </div>
            </div>            
            <cfif employee.notes NEQ "">
                <hr>
                <div class="row mb-1">
                    <div class="col-lg-12">
                        <p><strong>Notes</strong></p>
                        #employee.notes#
                    </div>
                </div>
            </cfif>
            <cfif employee.resume NEQ "">
                <hr>
                <div class="row mb-1">
                    <div class="col-lg-12">
                        <p><strong>Resume</strong></p>
                        #employee.resume#
                    </div>
                </div>
            </cfif>
            <cfif employee.application NEQ "">
                <hr>
                <div class="row mb-1">
                    <div class="col-lg-12">
                        <p><strong>Application for Employment</strong></p>
                        #employee.application#
                    </div>
                </div>
            </cfif>
        <cfelse>

        </cfif>
        <hr>
        <strong>Projects</strong>
        <cfmodule template="/pm/components/user_project_overview.cfm" role_id="#role_id#" mini="mini">
        <hr>
        <strong>Timeline activity</strong>
        <div id="vertical-timeline" class="vertical-container dark-timeline">
            <cfoutput query="userEvents" maxrows="10">
                <div class="vertical-timeline-block">
                    <div class="vertical-timeline-icon gray-bg">
                        <img src="/graphics/#event_icon#">
                    </div>
                    <div class="vertical-timeline-content">
                        <p>#event_text#</p>
                        <span class="vertical-date small text-muted">#prefiniti.getFriendlyDuration(event_date)#</span>
                    </div>
                </div>
            </cfoutput>           
        </div>        
    </div>
</cfoutput>