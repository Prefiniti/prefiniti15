<div class="modal-header">
    <i class="fa fa-user modal-icon"></i>
    <h4 class="modal-title">Account Lookup</h4>
    <small class="font-bold">This will allow an administrator to locate a user account.</small>

</div>
<div class="modal-body">
    <div class="row m-b-lg">
        <div class="col-lg-12">
            <form id="account-lookup">
                <div class="form-group row">
                    <label class="col-lg-2 col-form-label">E-Mail Address</label>
                    <div class="col-lg-10">
                        <input type="email" name="acct_lookup_email" id="acct-lookup-email" class="form-control" maxlength="255">
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-lg-12" id="acct-lookup-results">

                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
    <button type="button" class="btn btn-primary" onclick="Prefiniti.Admin.locateAccount();">Locate Account</button>
</div>