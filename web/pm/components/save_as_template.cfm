<cfset project = new Prefiniti.ProjectManagement.Project(url.id)>
<cfset prefiniti = new Prefiniti.Base()>

<div class="modal-header">
    <i class="fa fa-file-signature modal-icon"></i>
    <h4 class="modal-title">Save Template</h4>
    <cfoutput>
        <p><small class="font-bold">This will create a named template, including the tasks and deliverables from project <em>#project.project_name#</em>.<br>Once this template is saved, you will be able to create new projects with the same set of tasks and deliverables as this one in one step.</small></p>
        <p><small class="font-bold">Your new template will be accessible by anyone from #prefiniti.getSiteNameByID(session.current_site_id)#.</small> 
    </cfoutput>
</div>
<div class="modal-body">
    <cfoutput>
        <div class="row m-b-lg">
            <div class="col-lg-12">
                <form id="save-as-template" method="POST" action="/pm/components/save_as_template_sub.cfm">
                    <input type="hidden" name="project_id" value="#url.id#">
                    <div class="form-group row">
                        <label class="col-lg-2 col-form-label">Template Name:</label>
                        <div class="col-lg-10">
                            <input type="text" id="template_name" name="template_name" class="form-control">
                        </div>
                    </div>                                                        
                </form>
            </div>
        </div>
    </cfoutput>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-primary" name="submit" onclick="Prefiniti.submitForm('save-as-template', Prefiniti.Projects.taskAdded);">Save Template</button>
    <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>    
</div>
