<cfset project = new Prefiniti.ProjectManagement.Project(url.project_id)>
<cfif url.task_id NEQ 0>
    <cfset task = project.getTaskByID(url.task_id)>
</cfif>
<cfset taskCodes = project.getTaskCodes(session.current_site_id)>

<cfset dtRounded = round(now() * 24 * 4) / 24 / 4>

<cfset startDate = dateFormat(dtRounded, "yyyy-mm-dd")>
<cfset startHour = hour(dtRounded)>
<cfif startHour GT 12>
    <cfset startHour = startHour - 12>
</cfif>
<cfset startMinute = minute(dtRounded)>
<cfset startAMPM = timeFormat(dtRounded, "tt")>

<div class="modal-header">
    <i class="fa fa-clock modal-icon"></i>
    <h4 class="modal-title">Log Time</h4>
    <cfoutput>
        <cfif url.task_id NEQ 0>
            <small class="font-bold">This will log time worked on task <em>#task.task_name#</em>.</small>
        <cfelse>
            <small class="font-bold">This will log time worked on project <em>#project.project_name#</em>.</small>
        </cfif>
    </cfoutput>
</div>
<div class="modal-body">
    <cfoutput>
        <div class="row m-b-lg">
            <div class="col-lg-12">
                <form id="log-time" method="POST" action="/pm/components/add_time_entry_sub.cfm">
                    <input type="hidden" name="project_id" value="#url.project_id#">
                    <input type="hidden" name="task_id" value="#url.task_id#">
                    <cfif project.checkPermission(session.user.id, "TIME_APPROVE")>
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
                        <label class="col-lg-2 col-form-label">Work Performed:</label>
                        <div class="col-lg-10">
                            <div class="input-group">
                                <input type="text" id="work_performed" name="work_performed" class="form-control">
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
                        <label class="col-lg-2 col-form-label">Start Time:</label>
                        <div class="col-lg-10">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="input-group">
                                        <input type="date" name="start_date" class="form-control" value="#startDate#">
                                        <div class="input-group-append">                                        
                                            <select name="start_hour" class="custom-select">
                                                <cfloop from="1" to="12" index="hour">
                                                    <option value="#hour#" <cfif hour EQ startHour>selected</cfif>>#hour#</option>
                                                </cfloop>
                                            </select>
                                            <select name="start_minute" class="custom-select">
                                                <option value="00" <cfif startMinute EQ "00">selected</cfif>>00</option>
                                                <option value="15" <cfif startMinute EQ "15">selected</cfif>>15</option>
                                                <option value="30" <cfif startMinute EQ "30">selected</cfif>>30</option>
                                                <option vlaue="45" <cfif startMinute EQ "45">selected</cfif>>45</option>
                                            </select>
                                            <select name="start_ampm" class="custom-select">
                                                <option value="AM" <cfif startAMPM EQ "AM">selected</cfif>>AM</option>
                                                <option value="PM" <cfif startAMPM EQ "PM">selected</cfif>>PM</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-lg-12">
                                    <input type="checkbox" class="checkbox" id="time-open" name="time_open" onclick="Prefiniti.Projects.checkTimeOpen();"> 
                                    <label for="time-open">In Progress</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row" id="time-end-container">
                        <label class="col-lg-2 col-form-label">End Time:</label>
                        <div class="col-lg-10">
                            <div class="input-group">
                                <input type="date" name="end_date" class="form-control" value="#startDate#">                            
                                <div class="input-group-append">
                                    <select name="end_hour" class="custom-select">
                                        <cfloop from="1" to="12" index="hour">
                                            <option value="#hour#" <cfif hour EQ startHour>selected</cfif>>#hour#</option>
                                        </cfloop>
                                    </select>
                                    <select name="end_minute" class="custom-select">
                                        <option value="00" <cfif startMinute EQ "00">selected</cfif>>00</option>
                                        <option value="15" <cfif startMinute EQ "15">selected</cfif>>15</option>
                                        <option value="30" <cfif startMinute EQ "30">selected</cfif>>30</option>
                                        <option vlaue="45" <cfif startMinute EQ "45">selected</cfif>>45</option>
                                    </select>
                                    <select name="end_ampm" class="custom-select">
                                        <option value="AM" <cfif startAMPM EQ "AM">selected</cfif>>AM</option>
                                        <option value="PM" <cfif startAMPM EQ "PM">selected</cfif>>PM</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                                                     
                </form>
            </div>
        </div>
    </cfoutput>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-primary" name="submit" onclick="Prefiniti.submitForm('log-time', Prefiniti.Projects.itemCreated);">Log Time</button>
    <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>    
</div>
