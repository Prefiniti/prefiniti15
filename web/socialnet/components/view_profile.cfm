<cfinclude template="/socialnet/socialnet_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<cfset profileUser = new Prefiniti.Authentication.UserAccount({id: url.userid}, false)>

<div class="wwaf-metadata">
	<cfoutput>
		<wwaftitle>User Profile</wwaftitle>
		<wwafbreadcrumbs>Geodigraph PM,Social Networking,User Profiles,#profileUser.longName#</wwafbreadcrumbs>
	</cfoutput>
</div>

<cfset profile = profileUser.profileQuery>
<cfset friends = profileUser.getFriends()>
<cfset connections = getAssociationsByUser(url.userid)>
<cfset posts = profileUser.getUserPosts()>

<cfif url.userid EQ session.userid>
	<cfset isSelf = true>
	<cfset canWrite = true>
	<cfset canFriend = false>
	<cfset canUnfriend = false>
	<cfset canMessage = false>
	<cfset canComment = true>
<cfelse>
	<cfset isSelf = false>
	<cfset canWrite = false>
	<cfset canMessage = true>
</cfif>

<cfif isFriend(session.userid, url.userid)>
	<cfset canFriend = false>
	<cfif NOT isSelf>
		<cfset canUnfriend = true>
		<cfset canComment = true>
	</cfif>	
<cfelse>
	<cfset canFriend = true>
	<cfset canUnfriend = false>
	<cfif NOT isSelf>
		<cfset canComment = false>
	</cfif>
</cfif>

<cfif NOT isSelf>
	<cfset incrementView(url.userid)>	
</cfif>

