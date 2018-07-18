<div class="modal-header">
    <i class="fa fa-user-plus modal-icon"></i>
    <h4 class="modal-title">Add Employee</h4>
    <cfoutput>
        <small class="font-bold">This will add a new employee to your company.</small>
    </cfoutput>
</div>
<div class="modal-body">
    <cfoutput>
        <div class="row m-b-lg">
            <div class="col-lg-12">
                <form id="add-employee" method="POST" action="/businessnet/components/add_employee_sub.cfm">
                    <input type="hidden" name="new_account" id="employee-new-account" value="0">
                    <div class="form-group row">
                        <label class="col-lg-2 col-form-label">E-Mail Address:</label>
                        <div class="col-lg-10">
                            <input type="email" id="employee-email" name="email" class="form-control" onblur="Prefiniti.Business.checkEmployee();">
                        </div>
                    </div> 
                    <div class="form-group row">
                        <label class="col-lg-2 col-form-label">Name:</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" name="firstName" id="employee-first-name" placeholder="First">
                        </div>
                        <div class="col-lg-2">
                            <input type="text" class="form-control" name="middleInitial" id="employee-middle-initial" placeholder="Middle" maxlength="1">
                        </div>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" name="lastName" id="employee-last-name" placeholder="Last">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-lg-2 col-form-label">Title:</label>
                        <div class="col-lg-10">
                            <input type="text" class="form-control" name="title" id="employee-title">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-lg-2 col-form-label">Application Date</label>
                        <div class="col-lg-10">
                            <input type="date" name="application_date" id="application_date" class="form-control">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-lg-2 col-form-label">Hire Date</label>
                        <div class="col-lg-10">
                            <input type="date" name="hire_date" id="hire_date" class="form-control">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-lg-2 col-form-label">Status</label>
                        <div class="col-lg-10">
                            <select name="employment_status" id="employment_status" class="form-control">
                                <option value="Active" selected>Active</option>
                                <option value="Terminated">Terminated</option>
                                <option value="Suspended (With Pay)">Suspended (With Pay)</option>
                                <option value="Suspended (Without Pay)">Suspended (Without Pay)</option>
                                <option value="Sabbatical">Sabbatical</option>
                                <option value="Family Leave (Paid)">Family Leave (Paid)</option>
                                <option value="Family Leave (FMLA)">Family Leave (FMLA)</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-group row">
                        <label class="col-lg-2 col-form-label">Termination Date</label>
                        <div class="col-lg-10">
                            <input type="date" name="termination_date" id="termination_date" class="form-control">
                        </div>
                    </div>
                    
                    <div class="form-group row">
                        <label class="col-lg-2 col-form-label">Wage Basis</label>
                        <div class="col-lg-10">
                            <select name="wage_basis" id="wage_basis" class="form-control">
                                <option value="Hourly">Hourly</option>
                                <option value="Salaried">Salaried</option>
                                <option value="Contractor">Contractor</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-lg-2 col-form-label">Wage</label>
                        <div class="col-lg-10">
                            <input type="text" name="wage" id="wage" class="form-control">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-lg-2 col-form-label">Payroll Frequency</label>
                        <div class="col-lg-10">
                            <select name="payroll_frequency" id="payroll_frequency" class="form-control" onChange="updateEmployeeForm();">
                                <option value="Weekly">Weekly</option>
                                <option value="Biweekly">Biweekly</option>
                                <option value="Semi-Monthly">Semi-Monthly</option>
                                <option value="Monthly">Monthly</option>
                                <option value="Per Job">Per Job</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </cfoutput>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-primary" name="submit" onclick="Prefiniti.submitForm('add-employee', Prefiniti.reload);">Add Employee</button>
    <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
</div>
