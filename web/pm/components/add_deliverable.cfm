<cfset project = new Prefiniti.ProjectManagement.Project(url.id)>

<div class="modal-header">
    <i class="fa fa-list-alt modal-icon"></i>
    <h4 class="modal-title">Add Deliverable</h4>
    <cfoutput>
        <small class="font-bold">This will add a new deliverable to project <em>#project.project_name#</em>.<br>A <em>deliverable</em> is a file that will be delivered to a project stakeholder.</small>
    </cfoutput>
</div>
<div class="modal-body">
    <cfoutput>
        <div class="row m-b-lg">
            <div class="col-lg-12">
                <form id="add-deliverable" method="POST" action="/pm/components/add_deliverable_sub.cfm">
                    <input type="hidden" name="project_id" value="#url.id#">
                    <div class="form-group row">
                        <label class="col-lg-2 col-form-label">Name</label>
                        <div class="col-lg-10">
                            <input type="text" id="deliverable_name" name="deliverable_name" class="form-control">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-lg-2 col-form-label">File</label>
                        <div class="col-lg-10">
                            <cfmodule template="/contentManager/components/cms_picker.cfm" element_name="deliverable_file_id" height="200">
                        </div>
                    </div>                       
                </form>
            </div>
        </div>
    </cfoutput>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
    <button type="button" class="btn btn-primary" name="submit" onclick="Prefiniti.submitForm('add-deliverable', Prefiniti.Projects.itemCreated);">Add Deliverable</button>
</div>
