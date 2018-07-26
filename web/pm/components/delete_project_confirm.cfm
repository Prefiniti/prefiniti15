<cfset project = new Prefiniti.ProjectManagement.Project(url.project_id)>

<div class="modal-header">
    <i class="fa fa-trash-alt modal-icon"></i>
    <h4 class="modal-title">Delete Project</h4>
    <small class="font-bold">Deleting a project <span class="text-danger">cannot be undone</span>!</small>

</div>
<div class="modal-body">
    <p class="text-danger font-bold">Deleting a project CANNOT BE UNDONE!</p>

    <p>You must type the word DELETE in the text field below in order to confirm deletion of project <cfoutput><strong>#project.project_name#</strong></cfoutput>.</p>

    <input type="text" class="form-control" id="project-delete-confirm">
    
</div>
<div class="modal-footer">    
    <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
    <cfoutput>
        <button type="button" class="btn btn-danger" onclick="Prefiniti.Projects.checkConfirmDelete(#url.project_id#);">Delete Project</button>
    </cfoutput>
</div>