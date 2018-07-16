<cfset project = new Prefiniti.ProjectManagement.Project(url.project_id)>
<cfif url.task_id NEQ 0>
    <cfset task = project.getTaskByID(url.task_id)>
</cfif>
<cfset taskCodes = project.getTaskCodes(session.current_site_id)>


<div class="modal-header">
    <i class="fa fa-car modal-icon"></i>
    <h4 class="modal-title">Log Travel</h4>
    <cfoutput>
        <cfif url.task_id NEQ 0>
            <small class="font-bold">This will log travel miles for task <em>#task.task_name#</em>.</small>
        <cfelse>
            <small class="font-bold">This will log travel miles on project <em>#project.project_name#</em>.</small>
        </cfif>
    </cfoutput>
</div>
<div class="modal-body">
    <cfoutput>
        <div class="row m-b-lg">
            <div class="col-lg-12">
                <form id="log-travel" method="POST" action="/pm/components/add_travel_entry_sub.cfm">
                    <input type="hidden" name="project_id" value="#url.project_id#">
                    <input type="hidden" name="task_id" value="#url.task_id#">
                    <cfif project.checkPermission(session.user.id, "TRAVEL_APPROVE")>
                        <cfset stakeholders = project.getStakeholders()>
                        <div class="form-group row">
                            <label class="col-lg-2 col-form-label">Stakeholder:</label>
                            <div class="col-lg-10">
                                <select class="custom-select" name="assoc_id">
                                    <cfloop array="#stakeholders#" item="stakeholder">
                                        <option value="#stakeholder.assoc_id#" <cfif stakeholder.assoc_id EQ session.current_association>selected</cfif>>#stakeholder.user.longName# (#stakeholder.type#)</option>
                                    </cfloop>
                                </select>
                            </div>
                        </div>
                    <cfelse>
                        <input type="hidden" name="assoc_id" value="#session.current_association#">
                    </cfif>
                    <div class="form-group row">
                        <label class="col-lg-2 col-form-label">Travel Reason:</label>
                        <div class="col-lg-10">
                            <div class="input-group">
                                <input type="text" id="travel_name" name="travel_name" class="form-control">
                                <div class="input-group-append">
                                    <select name="task_code_id" class="custom-select">
                                        <cfoutput query="taskCodes">
                                            <option value="#id#">#item#</option>
                                        </cfoutput>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div> 
                    <div class="form-group row">
                        <label class="col-lg-2 col-form-label">Travel Date:</label>
                        <div class="col-lg-10">
                            <input type="date" name="travel_date" class="form-control">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-lg-2 col-form-label">Odometer Start:</label>
                        <div class="col-lg-10">
                            <input type="text" name="odometer_start" class="form-control">
                        </div>
                    </div> 
                    <div class="form-group row">
                        <label class="col-lg-2 col-form-label">Odometer End:</label>
                        <div class="col-lg-10">
                            <input type="text" name="odometer_end" class="form-control">
                        </div>
                    </div>                                                     
                </form>
            </div>
        </div>
    </cfoutput>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-primary" name="submit" onclick="Prefiniti.submitForm('log-travel', Prefiniti.Projects.itemCreated);">Log Travel</button>
    <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>    
</div>
