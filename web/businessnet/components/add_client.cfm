<div class="modal-header">
    <i class="fa fa-user-plus modal-icon"></i>
    <h4 class="modal-title">Add Client</h4>
    <cfoutput>
        <small class="font-bold">This will add a new client to your company.</small>
    </cfoutput>
</div>
<div class="modal-body">
    <cfoutput>
        <div class="row m-b-lg">
            <div class="col-lg-12">
                <form id="add-client" method="POST" action="/businessnet/components/add_client_sub.cfm">
                    <input type="hidden" name="new_account" id="client-new-account" value="0">
                    <div class="form-group row">
                        <label class="col-lg-2 col-form-label">E-Mail Address:</label>
                        <div class="col-lg-10">
                            <input type="email" id="client-email" name="email" class="form-control" onblur="Prefiniti.Business.checkClient();">
                        </div>
                    </div> 
                    <div class="form-group row">
                        <label class="col-lg-2 col-form-label">Name:</label>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" name="firstName" id="client-first-name" placeholder="First">
                        </div>
                        <div class="col-lg-2">
                            <input type="text" class="form-control" name="middleInitial" id="client-middle-initial" placeholder="Middle" maxlength="1">
                        </div>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" name="lastName" id="client-last-name" placeholder="Last">
                        </div>
                    </div>                    
                </form>
            </div>
        </div>
    </cfoutput>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-primary" name="submit" onclick="Prefiniti.submitForm('add-client', Prefiniti.Business.clientAdded);">Add Client</button>
    <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
</div>