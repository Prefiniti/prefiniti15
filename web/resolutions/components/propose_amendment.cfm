<cfset res = new Prefiniti.Collaboration.Resolution(url.id)>
<cfset currentAmendment = res.getAmendment(res.getLatestAmendment())>

<cfoutput>
    <div class="modal-header">       
        <i class="fa fa-ballot modal-icon"></i>
        <h4 class="modal-title">Propose Amendment</h4>
        <small class="font-bold">You are preparing an amendment for resolution <strong>#res.res_title#</strong>.</small>
    </div>

    <div class="modal-body">
        <div class="row m-b-lg">
            <div class="col-lg-12">
                <form id="propose-amendment" method="POST" action="/resolutions/components/propose_amendment_sub.cfm">
                    <input type="hidden" name="res_id" value="#res.id#">
                    <div class="form-group row">
                        <label class="col-lg-3 col-form-label">Amendment Title</label>
                        <div class="col-lg-9">
                            <input type="text" name="am_title" class="form-control" required>
                        </div>
                    </div>      
                    <div class="form-group row">  
                        <label class="col-lg-12 col-form-label text-center">
                            Amendment Text<br/>
                            <small><em>Markdown Supported</em></small>
                        </label>                      
                        <label class="col-lg-6 col-form-label text-center">
                            Most Recent Amendment<br/>
                            <small><em>#currentAmendment.am_title#</em></small>
                        </label>           
                        <label class="col-lg-6 col-form-label text-center">
                            This Amendment<br/>
                            <small><em>Modify the text below</em></small>
                        </label>                                                    
                        <div class="col-lg-6">
                            <textarea name="am_previous" class="form-control" rows="10" readonly>#currentAmendment.am_text#</textarea>
                        </div>         
                        <div class="col-lg-6">
                            <textarea name="am_text" class="form-control" rows="10" required>#currentAmendment.am_text#</textarea>
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
        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="Prefiniti.submitForm('propose-amendment', Prefiniti.reload);">Propose Amendment</button>
    </cfoutput>
</div>