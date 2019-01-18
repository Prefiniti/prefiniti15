<cfset prefiniti = new Prefiniti.Base()>
<cfset templates = prefiniti.getProjectTemplates()>
<cfset clients = prefiniti.wwGetCustomersBySite(session.current_site_id)>

<cfset project = new Prefiniti.ProjectManagement.Project(url.id)>

<cfif project.client_assoc EQ project.employee_assoc>
    <cfset internalProject = true>
<cfelse>
    <cfset internalProject = false>
</cfif>

<cfset startDate = dateFormat(project.project_start_date, "yyyy-mm-dd")>
<cfset endDate = dateFormat(project.project_due_date, "yyyy-mm-dd")>

<div class="modal-header">
    <i class="fa fa-project-diagram modal-icon"></i>
    <h4 class="modal-title">Edit Project</h4>
</div>
<div class="modal-body">
    <div class="row m-b-lg">
        <div class="col-lg-12">
            <form id="edit-project" method="POST" action="/pm/components/edit_project_sub.cfm"> 
                <cfoutput>               
                    <input type="hidden" name="project_id" id="project-id" value="#url.id#">
                </cfoutput>
                <div class="form-group row">
                    <label class="col-lg-2 col-form-label">Client</label>
                    <div class="col-lg-10">
                        <input type="checkbox" class="checkbox" id="internal-project" name="internal_project" onclick="Prefiniti.Projects.internalProjectClicked();">  <label for="internal-project" <cfif internalProject EQ true>checked</cfif>>Internal Project</label>
                        <select name="client_assoc" class="form-control" id="client_assoc" <cfif internalProject EQ true>style="display: none;"</cfif>>                           
                            <cfoutput query="clients">
                                <cfset user = prefiniti.getUserByAssociationID(id)>
                                <option value="#id#" <cfif id EQ project.client_assoc>selected</cfif>>#user.longName#</option>                            
                            </cfoutput>                                                  
                        </select>
                    </div>
                </div>
                <cfoutput>
                    <div class="form-group row">
                        <label class="col-lg-2 col-form-label">Project Name</label>
                        <div class="col-lg-10">
                            <div class="input-group">
                                <input type="text" name="project_name" class="form-control" value="#project.project_name#">
                                <div class="input-group-append">
                                    <select name="project_priority" class="custom-select">
                                        <option value="0" <cfif project.project_priority EQ 0>selected</cfif>>Low Priority</option>
                                        <option value="1" <cfif project.project_priority EQ 1>selected</cfif>>Medium Priority</option>
                                        <option value="2" <cfif project.project_priority EQ 2>selected</cfif>>High Priority</option>
                                        <option value="3" <cfif project.project_priority EQ 3>selected</cfif>>Critical</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-lg-2 col-form-label">Start &amp; End Dates</label>
                        <div class="col-lg-5">
                            <cfoutput>
                                <input type="date" name="project_start_date" class="form-control" value="#startDate#">
                            </cfoutput>
                        </div>
                        <div class="col-lg-5">
                            <cfoutput>
                                <input type="date" name="project_due_date" class="form-control" value="#endDate#">
                            </cfoutput>
                        </div>
                    </div>                
                    <div class="form-group row">
                        <div class="col-lg-12">
                            <strong>Description</strong>
                            <textarea class="form-control" name="project_description">#project.project_description#</textarea>
                        </div>
                    </div>     
                </cfoutput>       
            </form>
        </div>
    </div>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
    <button type="button" class="btn btn-primary" name="submit" onclick="Prefiniti.submitForm('edit-project', Prefiniti.Projects.itemCreated);">Save Changes</button>
</div>