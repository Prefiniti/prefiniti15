function doUpload()
{
	window.open("","uploadStatusWindow","width=420,height=220,toolbar=0"); 
    var a = window.setTimeout("document.uploadFile.submit();",500)
}

function updateFileList(project_id)
{
	/* /contentManager/components/fileList.cfm */
	//alert('updateFileList() called.');
	AjaxLoadPageToDiv('fileList', 'http://www.webwarecl.com/contentManager/components/fileList.cfm?id=' + project_id);
	showDivC('fileList');
}

function viewFile(path)
{
	window.open(path,"fileViewWindow","width=1000,height=700,toolbar=0,menubar=1,scrollbars=1"); 
}

function deleteFile(path, projectID, fileID)
{
		var url;
		url = '/contentManager/components/fileDeleteConfirm.cfm?path=' + escape(path);
		url += '&projectID=' + escape(projectID);
		url += '&fileID=' + escape(fileID);
		
		AjaxLoadPageToDiv('tcTarget', url);
}

function doDelete(path, fileID, projectID)
{
		var url;
		url = '/contentManager/components/fileDeleteSubmit.cfm?path=' + escape(path);
		url += '&fileID=' + escape(fileID);
		url += '&projectID=' + escape(projectID);
		
		AjaxLoadPageToDiv('tcTarget', url);
}

function showFileBrowser(userid, projectID) 
{
	var url;
	url = '/contentManager/components/fileBrowser.cfm?clientid=' + escape(userid);
	
	if (projectID != 0) {
		url += '&projectID=' + escape(projectID);
	}
	
	
	
	showDiv('browserWrapper');
	AjaxLoadPageToDiv('browserWrapper', url);
}

function getFileList(projectid)
{
	var url;
	url = "/contentManager/components/fileListByProject.cfm?projectid=" + escape(projectid);
	url += "&sortorder=filePath&direction=ASC";
	AjaxLoadPageToDiv('projectList', url);
}

function getFileListSorted(projectid, sortorder)
{
	var url;
	url = "/contentManager/components/fileListByProject.cfm?projectid=" + escape(projectid);
	url += "&sortorder=" + escape(sortorder);
	url += "&direction=ASC";
	AjaxLoadPageToDiv('projectList', url);
}

function doPreview(filePath, fileID)
{
	var url;
	url = "/contentManager/components/autoPreview.cfm?filePath=" + escape(filePath);
	url += "&fileid=" + escape(fileID);
	
	SetInnerHTML('curFile', '<strong>' + filePath + '</strong>');
	SetValue('fid', filePath);
	AjaxLoadPageToDiv('picture', url);
	
}

function uploadSurveyMap(id)
{
	var url;
	url = "/contentManager/components/surveyMapUpload.cfm?subdivisionID=" + escape(id);
	
	AjaxLoadPageToDiv('tcTarget', url);
}

function copyFile(src_name, src_dir, src_id, tgt_dir, tgt_id, t_div)
{
	var url;
	url = "/contentManager/components/fileCopy.cfm?src_name=" + escape(src_name);
	url += "&src_dir=" + escape(src_dir);
	url += "&src_id=" + escape(src_id);
	url += "&tgt_dir=" + escape(tgt_dir);
	url += "&tgt_id=" + escape(tgt_id);
	
	AjaxLoadPageToDiv(t_div, url);
}

function getUploader(filter, filter_description, max_files, post_target)
{
	var tmp;
// Check to see if SWFUpload is available
	if (typeof(SWFUpload) === "undefined") return(null);

	// Instantiate a SWFUpload Instance
	tmp = new SWFUpload({
		// Backend Settings
		upload_url: post_target,	// I can pass query strings here if I want
		
		// File Upload Settings
		file_size_limit : "102400",	// 100MB
		file_types : filter,
		file_types_description : filter_description,
		file_upload_limit : max_files,

		// Flash Settings
		flash_url : "/contentManager/swfupload.swf",	// Relative to this file

		// UI Settings
		ui_container_id : "stdUpload",		
		degraded_container_id : "degUpload",
		
		file_dialog_start_handler : fileDialogStart,
		file_queued_handler : fileQueued,
		file_queue_error_handler : fileQueueError,
		file_dialog_complete_handler : fileDialogComplete,
		upload_start_handler : uploadStart,
		upload_progress_handler : uploadProgress,
		upload_error_handler : uploadError,
		upload_complete_handler : uploadComplete,
		file_complete_handler : fileComplete,
		
		// Debug Settings
		debug: false		// For the purposes of this demo I wan't debug info shown
	});	
	
	tmp.customSettings.progressTarget = "ulProgress";
	tmp.customSettings.cancelButtonId = "cancelFUpload";
	return(tmp);
}


