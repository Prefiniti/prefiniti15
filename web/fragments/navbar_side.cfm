<cfset prefiniti = new Prefiniti.Base()>

<cfset profilePicture = prefiniti.getPicture(session.user.id)>
<cfset longName = prefiniti.getLongname(session.user.id)>
<cfset siteAssociations = prefiniti.getSiteAssociations(session.user.id)>
<cfset lastSite = prefiniti.getLastSite(session.user.id)>

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
                        <span id="profile-photo"><img alt="image" class="rounded-circle avatar" src="#session.user.getPicture()#"/></span>                    
                    <a data-toggle="dropdown" class="dropdown-toggle" href="##">
                        <span class="block m-t-xs font-bold">                            
                            #session.user.longName#
                            <cfif session.user.webware_admin EQ 1>
                                &nbsp;<i class="fa fa-shield-alt"></i>
                            </cfif>
                        </span>
                        <span class="text-muted text-xs block" id="user-menu"><cfmodule template="/authentication/components/siteNameByID.cfm" id="#session.current_site_id#"> <b class="caret"></b></span>
                    </a>
                    <ul class="dropdown-menu animated fadeInRight m-t-xs">

                        <li><a class="dropdown-item" href="##" onclick="Prefiniti.Dashboard.load();"><i class="fa fa-th-large"></i> <cfmodule template="/authentication/components/siteNameByID.cfm" id="#session.current_site_id#"> PM Dashboard</a></li>
                        <li><a class="dropdown-item" href="##" onclick="Prefiniti.Social.loadProfile(#session.userid#);"><i class="fa fa-user-circle"></i> View My Profile</a></li>
                        <li><a class="dropdown-item" href="##" onclick="Prefiniti.Social.friendSearch();"><i class="fa fa-users"></i> Friend Search...</a></li>
                        <li><div role="separator" class="dropdown-divider"></div></li>

                        <cfoutput query="siteAssociations">
                            <li>
                                <a class="dropdown-item <cfif site_id EQ session.current_site_id>active</cfif>" href="##" onclick="Prefiniti.setAssociation(#id#);"><i class="fa fa-building"></i> #getSiteNameByID(site_id)# - 
                                    <cfif #assoc_type# EQ 0>
                                        Client
                                    <cfelse>
                                        Employee
                                    </cfif>                                
                                </a>
                            </li>
                        </cfoutput>

                        <li><div role="separator" class="dropdown-divider"></div></li>


                        <li><a class="dropdown-item" href="##" onclick="viewPictures(#session.userid#, true);"><i class="fa fa-images"></i> My Pictures</a></li>
                        <li><a class="dropdown-item" href="##" onclick="cmsBrowseFolder(#session.userid#, 'project_files', '', 'user', '');"><i class="fa fa-folder-open"></i> My Files</a></li>                                                
                        
                        <li><div role="separator" class="dropdown-divider"></div></li>
                        <li><a class="dropdown-item" href="##" onclick="editUser(#session.userid#, 'basic_information.cfm');"><i class="fa fa-cogs"></i> Settings</a></li>

                        <li><div role="separator" class="dropdown-divider"></div></li>
                        <li><a class="dropdown-item" href="/logout"><i class="fa fa-sign-out"></i> Sign Out...</a></li>
                    </ul>
                    </cfoutput>
                </div>
                <div class="logo-element">
                    <img src="/graphics/geodigraph_icon.png">
                </div>
            </li>
            <li>
                <a href="##" onclick="Prefiniti.Dashboard.load();" id="dashboard-shortcut"><i class="fa fa-th-large"></i><span class="nav-label">Dashboard</span></a>
            </li>            
            <li>
                <a href="##" id="mailbox-shortcut"><i class="fa fa-envelope"></i> <span class="nav-label">Mailbox </span><span class="label label-warning float-right"><span id="badge-messages-unread-side">0</span><span id="badge-messages-total"></span></a>
                <ul class="nav nav-second-level collapse">
                    <li><a href="##" onclick="Prefiniti.Mail.viewFolder('inbox', 1);">Inbox</a></li>
                    <li><a href="##" onclick="Prefiniti.Mail.viewFolder('sent messages', 1);">Sent Mail</a></li>
                    <li><a href="##" onclick="Prefiniti.Mail.writeMessage();">Compose Mail</a></li>                    
                </ul>
            </li>

            <li>
                <a href="##" id="company-shortcut"><i class="fa fa-building"></i> <span class="nav-label">Company</span><span class="fa arrow"></span></a>
                <ul class="nav nav-second-level collapse">
                    <li><a href="#" onclick="Prefiniti.Projects.create();">New Project</a></li>
                    <li class="dropdown-divider"></li>
                    <li><a href="#" onclick="Prefiniti.loadPage('/businessnet/components/people.cfm?mode=Clients');">Clients</a></li>
                    <li><a href="#" onclick="Prefiniti.loadPage('/businessnet/components/people.cfm?mode=Employees');">Employees</a></li>
                    <li class="dropdown-divider"></li>
                    <li><a href="#" onclick="Prefiniti.Business.siteSettings();">Settings</a></li>
                </ul>
            </li>

            <cfif session.user.webware_admin EQ 1>
                <li>
                    <a href="##"><i class="fa fa-cogs"></i> <span class="nav-label">Global Admin</span><span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level collapse">
                        <li><a href="#" onclick="Prefiniti.loadPage('/webware_admin/manageSites.cfm');">Manage Companies</a></li>
                        <li><a href="#" onclick="Prefiniti.loadPage('/socialnet/components/postWebgram.cfm');">Post WebGram</a></li>
                    </ul>
                </li>
            </cfif>       
           
        </ul>

    </div>
</nav>