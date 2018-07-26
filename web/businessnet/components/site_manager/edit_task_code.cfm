<cfquery name="getService" datasource="webwarecl">
    SELECT * FROM task_codes WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#url.id#">
</cfquery>
<cfoutput query="getService">
    <div class="modal-header">
        <i class="fa fa-list-alt modal-icon"></i>
        <h4 class="modal-title">Edit Service</h4>
        <small class="font-bold">This will allow you to edit service <em>#item#</em>.</small>
    </div>
    <div class="modal-body">
        <form id="edit-task-code" method="POST" action="/businessnet/components/site_manager/edit_task_code_sub.cfm">
            <input type="hidden" name="service_id" value="#id#">
            <div class="form-group row">
                <label class="col-lg-2 col-form-label">Service Name</label>
                <div class="col-lg-10">
                    <input name="item" class="form-control" placeholder="Service Name" value="#item#">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-lg-2 col-form-label">Accounting Code</label>
                <div class="col-lg-10">
                    <input name="task_id" class="form-control" placeholder="Accounting Code" value="#task_id#">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-lg-2 col-form-label">Billing</label>
                <div class="col-lg-10">
                    <div class="input-group">
                        <input name="rate" class="form-control" placeholder="Rate" value="#rate#">
                        <div class="input-group-append">
                            <select name="charge_type" class="custom-select">
                                <option value="Hour" <cfif charge_type EQ "Hour">selected</cfif>>Hour</option>
                                <option value="Day" <cfif charge_type EQ "Day">selected</cfif>>Day</option>
                                <option value="Week" <cfif charge_type EQ "Week">selected</cfif>>Week</option>
                                <option value="Month" <cfif charge_type EQ "Month">selected</cfif>>Month</option>
                                <option value="Quarter" <cfif charge_type EQ "Quarter">selected</cfif>>Quarter</option>
                                <option value="Year" <cfif charge_type EQ "Year">selected</cfif>>Year</option>
                                <option value="Image" <cfif charge_type EQ "Image">selected</cfif>>Image</option>
                                <option value="Job" <cfif charge_type EQ "Job">selected</cfif>>Job</option>
                                <option value="Sheet" <cfif charge_type EQ "Sheet">selected</cfif>>Sheet</option>
                                <option value="Unit" <cfif charge_type EQ "Unit">selected</cfif>>Unit</option>
                                <option value="Square Foot" <cfif charge_type EQ "Square Foot">selected</cfif>>Square Foot</option>
                                <option value="Acre" <cfif charge_type EQ "Acre">selected</cfif>>Acre</option>
                                <option value="Square Mile" <cfif charge_type EQ "Square Mile">selected</cfif>>Square Mile</option>
                            </select>                                
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-lg-12">
                            <input type="checkbox" name="billable" id="billable" <cfif billable EQ 1>checked</cfif>> <label for="billable">Billable</label>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="Prefiniti.submitForm('edit-task-code', Prefiniti.Business.dismiss);">Save Changes</button>
    </div>
</cfoutput>