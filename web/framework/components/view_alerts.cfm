<div class="wwaf-metadata">
    <wwaftitle>All Alerts</wwaftitle>
    <wwafbreadcrumbs>Geodigraph PM,All Alerts</wwafbreadcrumbs>
</div>

<cfset prefiniti = new Prefiniti.Base()>
<cfset notifications = prefiniti.getNotifications()>

<div class="wrapper wrapper-content animated fadeInUp">

    <div class="ibox">
        <div class="ibox-title">
            <h5>All Alerts</h5>
        </div>
        <div class="ibox-content">
             <div class="row m-b-sm m-t-sm">
                <div class="col-md-1">
                    <button type="button" id="loading-example-btn" class="btn btn-white btn-sm" ><i class="fa fa-refresh"></i> Refresh</button>
                </div>
                <div class="col-md-11">
                    <div class="input-group">
                        <input type="text" placeholder="Search" class="form-control-sm form-control"> 
                        <div class="input-group-append">
                            <button type="button" class="btn btn-sm btn-primary"> Search</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="project-list">
                <table class="table table-hover">
                    <tbody>
                        <cfoutput query="notifications">
                            <cfif viewed NEQ 1>
                                <tr id="all-alerts-#id#">
                                    <td>#notification_text#</td>
                                    <td>#prefiniti.getFriendlyDuration(created_date)#</td>
                                    <td><button type="button" class="btn btn-sm btn-white" onclick="Prefiniti.notificationClicked(#id#);"><i class="fa fa-trash-alt"></i></button></td>
                                </tr>
                            </cfif>
                        </cfoutput>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>