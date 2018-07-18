<cfset prefiniti = new Prefiniti.Base()>

<cfset profilePicture = prefiniti.getPicture(session.user.id)>
<cfset longName = prefiniti.getLongname(session.user.id)>
<cfset siteAssociations = prefiniti.getSiteAssociations(session.user.id)>
<cfset lastSite = prefiniti.getLastSite(session.user.id)>

<div class="row border-bottom">
    <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
        <div class="navbar-header">
            <a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="#"><i class="fa fa-bars"></i> </a>
            <form role="search" class="navbar-form-custom" action="search_results.html">
                <div class="form-group">
                    <input type="text" placeholder="Search" class="form-control" name="top-search" id="top-search">
                </div>
            </form>
        </div>
        <ul class="nav navbar-top-links navbar-right">
            <li>
                <span class="m-r-sm text-muted welcome-message">Welcome to Geodigraph PM</span>
            </li>
            <li class="dropdown">
                <a class="dropdown-toggle count-info" data-toggle="dropdown" href="#">
                    <i class="fa fa-envelope"></i>  <span id="badge-messages-unread-top" class="label label-warning">0</span>
                </a>
                <ul class="dropdown-menu dropdown-messages" id="dropdown-mail-menu">
                    <!-- to be filled by AJAX call -->
                </ul>
            </li>
            <li class="dropdown">
                <a class="dropdown-toggle count-info" data-toggle="dropdown" href="#">
                    <i class="fa fa-user-plus"></i>  <span class="label label-primary" id="badge-friend-requests">0</span>
                </a>
                <ul class="dropdown-menu dropdown-alerts">
                    <div id="dropdown-friend-requests-menu">
                        <!-- friend requests go here -->
                    </div>
                                        
                    <li>
                        <cfoutput>
                            <div class="text-center link-block">
                                <a href="##" class="dropdown-item" onclick="Prefiniti.loadPage('/socialnet/components/friend_requests.cfm');">
                                    <strong>See All Friend Requests</strong>
                                    <i class="fa fa-angle-right"></i>
                                </a>
                            </div>
                        </cfoutput>
                    </li>
                </ul>
            </li>


            <li>
                <a href="/logout">
                    <i class="fa fa-sign-out"></i> Sign Out
                </a>
            </li>
        </ul>

    </nav>
</div>