<cfset prefiniti = new Prefiniti.Base()>
<cfset templates = prefiniti.getProjectTemplates()>
<cfset clients = prefiniti.wwGetCustomersBySite(session.current_site_id)>


<div class="row m-b-lg">
    <div class="col-lg-12">
        <form id="create-new-project" method="POST" action="/pm/components/create_project_sub.cfm">
            <div class="form-group row">
                <label class="col-lg-3 col-form-label">Project Type</label>
                <div class="col-lg-9">
                    <select name="template_id" class="form-control">
                        <cfoutput query="templates">
                            <option value="#id#">#template_name#</option>
                        </cfoutput>
                    </select>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-lg-3 col-form-label">Client</label>
                <div class="col-lg-9">
                    <select name="client_assoc" class="form-control">
                        <cfoutput query="clients">
                            <cfset user = prefiniti.getUserByAssociationID(id)>
                            <option value="#id#">#user.longName#</option>
                        </cfoutput>
                    </select>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-lg-3 col-form-label">Project Name</label>
                <div class="col-lg-9">
                    <input type="text" name="project_name" class="form-control">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-lg-3 col-form-label">Start Date</label>
                <div class="col-lg-9">
                    <input type="date" name="project_start_date" class="form-control">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-lg-3 col-form-label">Due Date</label>
                <div class="col-lg-9">
                    <input type="date" name="project_due_date" class="form-control">
                </div>
            </div>
            <div class="form-group row">
                <div class="col-lg-12">
                    <strong>Description</strong>
                    <textarea class="form-control summernote" name="project_description">
                    </textarea>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-lg-offset-2 col-lg-10">
                    <button type="button" class="btn btn-primary" name="submit" onclick="Prefiniti.submitForm('create-new-project', Prefiniti.projectCreated);">Create Project</button>
                </div>
            </div>

        </form>
    </div>
</div>