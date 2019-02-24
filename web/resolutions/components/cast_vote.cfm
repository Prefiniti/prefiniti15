<!--
    0 - abstain
    1 - yea
    2 - nay
-->
<cfset res = new Prefiniti.Collaboration.Resolution(url.res_id)>

<cfoutput>
    <div class="modal-header">
        <cfswitch expression="#url.vote_type#">
            <cfcase value="0">
                <i class="fa fa-circle modal-icon"></i>
                <h4 class="modal-title">Abstain</h4>
                <small class="font-bold">You are <strong>abstaining</strong> on #res.res_title#.</small>
            </cfcase>
            <cfcase value="1">
                <i class="fa fa-vote-yea modal-icon"></i>
                <h4 class="modal-title">Vote Yea</h4>
                <small class="font-bold">You are voting <strong>yea</strong> on #res.res_title#.</small>
            </cfcase>
            <cfcase value="2">
                <i class="fa fa-vote-nay modal-icon"></i>
                <h4 class="modal-title">Vote Nay</h4>
                <small class="font-bold">You are voting <strong>nay</strong> on #res.res_title#.</small>
            </cfcase>
        </cfswitch>
    </div>

    <div class="modal-body">
        <div class="row m-b-lg">
            <div class="col-lg-12">
                <form id="cast-vote" method="POST" action="/resolutions/components/cast_vote_sub.cfm">
                    <input type="hidden" name="res_id" value="#res.id#">
                    <input type="hidden" name="vote_type" value="#url.vote_type#">
                    <div class="form-group row">
                        <label class="col-lg-3 col-form-label">Resolution</label>
                        <div class="col-lg-9">
                            <input type="text" name="s__bap" class="form-control" value="#res.getResolutionNumber()#:  #res.res_title#" readonly="readonly">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-lg-3 col-form-label">Voter</label>
                        <div class="col-lg-9">
                            <input type="text" name="s__baq" class="form-control" value="#session.user.longName#" readonly="readonly">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-lg-3 col-form-label">Password</label>
                        <div class="col-lg-9">
                            <p class="text-danger">
                                By entering your password below, you are verifying your identity and eligibility to cast a vote on this resolution. If this resolution carries, and your vote is <strong>yea</strong>, by entering your password, you are authorizing the final resolution text to contain your name as a digital signatory of this resolution. If you abstain or vote <strong>nay</strong> and the resolution passes anyway, your name
                                will not be applied to it as a signatory.
                            </p>
                            <input type="password" name="voter_password" class="form-control">
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
        <button type="button" class="btn btn-primary" onclick="Prefiniti.submitForm('cast-vote', Prefiniti.Resolutions.itemCreated);">Cast Vote</button>
    </cfoutput>
</div>