<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>

    <cfswitch expression="#url.mode#">
        <cfcase value="clients">        
            <cfset mode = "Clients">
            <cfset qPeople = prefiniti.wwGetCustomersBySite(session.current_site_id)>
        </cfcase>
        <cfcase value="employees">
            <cfset mode = "Employees">
            <cfset qPeople = prefiniti.wwGetEmployeesBySite(session.current_site_id)>
        </cfcase>
    </cfswitch>

    <cfset people = []>
    <cfoutput query="qPeople">
        <cfset ArrayAppend(people, new Prefiniti.Authentication.UserAccount({id: user_id}, false))>
    </cfoutput>
</cfsilent>

<cfoutput>
<!--
<wwaftitle>#mode#</wwaftitle>
<wwafbreadcrumbs>Geodigraph PM,#mode#</wwafbreadcrumbs>
-->
</cfoutput>

<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-8">
            <div class="ibox">
                <div class="ibox-content">
                    <div class="btn-group float-right">
                        <div class="btn-group">
                            <cfif mode EQ "Clients">
                                <button type="button" class="btn btn-white btn-sm"><i class="fa fa-plus"></i> New Client</button>
                            <cfelse>
                                <button type="button" class="btn btn-white btn-sm"><i class="fa fa-plus"></i> New Employee</button>
                            </cfif>
                        </div>
                    </div>
                    <h2><cfoutput>#mode# of #prefiniti.getSiteNameByID(session.current_site_id)#</cfoutput></h2>                    
                    <div class="input-group">
                        <cfoutput><input id="search-people" onkeyup="Prefiniti.searchPeople();" type="text" placeholder="Search #mode#" class="input form-control"></cfoutput>
                        <span class="input-group-append">
                            <button type="button" class="btn btn btn-primary" onclick="Prefiniti.searchPeople();"> <i class="fa fa-search"></i> Search</button>
                        </span>
                    </div>
                    <div class="clients-list">
                        <span class="float-right small text-muted"><cfoutput>#qPeople.recordCount# #mode#</cfoutput> </span>
                        <ul class="nav nav-tabs">
                            <li><a class="nav-link active" data-toggle="tab" href="#tab-people"><i class="fa fa-user"></i> People</a></li>
                        </ul>
                        <div class="tab-content">
                            <div id="tab-people" class="tab-pane active">
                                
                                <table class="table table-striped table-hover">
                                    <tbody>
                                        <cfloop array="#people#" item="person">
                                            <cfset roles = person.getRoles()>

                                            <cfoutput>
                                                <tr id="person-row-#person.id#" class="person-row" data-person-full-name="#person.longName#" data-person-online="#person.online#" data-person-first-name="#person.firstName#" data-person-last-name="#person.lastName#" data-person-email="#person.email#">
                                                    <td class="client-avatar"><img alt="image" src="#person.getPicture()#"> </td>
                                                    <td><a href="##" onclick="Prefiniti.loadPersonDetail(#person.id#, '#mode#');" class="client-link">#person.longName#</a></td>
                                                    <td></td>
                                                    <td class="contact-type"><i class="fa fa-envelope"></i></td>
                                                    <td>#person.email#</td>
                                                    <td class="client-status">
                                                        <cfif mode EQ "Employees">
                                                            <cfset key = "employee">
                                                        <cfelse>
                                                            <cfset key = "client">
                                                        </cfif>
                                                        <cfset role_id = roles[session.current_site_id][key]>
                                                        <cfif mode EQ "Employees">
                                                            <cfset employee = prefiniti.getEmployeeRecord(role_id)>

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
                                                        <cfif getPermissionByKey('WW_SITEMAINTAINER', role_id) EQ true>
                                                            <span class="label label-success">Site Admin</span>
                                                        </cfif>      
                                                        <cfif person.webware_admin EQ 1>
                                                            <span class="label label-info">Global Admin</span>
                                                        </cfif>                                                  
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
            </div>
        </div>
        <div class="col-sm-4">
            <div class="ibox selected">
                <div class="ibox-content">
                    <div class="tab-content">
                        <div id="contact-detail" class="tab-pane active">
                            <h2>Please select a person.</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