/*glob_uploader = getUploader('*.*', 'All Files', 10, '/contentmanager/components/process_upload.cfm?mode=yay');*/
/*filter, filter_description, max_files, post_target)*/
function cmsPrepareUploader(filter, filter_description, mode, site_id, user_id, basedir, subdir)
{
	var url;
	url = '/contentmanager/components/process_upload.cfm?mode=' + escape(mode);
	url += '&site_id=' + escape(site_id);
	url += '&user_id=' + escape(user_id);
	url += '&basedir=' + escape(basedir);
	url += '&subdir=' + escape(subdir);
	
	//url += '&user_id_n=' + glob_userid;
	
	showDiv('browseButton');
	
	glob_uploader = getUploader(filter, filter_description, 10, url);
	//glob_uploader.selectFiles();
}

function cmsBrowseFolder(user_id, basedir, subdir, mode, search_criteria)
{
	var url;
	
	url = '/contentmanager/components/cms_browse.cfm?user_id=' + escape(user_id);
	url += '&basedir=' + escape(basedir);
	url += '&mode=' + escape(mode);
	url += '&subdir=' + escape(subdir);
	url += '&search_criteria=' + escape(search_criteria);
	
	if(mode == "site")
	{
		url += '&site_id=' + escape(glob_current_site_id);
	}
	
	
	AjaxLoadPageToDiv('tcTarget', url);
}

function cmsDlgAddAssociation(file_id, file_name, mode)
{
	var url;
	url = '/contentmanager/components/cms_add_association.cfm?file_id=' + escape(file_id);
	url += '&file_name=' + escape(file_name);
	url += '&mode=' + escape(mode);
	
	AjaxLoadPageToDiv('fsa_module', url);
	showDiv('fsa_dialog');
}

function cmsAddAssociation(file_id, project_id, scope, description, releasable)
{
	var url;
	url = '/contentmanager/components/cms_add_association_sub.cfm?file_id=' + escape(file_id);
	url += '&project_id=' + escape(project_id);
	if (scope == "user") {
		url += '&assoc_type=0';
	}
	else {
		url += '&assoc_type=1';
	}
	url += '&description=' + escape(description);
	if (releasable == true) {
		url += '&releasable=1';
	}
	else {
		url += '&releasable=0';
	}
	
	AjaxNullRequest(url);
	hideDiv('fsa_dialog');
}

var last_selected=null;

function cmsSelectFile(id, mode, hideDelete)
{
	var cline;
	var lineRef;
	
	cline = "fileLine_" + id.toString();
	lineRef = AjaxGetElementReference(cline);	
	
	lineRef.style.backgroundColor = "#C0C0C0";
	if (last_selected != null) {
		last_selected.style.backgroundColor = "#EFEFEF";
	}
	last_selected = lineRef;
	
	if (mode == "user") {
		showDiv('cms_send_file');
	}
	else {
		hideDiv('cms_send_file');
	}
	
	
	
	if (hideDelete) {
		hideDiv('cms_delete_file');
	}
	else {
		showDiv('cms_delete_file');
	}
	
	SetValue('current_mode', mode);
	SetValue('selected_file_id', id);
	showDiv('file_action');
}

function cmsViewFile(file_id, mode)
{
	window.open('/contentmanager/components/cms_view_file.cfm?file_id=' + escape(file_id) + '&mode=' + escape(mode) + '&site_id=' + glob_current_site_id);
}

function cmsDeleteFile(file_id, mode)
{
	var ans;
	ans = confirm('Are you sure you wish to delete this file?');
	
	if (ans)
	{
		var url;
		url = '/contentmanager/components/cms_file_delete.cfm?file_id=' + escape(file_id);
		url += "&mode=" + escape(mode);
		AjaxNullRequest(url);
		
		hideDiv('fileLine_' + file_id.toString());
	}
}

function cmsRenameFile(file_id, mode, new_name)
{
	var url;
	url = '/contentmanager/components/cms_file_rename.cfm?file_id=' + escape(file_id);
	url += '&mode=' + escape(mode);
	url += '&new_name=' + escape(new_name);
	
	AjaxNullRequest(url);
}

function cmsDescribeFile(file_id, mode, description)
{
	var url;
	url = '/contentmanager/components/cms_file_describe.cfm?file_id=' + escape(file_id);
	url += '&mode=' + escape(mode);
	url += '&description=' + escape(description);
	
	AjaxNullRequest(url);		
}

function cmsLoadMiniBrowser(file_id_target, name_target)
{
	var url;
	url = '/contentmanager/components/cms_minibrowser.cfm?file_id_target=' + escape(file_id_target);
	url += '&name_target=' + escape(name_target);
	
	AjaxLoadPageToDiv('cms_minibrowser_area', url);
	showDiv('cms_minibrowser');
}

function cmsMiniBrowserPick(file_id_target, name_target, file_id, filename)
{
	SetValue(file_id_target, file_id);
	SetValue(name_target, filename);
	
	hideDiv('cms_minibrowser');
}
	