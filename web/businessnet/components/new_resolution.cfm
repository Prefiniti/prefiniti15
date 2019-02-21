<div class="modal-header">
    <i class="fa fa-vote-yea modal-icon"></i>
    <h4 class="modal-title">New Resolution</h4>
    <small class="font-bold">This will allow you to draft a resolution to be voted on by eligible company members.</small>
</div>
<cfoutput>
<div class="modal-body">
     <div class="row m-b-lg">
        <div class="col-lg-12">
            <form id="create-new-resolution" method="POST" action="/businessnet/components/create_resolution_sub.cfm">
                <div class="form-group row">
                    <label class="col-lg-3 col-form-label">Title &amp; Carry Threshold</label>
                    <div class="col-lg-9">
                        <div class="input-group">
                            <input type="text" name="res_title" class="form-control" maxlength="255">
                            <div class="input-group-append">
                                <select name="res_carry_threshold" class="custom-select">
                                    <option value="0" selected>Simple Majority</option>
                                    <option value="75">Two-Thirds Majority</option>
                                    <option value="100">Unanimous</option>
                                </select>                                
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-lg-3 col-form-label">Sponsor</label>
                    <div class="col-lg-9">
                        <input type="text" class="form-control" value="#session.user.longName#" readonly name="___NULL___">
                        <input type="hidden" name="sponsor_assoc_id" value="#session.current_association#">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-lg-3 col-form-label">Voter Eligibility</label>
                    <div class="col-lg-9">
                        <select name="res_eligibility" class="custom-select">
                            <option value="0" selected>Employees</option>
                            <option value="1">Customers</option>
                            <option value="2">Both</option>                                    
                        </select>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-lg-3 col-form-label">Resolution Text</label>
                    <div class="col-lg-9">
                        <textarea class="form-control summernote" name="res_text" rows="8"></textarea>
                    </div>
                </div>
            </form>
        </div> <!-- col-lg-12 -->
    </div> <!-- row m-b-lg -->
</div>
</cfoutput>
<div class="modal-footer">
    <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
</div>