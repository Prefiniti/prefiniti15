<cfset startDate = dateFormat(dateAdd("d", 7, now()), "yyyy-mm-dd")>
<cfset endDate = dateFormat(dateAdd("d", 7 * 3, now()), "yyyy-mm-dd")>

<div class="modal-header">
    <i class="fa fa-vote-yea modal-icon"></i>
    <h4 class="modal-title">New Resolution</h4>
    <small class="font-bold">This will allow you to draft a resolution to be voted on by eligible company members.</small>
</div>
<cfoutput>
<div class="modal-body">
     <div class="row m-b-lg">
        <div class="col-lg-12">
            <form id="create-new-resolution" method="POST" action="/resolutions/components/new_resolution_sub.cfm">
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
                            <option value="0" selected>Employees Only</option>
                            <option value="1">Clients Only</option>
                            <option value="2">Employees &amp; Clients</option>                                    
                        </select>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-lg-3 col-form-label">Voting Window</label>
                    <div class="col-lg-5">
                        <input type="date" name="res_voting_open" class="form-control" value="#startDate#">
                    </div>
                    <div class="col-lg-4">
                        <input type="date" name="res_voting_close" class="form-control" value="#endDate#">
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
    <button type="button" class="btn btn-white" data-dismiss="modal">Cancel</button>
    <button type="button" class="btn btn-primary" name="submit" onclick="Prefiniti.submitForm('create-new-resolution', Prefiniti.Resolutions.itemCreated);">Create Resolution</button>
</div>