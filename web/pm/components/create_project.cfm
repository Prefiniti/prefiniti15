<cfset prefiniti = new Prefiniti.Base()>
<cfset templates = prefiniti.getProjectTemplates()>
<cfset clients = prefiniti.wwGetCustomersBySite(session.current_site_id)>

<cfif isDefined("url.client_assoc_id")>
    <cfset selectedUser = prefiniti.getUserByAssociationID(url.client_assoc_id)>
</cfif>

<div class="modal-header">
    <i class="fa fa-project-diagram modal-icon"></i>
    <h4 class="modal-title">Create New Project</h4>
</div>
<div class="modal-body">
    <div class="row m-b-lg">
        <div class="col-lg-12">
            <form id="create-new-project" method="POST" action="/pm/components/create_project_sub.cfm">
                <div class="form-group row">
                    <label class="col-lg-2 col-form-label">Project Type</label>
                    <div class="col-lg-10">
                        <select name="template_id" class="form-control">
                            <option value="0" selected>Blank Project</option>
                            <cfoutput query="templates">                                
                                <option value="#id#">#template_name#</option>
                            </cfoutput>
                        </select>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-lg-2 col-form-label">Client</label>
                    <div class="col-lg-10">
                        <input type="checkbox" class="checkbox" id="internal-project" name="internal_project" onclick="Prefiniti.Projects.internalProjectClicked();">  <label for="internal-project">Internal Project</label>
                        <select name="client_assoc" class="form-control" id="client_assoc">
                            <cfif isDefined("selectedUser")>
                                <cfoutput>
                                    <option value="#url.client_assoc_id#" selected>#selectedUser.longName#</option>
                                </cfoutput>
                                <cfoutput query="clients">
                                    <cfset user = prefiniti.getUserByAssociationID(id)>
                                    <cfif id NEQ url.client_assoc_id>
                                        <option value="#id#">#user.longName#</option>                            
                                    </cfif>
                                </cfoutput>
                            <cfelse>
                                <cfoutput query="clients">
                                    <cfset user = prefiniti.getUserByAssociationID(id)>
                                    <option value="#id#">#user.longName#</option>                            
                                </cfoutput>
                            </cfif>                        
                        </select>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-lg-2 col-form-label">Project Name</label>
                    <div class="col-lg-10">
                        <div class="input-group">
                            <input type="text" name="project_name" class="form-control">
                            <div class="input-group-append">
                                <select name="project_priority" class="custom-select">
                                    <option value="0">Low Priority</option>
                                    <option value="1" selected>Medium Priority</option>
                                    <option value="2">High Priority</option>
                                    <option value="3">Critical</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-lg-2 col-form-label">Start &amp; End Dates</label>
                    <div class="col-lg-5">
                        <input type="date" name="project_start_date" class="form-control">
                    </div>
                    <div class="col-lg-5">
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
            </form>
        </div>
    </div>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
    <button type="button" class="btn btn-primary" name="submit" onclick="Prefiniti.submitForm('create-new-project', Prefiniti.Projects.itemCreated);">Create Project</button>
</div>