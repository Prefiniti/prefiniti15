<cfset user = new Prefiniti.Authentication.UserAccount({id: url.id}, false)>
<cfset memberships = user.getAssociationsByUser(url.id)>
<!--
<wwaftitle>Edit Account</wwaftitle>
<wwafbreadcrumbs>Geodigraph Hub,Administration,Edit Account</wwafbreadcrumbs>
-->

<div class="row">
	<div class="col-md-12">
		<div class="wrapper wrapper-content">
			<div class="row">
				<div class="col-md-6">
					<div class="ibox">
						<div class="ibox-title">
							<h5>User Info</h5>
						</div>
						<div class="ibox-content">
							<cfoutput>
								<table class="table">
                                    <tbody>
    									<tr>
    										<td>ID:</td>
    										<td>#user.id#</td>
    									</tr>
    									<tr>
    										<td>E-Mail:</td>
    										<td>#user.email#</td>
                                        </tr>
    									<tr>
    										<td>First Name:</td>
    										<td>#user.firstName#</td>
    									</tr>
    									<tr>
    										<td>Middle Initial:</td>
    										<td>#user.middleInitial#</td>
    									</tr>
    									<tr>
    										<td>Last Name:</td>
    										<td>#user.lastName#</td>
    									</tr>
    									<tr>
    										<td>Display Name:</td>
    										<td>#user.longName#</td>
    									</tr>
                                    </tbody>
								</table>
							</cfoutput>
						</div>
					</div> <!--- ibox --->
					<div class="ibox">
						<div class="ibox-title">
							<h5>Account Attributes</h5>
						</div> <!--- ibox-title --->
						<div class="ibox-content">
                            <cfoutput>
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Attribute</th>
                                            <th>Value</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>Account Enabled</td>
                                            <td>
                                                <cfmodule template="/webware_admin/components/boolean.cfm" userid="#url.id#" fieldprefix="adm" fieldname="account_enabled" fieldval="#user.account_enabled#">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Account Confirmed</td>
                                            <td>
                                                <cfmodule template="/webware_admin/components/boolean.cfm" userid="#url.id#" fieldprefix="adm" fieldname="confirmed" fieldval="#user.confirmed#">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Account Expired</td>
                                            <td>
                                                <cfmodule template="/webware_admin/components/boolean.cfm" userid="#url.id#" fieldprefix="adm" fieldname="expired" fieldval="#user.expired#">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>SMS Confirmed</td>
                                            <td>
                                                <cfmodule template="/webware_admin/components/boolean.cfm" userid="#url.id#" fieldprefix="adm" fieldname="sms_confirmed" fieldval="#user.sms_confirmed#">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Global Administrator</td>
                                            <td>
                                                <cfmodule template="/webware_admin/components/boolean.cfm" userid="#url.id#" fieldprefix="adm" fieldname="webware_admin" fieldval="#user.webware_admin#">
                                            </td>
                                        </tr>      
                                        <tr>
                                            <td>Two-Factor Authentication Enabled</td>
                                            <td>
                                                <cfmodule template="/webware_admin/components/boolean.cfm" userid="#url.id#" fieldprefix="adm" fieldname="tfa_enabled" fieldval="#user.tfa_enabled#">
                                            </td>
                                        </tr>                                  
                                    </tbody>
                                </table>
                            </cfoutput>
						</div> <!--- ibox-content --->
					</div> <!--- ibox --->
				</div>
				<div class="col-md-6">
					<div class="ibox">
						<div class="ibox-title">
							<h5>Memberships</h5>
						</div>
						<div class="ibox-content">
							<table class="table">
								<thead>
									<tr>
										<th>Membership ID</th>
										<th>Site ID</th>
										<th>Site Name</th>
										<th>Membership Class</th>
                                        <th>&nbsp;</th>
									</tr>
								</thead>
								<tbody>
									<cfoutput query="#memberships#">
										<tr>
											<td>#id#</td>
											<td>#site_id#</td>
											<td>#user.getSiteNameByID(site_id)#</td>											
											<td>#assoc_type# (<cfif assoc_type EQ 0>Client<cfelse>Employee</cfif>)</td>
                                            <td>
                                                <div class="btn-group">
                                                    <button type="button" class="btn btn-white btn-sm dropdown-toggle" data-toggle="dropdown"><i class="fa fa-wrench"></i></button>
                                                    <div class="dropdown-menu">                                                           
                                                        <button class="dropdown-item" type="button" onclick="Prefiniti.Admin.impersonate(#id#);">Impersonate...</button>  
                                                        <button class="dropdown-item" type="button" onclick="Prefiniti.Admin.impersonate(#id#);">Properties...</button>      
                                                    </div>
                                                </div>
                                            </td>
										</tr>
									</cfoutput>
								</tbody>
							</table>

						</div>
					</div>
				</div>
			</div> <!--- row --->
			<div class="row">
				<div class="col-md-6">

				</div> <!--- col-md-6 --->

			</div> <!--- row --->
		</div>
	</div>
</div>