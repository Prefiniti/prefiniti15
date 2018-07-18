<!--
<wwaftitle>Edit Employee Records</wwaftitle>
<wwafbreadcrumbs>Geodigraph PM,Edit Employee Records</wwafbreadcrumbs>
-->
<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="WW_SITEMAINTAINER">

<cfset prefiniti = new Prefiniti.Base()>
<cfset employeeRecord = prefiniti.getEmployeeRecord(url.id)>
<cfset employee = prefiniti.getUserByAssociationID(url.id)>

<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-4">
            <div class="ibox">
                <div class="ibox-content">
                    <div class="row m-b-lg">
                        <cfoutput>
                            <div class="col-lg-4 text-center">
                                <h2>#employee.longName#</h2>

                                <div class="m-b-sm">
                                    <img alt="image" class="rounded-circle" src="#employee.getPicture()#"
                                    style="width: 62px">
                                </div>
                            </div>
                            <div class="col-lg-8">
                                <strong>
                                    Status
                                </strong>

                                <p>#employee.status#</p>
                                <p>#prefiniti.getOnline(employee.id)#</p>

                                <div class="btn-group">
                                    <button type="button" class="btn btn-primary btn-sm" onclick="Prefiniti.Social.loadProfile(#employee.id#);"><i class="fa fa-user"></i> Profile</button>
                                    <button type="button" class="btn btn-primary btn-sm"><i
                                        class="fa fa-envelope"></i> Message
                                    </button>                
                                </div>
                            </div>
                        </cfoutput>
                    </div>
                    <cfoutput query="employeeRecord">
                        <div class="row m-b-lg">
                            <div class="col-lg-12">
                                <strong>Employee Information</strong>
                                <form id="edit-employee-record" method="POST" action="/businessnet/components/edit_employee_sub.cfm">
                                    <input type="hidden" name="assoc_id" value="#assoc_id#">
                                    <div class="form-group row">
                                        <label class="col-lg-3 col-form-label">Title</label>
                                        <div class="col-lg-9">
                                            <input type="text" name="title" id="title" class="form-control" value="#title#">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-lg-3 col-form-label">Application Date</label>
                                        <div class="col-lg-9">
                                            <input type="date" name="application_date" id="application_date" class="form-control" value="#dateFormat(application_date, 'yyyy-mm-dd')#">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-lg-3 col-form-label">Hire Date</label>
                                        <div class="col-lg-9">
                                            <input type="date" name="hire_date" id="hire_date" class="form-control" value="#dateFormat(hire_date, 'yyyy-mm-dd')#">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-lg-3 col-form-label">Status</label>
                                        <div class="col-lg-9">
                                            <select name="employment_status" id="employment_status" class="form-control" onchange="Prefiniti.Business.updateEmployeeForm();">
                                                <option value="Terminated" <cfif employment_status EQ "Terminated">selected</cfif>>Terminated</option>
                                                <option value="Active" <cfif employment_status EQ "Active">selected</cfif>>Active</option>
                                                <option value="Suspended (With Pay)" <cfif employment_status EQ "Suspended (With Pay)">selected</cfif>>Suspended (With Pay)</option>
                                                <option value="Suspended (Without Pay)" <cfif employment_status EQ "Suspended (Without Pay)">selected</cfif>>Suspended (Without Pay)</option>
                                                <option value="Sabbatical" <cfif employment_status EQ "Sabbatical">selected</cfif>>Sabbatical</option>
                                                <option value="Family Leave (Paid)" <cfif employment_status EQ "Family Leave (Paid)">selected</cfif>>Family Leave (Paid)</option>
                                                <option value="Family Leave (FMLA)" <cfif employment_status EQ "Family Leave (FMLA)">selected</cfif>>Family Leave (FMLA)</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div style="display: <cfif employment_status NEQ "Terminated">none<cfelse>block</cfif>;" id="termination-date-div">
                                        <div class="form-group row">
                                            <label class="col-lg-3 col-form-label">Termination Date</label>
                                            <div class="col-lg-9">
                                                <input type="date" name="termination_date" id="termination_date" class="form-control" value="#dateFormat(termination_date, 'yyyy-mm-dd')#">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-lg-3 col-form-label">Wage Basis</label>
                                        <div class="col-lg-9">
                                            <select name="wage_basis" id="wage_basis" class="form-control" onChange="Prefiniti.Business.updateEmployeeForm();">
                                                <option value="Hourly" <cfif wage_basis EQ "Hourly">selected</cfif>>Hourly</option>
                                                <option value="Salaried" <cfif wage_basis EQ "Salaried">selected</cfif>>Salaried</option>
                                                <option value="Contractor" <cfif wage_basis EQ "Contractor">selected</cfif>>Contractor</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-lg-3 col-form-label">Wage</label>
                                        <div class="col-lg-9">
                                            <input type="text" name="wage" id="wage" class="form-control" value="#wage#">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-lg-3 col-form-label">Payroll Frequency</label>
                                        <div class="col-lg-9">
                                            <select name="payroll_frequency" id="payroll_frequency" class="form-control" onChange="Prefiniti.Business.updateEmployeeForm();">
                                                <option value="Weekly" <cfif payroll_frequency EQ "Weekly">selected</cfif>>Weekly</option>
                                                <option value="Biweekly" <cfif payroll_frequency EQ "Biweekly">selected</cfif>>Biweekly</option>
                                                <option value="Semi-Monthly" <cfif payroll_frequency EQ "Semi-Monthly">selected</cfif>>Semi-Monthly</option>
                                                <option value="Monthly" <cfif payroll_frequency EQ "Monthly">selected</cfif>>Monthly</option>
                                                <option value="Per Job" <cfif payroll_frequency EQ "Per Job">selected</cfif>>Per Job</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label class="col-lg-3 col-form-label">Notes</label>
                                        <div class="col-lg-9">
                                            <textarea name="notes" class="form-control summernote">
                                                #notes#
                                            </textarea>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-lg-3 col-form-label">Application</label>
                                        <div class="col-lg-9">
                                            <textarea name="application" class="form-control summernote">
                                                #employeeRecord.application#
                                            </textarea>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-lg-3 col-form-label">Resume</label>
                                        <div class="col-lg-9">
                                            <textarea name="resume" class="form-control summernote">
                                                #resume#
                                            </textarea>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-lg-offset-2 col-lg-10">
                                            <button type="button" class="btn btn-primary" name="submit" onclick="Prefiniti.submitForm('edit-employee-record');">Save Changes</button>
                                        </div>
                                    </div>                                    
                                </form>
                            </div>
                        </div>
                    </cfoutput>
                </div>
            </div>
        </div>
        <div class="col-sm-8">
            <div class="ibox">
                <div class="ibox-content">

                </div>
            </div>
        </div>
    </div>
</div>