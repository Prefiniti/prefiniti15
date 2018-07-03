<cfinclude template="/menus/menu_udf.cfm">
<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/workFlow/workflow_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<cfset profilePicture = getPicture(session.userid)>
<cfset longName = getLongname(session.userid)>
<cfset projects = getProjectsBySite(session.current_site_id)>
<cfset siteAssociations = getSiteAssociations(session.userid)>
<cfset lastSite = getLastSite(session.userid)>

<cfset menus = getMenus()>

<div class="display: none;">
    <form id="ss-form" method="post" action="/siteSelectSubmit.cfm">
        <input type="hidden" id="ss-assoc" name="siteAssociation" value="">
    </form>
</div>

<nav class="navbar-default navbar-static-side" role="navigation">
    <div class="sidebar-collapse">
        <ul class="nav metismenu" id="side-menu">
            <li class="nav-header">
                <div class="dropdown profile-element">
                    <cfoutput>
                        <img alt="image" class="rounded-circle avatar" src="#session.user.getPicture()#"/>                    
                    <a data-toggle="dropdown" class="dropdown-toggle" href="##">
                        <span class="block m-t-xs font-bold">#session.user.longName#</span>
                        <span class="text-muted text-xs block"><cfmodule template="/authentication/components/siteNameByID.cfm" id="#session.current_site_id#"> <b class="caret"></b></span>
                    </a>
                    <ul class="dropdown-menu animated fadeInRight m-t-xs">

                        <li><a class="dropdown-item" href="##" onclick="loadHomeView();">Home</a></li>
                        <li><a class="dropdown-item" href="##" onclick="viewProfile(#session.userid#);">View My Profile</a></li>
                        <li><a class="dropdown-item" href="##" onclick="AjaxLoadPageToDiv('tcTarget', '/socialnet/components/search_users.cfm');">Friend Search</a></li>
                        <li><div role="separator" class="dropdown-divider"></div></li>

                        <cfoutput query="siteAssociations">
                            <li>
                                <a class="dropdown-item <cfif site_id EQ session.current_site_id>active</cfif>" href="##" onclick="Prefiniti.setAssociation(#id#);">#getSiteNameByID(site_id)# - 
                                    <cfif #assoc_type# EQ 0>
                                        Customer
                                    <cfelse>
                                        Employee
                                    </cfif>                                
                                </a>
                            </li>
                        </cfoutput>

                        <li><div role="separator" class="dropdown-divider"></div></li>


                        <li><a class="dropdown-item" href="##" onclick="viewPictures(#session.userid#, true);">My Pictures</a></li>
                        <li><a class="dropdown-item" href="##" onclick="cmsBrowseFolder(#session.userid#, 'project_files', '', 'user', '');">My Files</a></li>
                        
                        <li><div role="separator" class="dropdown-divider"></div></li>

                        <li><a class="dropdown-item" href="##" onclick="AjaxLoadPageToDiv('tcTarget', '/businessnet/components/my_departments.cfm');">My Departments</a></li>
                        <li><a class="dropdown-item" href="##" onclick="AjaxLoadPageToDiv('tcTarget', '/scheduling/my_schedule.cfm?date=#DateFormat(Now(), "yyyy/mm/dd")#');">My Schedule</a></li>
                        
                        <li><div role="separator" class="dropdown-divider"></div></li>
                        <li><a class="dropdown-item" href="##" onclick="editUser(#session.userid#, 'basic_information.cfm');">Settings</a></li>

                        <li><div role="separator" class="dropdown-divider"></div></li>
                        <li><a class="dropdown-item" href="logoff.cfm">Sign Out</a></li>
                    </ul>
                    </cfoutput>
                </div>
                <div class="logo-element">
                    <img src="/graphics/pi-16x16.png">
                </div>
            </li>

            
            
            
            <li>
                <a href="##"><i class="fa fa-envelope"></i> <span class="nav-label">Mailbox </span><span class="label label-warning float-right"><span id="badge-messages-unread-side">0</span><span id="badge-messages-total"></span></a>
                <ul class="nav nav-second-level collapse">
                    <li><a href="##" onclick="viewMailFolder('inbox', 1);">Inbox</a></li>
                    <li><a href="##" onclick="viewMailFolder('sent messages', 1);">Sent Mail</a></li>
                    <li><a href="##" onclick="writeMessage();">Compose Mail</a></li>                    
                </ul>
            </li>

            <li>
                <a href="##"><i class="fa fa-building"></i> <span class="nav-label">Company</span><span class="fa arrow"></span></a>
                <ul class="nav nav-second-level collapse">
                    <cfif getPermissionByKey('WW_SITEMAINTAINER', #session.current_association#) EQ true>
                        <li><a href="#" onclick="AjaxLoadPageToDiv('tcTarget', '/authentication/components/associationManager.cfm');">Manage Accounts</a></li>
                    </cfif>
                    <li><a href="#" onclick="AjaxLoadPageToDiv('tcTarget', '/businessnet/components/people.cfm?mode=Clients');">Clients</a></li>
                    <li><a href="#" onclick="AjaxLoadPageToDiv('tcTarget', '/businessnet/components/people.cfm?mode=Employees');">Employees</a></li>                    
                </ul>
            </li>

            <cfif session.user.webware_admin EQ 1>
                <li>
                    <a href="##"><i class="fa fa-cogs"></i> <span class="nav-label">Global Admin</span><span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level collapse">
                        <li><a href="#" onclick="AjaxLoadPageToDiv('tcTarget', '/webware_admin/manageSites.cfm');">Manage Sites</a></li>
                        <!--<li><a href="#">Manage Accounts</a></li>-->
                        <li><a href="#" onclick="AjaxLoadPageToDiv('tcTarget', '/socialnet/components/postWebgram.cfm');">Post WebGram</a></li>
                    </ul>
                </li>
            </cfif>



            <!---
            <cfoutput query="menus">
                <cfif caption NEQ "Mail">
                    <li>
                        <a href="##"><span class="nav-label">#caption#</span><span class="fa arrow"></span></a> 
                        <ul class="nav nav-second-level collapse">               
                            #getMenuItems(id, handle)#                    
                        </ul>
                    </li>
                </cfif>
            </cfoutput> 
            --->           
           
        </ul>

    </div>
</nav>