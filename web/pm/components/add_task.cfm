<div class="modal-header">
    <h4 class="modal-title">Add Task</h4>
</div>
<div class="modal-body">
    <cfoutput>
        <div class="row m-b-lg">
            <div class="col-lg-12">
                <form id="add-task" method="POST" action="/pm/components/add_task_sub.cfm">
                    <input type="hidden" name="project_id" value="#url.id#">
                    <div class="form-group row">
                        <label class="col-lg-2 col-form-label">Task Name</label>
                        <div class="col-lg-10">
                            <input type="text" id="task_name" name="task_name" class="form-control">
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
