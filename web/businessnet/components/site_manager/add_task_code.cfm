<div class="modal-header">
    <i class="fa fa-list-alt modal-icon"></i>
    <h4 class="modal-title">Add Service</h4>
    <small class="font-bold">This will allow you to create a new service.</small>

</div>
<div class="modal-body">
    
    <form id="add-task-code" method="POST" action="/businessnet/components/site_manager/add_task_code_sub.cfm">

        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Service Name</label>
            <div class="col-lg-10">
                <input name="item" class="form-control" placeholder="Service Name">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Accounting Code</label>
            <div class="col-lg-10">
                <input name="task_id" class="form-control" placeholder="Accounting Code">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Billing</label>
            <div class="col-lg-10">
                <div class="input-group">
                    <input name="rate" class="form-control" placeholder="Rate">
                    <div class="input-group-append">
                        <select name="charge_type" class="custom-select">
                            <option value="Hour">Hour</option>
                            <option value="Day">Day</option>
                            <option value="Week">Week</option>
                            <option value="Month">Month</option>
                            <option value="Quarter">Quarter</option>
                            <option value="Year">Year</option>
                            <option value="Image">Image</option>
                            <option value="Job">Job</option>
                            <option value="Sheet">Sheet</option>
                            <option value="Unit">Unit</option>
                            <option value="Square Foot">Square Foot</option>
                            <option value="Acre">Acre</option>
                            <option value="Square Mile">Square Mile</option>
                        </select>                                
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-lg-12">
                        <input type="checkbox" name="billable" id="billable"> <label for="billable">Billable</label>
                    </div>
                </div>
            </div>
        </div>

    </form>

</div>
<div class="modal-footer">
    <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
    <button type="button" class="btn btn-primary" onclick="Prefiniti.submitForm('add-task-code', Prefiniti.Business.dismiss);">Add Service</button>
</div>