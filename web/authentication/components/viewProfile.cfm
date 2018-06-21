<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<cfquery name="profile" datasource="webwarecl">
	SELECT * FROM users WHERE id=#url.userid#
</cfquery>

<cfset comments = getComments(url.userid)>
<cfset friends = getFriends(url.userid)>
<cfset connections = getAssociationsByUser(url.userid)>

<div class="wrapper">
	<div class="row">
		<div class="col-md-4">
			<div class="card">
				<div class="card-header">
					<i class="fa fa-globe"></i> Profile Introduction
				</div>
				<div class="card-body">
					<cfoutput query="profile">
						<table class="table">
							<tbody>
								<tr>
									<td>
										<i class="fa fa-user"></i>
									</td>
									<td>#getOnline(url.userid)#</td>
								</tr>
								<tr>
									<td>
										<i class="fa fa-heart"></i>
									</td>
									<td>#relationship_status#</td>
								</tr>
								<tr>
									<td>
										<i class="fa fa-venus-mars"></i>
									</td>
									<td>#gender#</td>
								</tr>
								<tr>
									<td>
										<i class="fa fa-birthday-cake"></i>
									</td>
									<td>#dateDiff("yyyy", birthday, now())# years old</td>
								</tr>
								<tr>
									<td>
										<i class="fa fa-clock"></i>
									</td>
									<td>Last login #DateFormat(last_login, "mm/dd/yyyy")# #TimeFormat(last_login, "h:mm tt")#</td>
								</tr>
							</tbody>
						</table>
					</cfoutput>
				</div>
			</div> <!-- profile intro -->

			<div class="card mt-3">
				<div class="card-header">
					<i class="fa fa-tag"></i> Interests
				</div>
				<div class="card-body">
					<cfset interests = profile.interests.split(",")>

					<cfloop array="#interests#" item="interest">
						<cfoutput><span class="badge badge-secondary">#interest#</span></cfoutput>
					</cfloop>					
				</div>
			</div> <!-- interests -->
			
			<div class="card mt-3">
				<div class="card-header">
					<i class="fa fa-user-friends"></i> Friends
				</div>
				<div class="card-body">
					<cfset count = 0>
					<div class="row">
						<cfoutput query="#friends#">
							<div class="col-md-4">
								<cfset friendPic = getPicture(target_id)>
								<cfset friendName = getLongname(target_id)>
								
								<a href="##" onclick="AjaxLoadPageToDiv('tcTarget', '/authentication/components/viewProfile.cfm?userid=#target_id#');">
									<img src="#friendPic#" width="60" height="60"><br>
									<small>#friendName#</small>
								</a>
							</div>
						</cfoutput>
					</div>
				</div>
			</div> <!-- friends -->

			<div class="card mt-3">
				<div class="card-header">
					<i class="fa fa-building"></i> Connections
				</div>

				<div class="card-body">
					<table class="table">
						<tbody>
							<cfoutput query="#connections#">
								<tr>
									<td>
										<cfif assoc_type EQ 0>
											<i class="fa fa-store"></i>
										<cfelse>
											<i class="fa fa-building"></i>
										</cfif>
									</td>
									<td>
										<cfif assoc_type EQ 0>
											<cfset connection = "Customer of">
										<cfelse>
											<cfset connection = "Employee of">
										</cfif>
										#connection# <a href="javascript:viewSiteProfile(#site_id#);">#getSiteNameByID(site_id)#</a>
									</td>
								</tr>
							</cfoutput>
						</tbody>
					</table>
				</div>

			</div> <!-- connections -->

		</div>
		<div class="col-md-8">
			<cfoutput>
				<div class="wrapper">
					<div class="row">
						<div class="col-md-2">
							<img id="vp-picture-view" src="#getPicture(url.userid)#" class="img-fluid rounded-circle" width="120" align="bottom">
						</div>
						<div class="col-md-10">
							<h1>#getLongname(url.userid)#</h1>
							<h3 onmouseenter="Prefiniti.showEditIcon('user-status');" onmouseleave="Prefiniti.hideEditIcon('user-status');" id="user-status-view"><span id="user-status-content">#profile.status#</span> <span id="user-status-editicon" style="display: none;"><i onclick="Prefiniti.beginEditingField('user-status');" class="fa fa-edit edit-icon"></i></span></h3>
							<input class="form-control" id="user-status-edit" type="text" style="display: none;">
							<div class="btn-group float-right" role="group" aria-label="Basic example">
								<cfif NOT isFriend(session.userid, url.userid)>
									<button type="button" class="btn btn-light btn-sm">Send Friend Request</button>
								<cfelse>
									<button type="button" class="btn btn-light btn-sm">Unfriend</button>
								</cfif>
							  	<button type="button" class="btn btn-light btn-sm">Send Message</button>
							  	<cfif isFriend(session.userid, url.userid)>
							  		<button type="button" class="btn btn-light btn-sm">Post Comment</button>
								</cfif>
							</div>
						</div>
					</div>
				</div>
			</cfoutput>
			<hr>

			<cfoutput query="comments">
				<div class="card mb-2">
					<div class="card-body">
						<p>							
							<img src="#getPicture(from_id)#" class="img-fluid rounded-circle" width="30">						
							<b><a href="##" onclick="AjaxLoadPageToDiv('tcTarget', '/authentication/components/viewProfile.cfm?userid=#from_id#')">#getLongname(from_id)#</a></b>
						</p>
						<p>#body#</p>
						<small class="float-right">#dateFormat(sent_date, "d mmm yyyy")# | <a href="##">Reply</a></small>
					</div>
				</div>
			</cfoutput>

		</div>
		
	</div>
</div>