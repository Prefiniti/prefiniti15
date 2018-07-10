<cfset project = new Prefiniti.ProjectManagement.Project(url.id)>

<div class="modal-header">
    <i class="fa fa-list-alt modal-icon"></i>
    <h4 class="modal-title">Add Task</h4>
    <cfoutput>
        <small class="font-bold">This will add a new task to project <em>#project.project_name#</em>.</small>
    </cfoutput>
</div>
<div class="modal-body">
    <cfoutput>
        <div class="row m-b-lg">
            <div class="col-lg-12">
                <form id="add-task" method="POST" action="/pm/components/add_task_sub.cfm">
                    <input type="hidden" name="project_id" value="#url.id#">
                    <div class="form-group row">
                        <label class="col-lg-2 col-form-label">Task Name:</label>
                        <div class="col-lg-10">
                            <div class="input-group">
                                <input type="text" id="task_name" name="task_name" class="form-control">
                                <div class="input-group-append">
                                    <select name="task_priority" class="custom-select">
                                        <option value="Wish List">Wish List</option>
                                        <option value="Low">Low Priority</option>
                                        <option value="Medium">Medium Priority</option>
                                        <option value="Normal" selected>Normal Priority</option>
                                        <option value="High">High Priority</option>
                                        <option value="Critical">Critical</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div> 

                    <div class="form-group row">                                       
                        <label class="col-lg-2 col-form-label">Assign To:</label>
                        <div class="col-lg-10">
                            <cfmodule template="/businessnet/components/user_picker.cfm" height="200" element_name="assignee_assoc_id">
                        </div>
                    </div>                      
                </form>
            </div>
        </div>
    </cfoutput>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
    <button type="button" class="btn btn-primary" name="submit" onclick="Prefiniti.submitForm('add-task', Prefiniti.Projects.itemCreated);">Add Task</button>
</div>
