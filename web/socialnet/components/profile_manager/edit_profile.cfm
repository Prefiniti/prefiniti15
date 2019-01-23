<cfset prefiniti = new Prefiniti.Base()>

<div class="wwaf-metadata">
    <wwaftitle>Account Settings</wwaftitle>
    <wwafbreadcrumbs>Geodigraph Hub,Account Settings</wwafbreadcrumbs>
</div>

<div class="wrapper wrapper-content animated fadeIn">
    <div class="row">
        <div class="col-lg-12">
            <div class="tabs-container">
                <ul class="nav nav-tabs" role="tablist">
                    <li><a class="nav-link active" data-toggle="tab" href="#settings-basic"><i class="fa fa-cogs"></i> General</a></li>
                    <li><a class="nav-link" data-toggle="tab" href="#settings-bkgd"><i class="fa fa-tag"></i> Background</a></li>
                    <li><a class="nav-link" data-toggle="tab" href="#settings-contact"><i class="fa fa-address-card"></i> Contact Information</a></li>
                    <li><a class="nav-link" data-toggle="tab" href="#settings-locations"><i class="fa fa-map-marker-alt"></i> Locations</a></li>
                    <li><a class="nav-link" data-toggle="tab" href="#settings-notify"><i class="fa fa-bell"></i> Notifications</a></li>
                    <li><a class="nav-link" data-toggle="tab" href="#settings-privacy"><i class="fa fa-shield-alt"></i> Privacy &amp; Security</a></li>
                </ul>
                <div class="tab-content">
                    <div role="tabpanel" id="settings-basic" class="tab-pane active">
                        <div class="panel-body">
                            <cfmodule template="/socialnet/components/profile_manager/basic_information.cfm" user_id="#session.user.id#">
                        </div>
                    </div>
                    <div role="tabpanel" id="settings-bkgd" class="tab-pane">
                        <div class="panel-body">
                            <cfmodule template="/socialnet/components/profile_manager/background.cfm" user_id="#session.user.id#">
                        </div>
                    </div>
                    <div role="tabpanel" id="settings-contact" class="tab-pane">
                        <div class="panel-body">
                            <cfmodule template="/socialnet/components/profile_manager/contact_info.cfm" user_id="#session.user.id#">
                        </div>
                    </div>
                    <div role="tabpanel" id="settings-locations" class="tab-pane">
                        <div class="panel-body">
                            <cfmodule template="/socialnet/components/profile_manager/locations.cfm" user_id="#session.user.id#">
                        </div>
                    </div>
                    <div role="tabpanel" id="settings-notify" class="tab-pane">
                        <div class="panel-body">
                            <cfmodule template="/socialnet/components/profile_manager/notifications.cfm" user_id="#session.user.id#">
                        </div>
                    </div>
                    <div role="tabpanel" id="settings-privacy" class="tab-pane">
                        <div class="panel-body">
                            <cfmodule template="/socialnet/components/profile_manager/privacy.cfm" user_id="#session.user.id#">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
