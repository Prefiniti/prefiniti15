<cfset prefiniti = new Prefiniti.Base()>

<div class="wwaf-metadata">
    <wwaftitle>Company Settings</wwaftitle>
    <wwafbreadcrumbs>Geodigraph Hub,Company Settings</wwafbreadcrumbs>
</div>

<div class="wrapper wrapper-content animated fadeIn">
    <div class="row">
        <div class="col-lg-12">
            <div class="tabs-container">
                <ul class="nav nav-tabs" role="tablist">
                    <li><a class="nav-link active" data-toggle="tab" href="#settings-basic"><i class="fa fa-cogs"></i> General</a></li>
                    <li><a class="nav-link" data-toggle="tab" href="#settings-task"><i class="fa fa-list-alt"></i> Services</a></li>                    
                </ul>
                <div class="tab-content">
                    <div role="tabpanel" id="settings-basic" class="tab-pane active">
                        <div class="panel-body">
                            <cfmodule template="/businessnet/components/site_manager/basic_information.cfm">
                        </div>
                    </div>
                    <div role="tabpanel" id="settings-task" class="tab-pane">
                        <div class="panel-body">
                            <cfmodule template="/businessnet/components/site_manager/edit_task_codes.cfm">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
