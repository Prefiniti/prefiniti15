<div class="modal-header">
    <i class="fa fa-building modal-icon"></i>
    <h4 class="modal-title">Add Company</h4>
    <cfoutput>
        <small class="font-bold">This will add a new company to Geodigraph Hub.</small>
    </cfoutput>
</div>
<div class="modal-body">
    <cfoutput>
      <div class="row m-b-lg">
          <div class="col-lg-12">
              <form id="add-site" method="POST" action="/webware_admin/addSiteSubmit.cfm">                   
                  <div class="form-group row">
                    <label class="col-lg-2 col-form-label">Site Name:</label>
                    <div class="col-lg-10">
                      <div class="input-group">
                        <input type="text" id="SiteName" name="SiteName" class="form-control">
                        <div class="input-group-append">
                          <select name="enabled" class="custom-select">
                            <option value="1" selected>Enabled</option>
                            <option value="0">Disabled</option>
                          </select>
                        </div>
                      </div>
                    </div>
                  </div>                     
                  <div class="form-group row">                                       
                      <label class="col-lg-2 col-form-label">Site Admin:</label>
                      <div class="col-lg-10">
                          <cfmodule template="/businessnet/components/user_picker.cfm" height="150" element_name="admin_id" all_users>
                      </div>
                  </div>                      
              </form>
          </div>
      </div>
    </cfoutput>
</div>
<div class="modal-footer">
  <button type="button" class="btn btn-primary" name="submit" onclick="Prefiniti.submitForm('add-site', Prefiniti.reload());">Add Site</button>
  <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
</div>
