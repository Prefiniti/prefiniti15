// JavaScript Document

function requestFriend(id)
{
	var url;
	var theDiv;
	theDiv = 'frBlock_' + id.toString();
	
	url = '/socialnet/components/request_friend.cfm?id=' + escape(id);
	
	AjaxSilentLoad(theDiv, url);
}

function acceptFriend(req_id)
{
	var url;
	url = '/socialnet/components/accept_friend.cfm?req_id=' + escape(req_id);
	
	var theDiv;
	theDiv = 'frBlock_' + req_id.toString();
	
	AjaxSilentLoad(theDiv, url);
}

function rejectFriend(req_id)
{
	var url;
	url = '/socialnet/components/reject_friend.cfm?req_id=' + escape(req_id);
	
	var theDiv;
	theDiv = 'frBlock_' + req_id.toString();
	
	AjaxSilentLoad(theDiv, url);
}

function confirmDeleteFriend(fromid, toid)
{
	var url;
	url = '/socialnet/components/delete_friend.cfm?from_id=' + escape(fromid);
	url += '&to_id=' + escape(toid);
	
	AjaxLoadPageToDiv('tcTarget', url);
}

function deleteFriend(fromid, toid)
{
	var url;
	url = '/socialnet/components/delete_friend_sub.cfm?from_id=' + escape(fromid);
	url += '&to_id=' + escape(toid);
	
	AjaxLoadPageToDiv('tcTarget', url);
}

function viewPictures(user_id, allow_edit)
{
	var url;
	url = '/socialnet/components/view_pictures.cfm?user_id=' + escape(user_id);
	url += '&allow_edit=' + escape(allow_edit);
	
	AjaxLoadPageToDiv('tcTarget', url);
}

function deleteProfilePicture(full_path, shown_div)
{
	var url;
	url = '/socialnet/components/delete_picture.cfm?full_path=' + escape(full_path);
	
	AjaxNullRequest(url);
	
	hideDiv(shown_div);
}

function setProfilePicture(user_id, filename)
{
	var url;
	url = '/socialnet/components/set_profile_picture.cfm?user_id=' + escape(user_id);
	url += '&filename=' + escape(filename);
	
	$.get(url)
	.done(function(data) {
		var picUrl = '/socialnet/components/default_pic.cfm?user_id=' + escape(user_id);

		$.get(picUrl)
		.done(function(data) {
			$("#profile-photo").html(data);
		});
	});

}

function viewSiteProfile(site_id)
{
	var url;
	url = "/socialnet/components/view_site_profile.cfm?site_id=" + escape(site_id);
	
	AjaxLoadPageToDiv('tcTarget', url);
}