<cfset project = new Prefiniti.ProjectManagement.Project(url.project_id)>
<cfset task = project.getTaskByID(url.id)>

<div class="modal-header">
    <i class="fa fa-user-edit modal-icon"></i>
    <h4 class="modal-title">Assign Task</h4>
    <cfoutput>
        <small class="font-bold">This will allow you to assign or reassign a stakeholder to <em>#task.task_name#</em>.</small>
    </cfoutput>
</div>
<div class="modal-body">
    <cfoutput>
        <div class="row m-b-lg">
            <div class="col-lg-12">
                <form id="add-task" method="POST" action="/pm/components/reassign_task_sub.cfm">
                    <input type="hidden" name="project_id" value="#url.project_id#">                    
                    <input type="hidden" name="task_id" value="#url.id#">
                    <div class="form-group row">                                       
                        <label class="col-lg-2 col-form-label">Assign To:</label>
                        <div class="col-lg-10">
                            <cfmodule template="/businessnet/components/user_picker.cfm" height="150" element_name="assignee_assoc_id">
                        </div>
                    </div>                                         
                </form>
            </div>
        </div>
    </cfoutput>
</div>
<div class="modal-footer">    
    <button type="button" class="btn btn-primary" name="submit" onclick="Prefiniti.submitForm('add-task', Prefiniti.Projects.taskAdded);">Assign Task</button>
    <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
</div>
