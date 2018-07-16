<cfset project = new Prefiniti.ProjectManagement.Project(url.project_id)>
<cfset deliverable = project.getDeliverableByID(url.id)>

<div class="modal-header">
    <i class="fa fa-upload modal-icon"></i>
    <h4 class="modal-title"><cfoutput>#url.caption#</cfoutput></h4>
    <cfoutput>
        <small class="font-bold">This will modify deliverable <em>#deliverable.deliverable_name#</em> within project <em>#project.project_name#</em>.</small>
    </cfoutput>
</div>
<div class="modal-body">
    <cfoutput>
        <div class="row m-b-lg">
            <div class="col-lg-12">
                <form id="add-deliverable" method="POST" action="/pm/components/upload_deliverable_sub.cfm">
                    <input type="hidden" name="project_id" value="#project.id#">
                    <input type="hidden" name="deliverable_id" value="#deliverable.id#">
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
    <button type="button" class="btn btn-primary" name="submit" onclick="Prefiniti.submitForm('add-deliverable', Prefiniti.Projects.itemCreated);"><cfoutput>#url.caption#</cfoutput></button>
</div>