<cfset visits = getVisits(url.userid)>

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
								<!---
								<tr>
									<td>
										<i class="fa fa-heart"></i>
									</td>
									<cfif relationship_status NEQ "">
										<td>#relationship_status#</td>
									<cfelse>
										<td>Unknown relationship status</td>
									</cfif>
								</tr>
								--->
								<tr>
									<td>
										<i class="fa fa-venus-mars"></i>
									</td>
									<cfif gender NEQ "">
										<td>#gender#</td>
									<cfelse>
										<td>Unknown gender</td>
									</cfif>
								</tr>
								<tr>
									<td>
										<i class="fa fa-birthday-cake"></i>
									</td>
									<td>
										<cftry>
											#dateDiff("yyyy", birthday, now())# years old
											<cfcatch type="any">
												No birthday on file
											</cfcatch>
										</cftry>
									</td>
								</tr>
								<tr>
									<td>
										<i class="fa fa-clock"></i>
									</td>
									<td>Last login #DateFormat(last_login, "d mmm yyyy")# #TimeFormat(last_login, "h:mm tt")#</td>
								</tr>
								<tr>
									<td>
										<i class="fa fa-eye"></i>
									</td>
									<td>#profile_views# profile views</td>
								</tr>
							</tbody>
						</table>
					</cfoutput>
				</div>
			</div> <!-- profile intro -->

			<cfif profile.bio NEQ "">
				<div class="card mt-3">
					<div class="card-header">
						<i class="fa fa-info-circle"></i> Bio
					</div>
					<div class="card-body">
						<cfoutput>#profile.bio#</cfoutput>
					</div>
				</div> <!-- bio -->
			</cfif>

			<cfif profile.background NEQ "">
				<div class="card mt-3">
					<div class="card-header">
						<i class="fa fa-book"></i> Background
					</div>
					<div class="card-body">
						<cfoutput>#profile.background#</cfoutput>
					</div>
				</div> <!-- background -->
			</cfif>

			<cfif profile.interests NEQ "">
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
			</cfif>

			<cfif profile.music NEQ "">
				<div class="card mt-3">
					<div class="card-header">
						<i class="fa fa-music"></i> Music
					</div>
					<div class="card-body">
						<cfset music = profile.music.split(",")>

						<cfloop array="#music#" item="group">
							<cfoutput><span class="badge badge-secondary">#group#</span></cfoutput>
						</cfloop>	
					</div>
				</div> <!-- music -->
			</cfif>
			
			<div class="card mt-3">
				<div class="card-header">
					<i class="fa fa-user-friends"></i> Friends
				</div>
				<div class="card-body">
					<cfset count = 0>
					<div class="row">
						<cfloop array="#friends#" item="friend">
							<cfoutput>
								<div class="col-md-4">
									<cfset friendPic = friend.getPicture()>
									<cfset friendName = friend.longName>
									
									<a href="##" onclick="Prefiniti.Social.loadProfile(#friend.id#);">
										<img src="#friendPic#" width="60" height="60"><br>
										<small>#friendName#</small>
									</a>
								</div>
							</cfoutput>
						</cfloop>
					</div>
				</div>
			</div> <!-- friends -->

			<div class="card mt-3">
				<div class="card-header">
					<i class="fa fa-book-open"></i> Visitors
				</div>
				<div class="card-body">
					<table class="table">
						<thead>
							<tr>
								<th>Visitor</th>
								<th>Age</th>
								<th>Date</th>
							</tr>
						</thead>
						<tbody>
							<cfoutput query="visits" maxrows="20">
								<cfif not isFriend(url.userid, source_id)>
									<tr>
										<td>#getLongname(source_id)#</td>
										<td>
											<cfif source_age GT 0>
												#source_age#
											<cfelse>
												Unknown
											</cfif>
										</td>
										<td>#dateFormat(visit_date, "d mmm yyyy")#</td>
									</tr>
								</cfif>
							</cfoutput>
						</tbody>
					</table>
					<small class="text-muted">Visitor Age represents the visitor's age at the time of the visit.</small>
				</div>
			</div> <!-- guestbook -->

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
											<cfset connection = "Client of">
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
							<h3 <cfif canWrite>onmouseenter="Prefiniti.showEditIcon('user-status');" onmouseleave="Prefiniti.hideEditIcon('user-status');"</cfif> id="user-status-view"><span id="user-status-content">#profile.status#</span> <span id="user-status-editicon" style="display: none;"><i <cfif canWrite>onclick="Prefiniti.beginEditingField('user-status');"</cfif> class="fa fa-edit edit-icon"></i></span></h3>
							<cfif canWrite>
								<input class="form-control mb-2" id="user-status-edit" type="text" style="display: none;">
							</cfif>
							<div class="btn-group float-right" role="group" aria-label="Friend Operations">
								<cfif canFriend>
									<button type="button" class="btn btn-light btn-sm" onclick="Prefiniti.requestFriend(#session.user.id#, #url.userid#);">Send Friend Request</button>
								</cfif>
								<cfif canUnfriend>
									<button type="button" class="btn btn-light btn-sm" onclick="Prefiniti.deleteFriend(#url.userid#);">Unfriend</button>
								</cfif>
								<cfif canMessage>
							  		<button type="button" class="btn btn-light btn-sm" onclick="mailTo(#profileUser.id#, '#profileUser.longName#');">Send Message</button>
							  	</cfif>
							  	<cfif canComment>
							  		<button type="button" class="btn btn-light btn-sm" onclick="Prefiniti.revealCommentBox('user-posts-form');">New Post</button>
								</cfif>
							</div>
						</div>
					</div>
				</div>
			</cfoutput>
			<hr>

			<cfif canComment>
				<div class="row">
					<div class="col-md-12">
						<cfmodule template="/socialnet/components/new_post_form.cfm" author_id="#session.user.id#" recipient_id="#url.userid#" post_class="USER" base_id="user-posts-form">						
					</div>
				</div>
			</cfif>
			
			<cfloop array="#posts#" item="post">
				<cfmodule template="/socialnet/components/view_post.cfm" id="#post.id#" base_id="user-posts-view">
			</cfloop>
			

		</div>
		
	</div>
</div>