<cfset project = new Prefiniti.ProjectManagement.Project(url.project_id)>

<cfset taskCodes = project.getTaskCodes(session.current_site_id)>

<cfset timeEntry = project.getTimeEntryByID(url.id)>

<cfset dtRounded = round(timeEntry.start_time * 24 * 4) / 24 / 4>

<cfset startDate = dateFormat(dtRounded, "yyyy-mm-dd")>
<cfset startHour = hour(dtRounded)>
<cfif startHour GT 12>
    <cfset startHour = startHour - 12>
</cfif>
<cfset startMinute = minute(dtRounded)>
<cfset startAMPM = timeFormat(dtRounded, "tt")>

<cfset dtRounded = round(timeEntry.end_time * 24 * 4) / 24 / 4>

<cfset endDate = dateFormat(dtRounded, "yyyy-mm-dd")>
<cfset endHour = hour(dtRounded)>
<cfif endHour GT 12>
    <cfset endHour = endHour - 12>
</cfif>
<cfset endMinute = minute(dtRounded)>
<cfset endAMPM = timeFormat(dtRounded, "tt")>

<div class="modal-header">
    <i class="fa fa-clock modal-icon"></i>
    <h4 class="modal-title">Edit Time Log Entry</h4>
</div>
<div class="modal-body">
    <cfoutput>
        <div class="row m-b-lg">
            <div class="col-lg-12">
                <form id="log-time" method="POST" action="/pm/components/edit_time_entry_sub.cfm">
                    <input type="hidden" name="id" value="#url.id#">
                    <input type="hidden" name="project_id" value="#url.project_id#">                   
                    <cfif project.checkPermission(session.user.id, "TIME_APPROVE")>
                        <cfset stakeholders = project.getStakeholders()>
                        <div class="form-group row">
                            <label class="col-lg-2 col-form-label">Stakeholder:</label>
                            <div class="col-lg-10">
                                
                                <select class="custom-select" name="assoc_id">
                                    <cfloop array="#stakeholders#" item="stakeholder">
                                        <option value="#stakeholder.assoc_id#" <cfif stakeholder.assoc_id EQ timeEntry.assoc_id>selected</cfif>>#stakeholder.user.longName# (#stakeholder.type#)</option>
                                    </cfloop>
                                </select>
                            </div>
                        </div>
                    <cfelse>
                        <input type="hidden" name="assoc_id" value="#timeEntry.assoc_id#">
                    </cfif>
                    <div class="form-group row">
                        <label class="col-lg-2 col-form-label">Work Performed:</label>
                        <div class="col-lg-10">
                            <div class="input-group">
                                <input type="text" id="work_performed" name="work_performed" class="form-control" value="#timeEntry.work_performed#">
                                <div class="input-group-append">
                                    <select name="task_code_id" class="custom-select">
                                        <cfoutput query="taskCodes">
                                            <option value="#id#" <cfif id EQ timeEntry.task_code_id>selected</cfif>>#item#</option>
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
                        </div>
                    </div>
                    <cfif timeEntry.closed EQ 1>
                        <div class="form-group row" id="time-end-container">
                            <label class="col-lg-2 col-form-label">End Time:</label>
                            <div class="col-lg-10">
                                <div class="input-group">
                                    <input type="date" name="end_date" class="form-control" value="#startDate#">                            
                                    <div class="input-group-append">
                                        <select name="end_hour" class="custom-select">
                                            <cfloop from="1" to="12" index="hour">
                                                <option value="#hour#" <cfif hour EQ endHour>selected</cfif>>#hour#</option>
                                            </cfloop>
                                        </select>
                                        <select name="end_minute" class="custom-select">
                                            <option value="00" <cfif endMinute EQ "00">selected</cfif>>00</option>
                                            <option value="15" <cfif endMinute EQ "15">selected</cfif>>15</option>
                                            <option value="30" <cfif endMinute EQ "30">selected</cfif>>30</option>
                                            <option vlaue="45" <cfif endMinute EQ "45">selected</cfif>>45</option>
                                        </select>
                                        <select name="end_ampm" class="custom-select">
                                            <option value="AM" <cfif endAMPM EQ "AM">selected</cfif>>AM</option>
                                            <option value="PM" <cfif endAMPM EQ "PM">selected</cfif>>PM</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </cfif>                                            
                </form>
            </div>
        </div>
    </cfoutput>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-primary" name="submit" onclick="Prefiniti.submitForm('log-time', Prefiniti.Projects.itemCreated);">Save Changes</button>
    <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>    
</div>
