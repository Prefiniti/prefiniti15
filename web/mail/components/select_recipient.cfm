<div class="modal-header">
    <i class="fa fa-user-check modal-icon"></i>
    <h4 class="modal-title">Select Recipient</h4>
    <cfoutput>
        <small class="font-bold">Please select a recipient to begin your mail message.</small>
    </cfoutput>
</div>
<div class="modal-body">
    <cfoutput>
        <div class="row m-b-lg">
            <div class="col-lg-12">
                <form method="POST" action="/pm/components/add_task_sub.cfm">
                    <div class="form-group row">                                       
                        <label class="col-lg-2 col-form-label">Recipient:</label>
                        <div class="col-lg-10">
                            <cfmodule template="/businessnet/components/user_picker.cfm" height="150" element_name="selected_user_id" all_users>
                        </div>
                    </div>                                         
                </form>
            </div>
        </div>
    </cfoutput>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-primary" name="submit" onclick="Prefiniti.Mail.recipientSelected();">Select</button>
    <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
    
</div>
