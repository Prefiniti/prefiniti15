<!--
    <wwaftitle>Manage Companies</wwaftitle>
    <wwafbreadcrumbs>Geodigraph Hub,Companies,Manage Companies</wwafbreadcrumbs>
-->

<cfquery name="getSiteList" datasource="sites">
	SELECT * FROM sites
</cfquery>

<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="ibox" style="width: 100%;">
            <div class="ibox-title">
                <h5>All Companies</h5>
                <div class="ibox-tools">
                    <a class="collapse-link">
                        <i class="fa fa-chevron-up"></i>
                    </a>
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-wrench"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="##" onclick="Prefiniti.dialog('/webware_admin/addSite.cfm');">Add New Company...</a></li>
                    </ul>
                    <a class="close-link">
                        <i class="fa fa-times"></i>
                    </a>
                </div>
            </div>
            <div class="ibox-content">
                <div class="table-responsive">
                    <table class="table table-striped table-bordered table-hover datatables">
                        <thead>
                        	<tr>
                            	<th>Site</th>
                                <th>&nbsp;</th>
                            </tr>
                        </thead>
                        <tbody>
                            <cfoutput query="getSiteList">
                            	<tr>
                                	<td>#SiteName#</td>
                                	<td align="right">
                                    	<button type="button" class="btn btn-sm btn-primary" onclick="Prefiniti.loadPage('/webware_admin/editSite.cfm?id=#siteid#');"><i class="fa fa-file"></i> Edit</button>
                                        <button type="button" class="btn btn-sm btn-primary" onclick="Prefiniti.loadPage('/webware_admin/getAssociations.cfm?site_id=#siteid#');"><i class="fa fa-user-tie"></i> Members</button>
                        				
                                    </td>
                            	</tr>
                            </cfoutput>
                        </tbody>
                    </table>        
                </div>
            </div>
        </div>
    </div>
</div>
