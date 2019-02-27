<cfset res = new Prefiniti.Collaboration.Resolution(url.id)>

<cfoutput>
    <div class="modal-header">
       
        <i class="fa fa-trash modal-icon"></i>
        <h4 class="modal-title">Withdraw Resolution</h4>
        <small class="font-bold">You are <strong>withdrawing</strong> resolution <strong>#res.res_title#</strong>.</small>
           
    </div>

    <div class="modal-body">
        <div class="row m-b-lg">
            <div class="col-lg-12">
                <form id="withdraw-resolution" method="POST" action="/resolutions/components/withdraw_resolution_sub.cfm">
                    <input type="hidden" name="res_id" value="#res.id#">
                    
                    <div class="form-group row">
                        <label class="col-lg-3 col-form-label">Confirmation</label>
                        <div class="col-lg-9">
                            <p class="text-danger">
                                Withdrawing a resolution will permanently delete it. <strong>THIS CANNOT BE UNDONE!</strong>
                            </p>
                            <p class="text-danger">
                                You must type <strong>WITHDRAW</strong> in the box below in order to confirm this action.
                            </p>
                            <input type="text" name="confirmation" class="form-control">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</cfoutput>
<div class="modal-footer">    
    <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
    <cfoutput>
        <button type="button" class="btn btn-primary" onclick="Prefiniti.submitForm('withdraw-resolution', Prefiniti.Resolutions.withdrawn);">Withdraw Resolution</button>
    </cfoutput>
</div>