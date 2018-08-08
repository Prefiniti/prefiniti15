<cfset prefiniti = new Prefiniti.Base()>

<div class="modal-header">
    <i class="fa fa-users modal-icon"></i>
    <h4 class="modal-title">Friend Search</h4>
    <small class="font-bold">Use this to search for new friends on Geodigraph Social.</small>
</div>
<div class="modal-body">
    <form id="search-users" method="POST" action="/socialnet/components/search_users_sub.cfm">
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Search Terms:</label>
            <div class="col-lg-10">
                <div class="input-group">
                    <input type="text" id="search-value" name="search_value" class="form-control">
                    <div class="input-group-append">
                        <select name="search_field" id="search-field" class="custom-select">
                            <option value="longName" selected>Name Contains</option>   
                            <option value="lastName">Last Name</option>   
                            <option value="email">E-Mail Address</option>
                        </select>
                    </div>
                </div>
            </div>
        </div> 
    </form>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-primary" name="submit" onclick="Prefiniti.Social.searchFriends();">Search</button>
    <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
</div>

