<cfset user = new Prefiniti.Authentication.UserAccount({id: attributes.user_id}, false)>

<cfoutput>
    <form name="update-basic" id="update-basic" method="POST" action="/socialnet/components/profile_manager/basic_information_sub.cfm">
        <h4>Demographics</h4>
        <hr>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">First Name</label>
            <div class="col-lg-10">
                <input type="text" name="firstName" id="firstName" class="form-control" value="#user.firstName#">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Middle Initial</label>
            <div class="col-lg-10">
                <input type="text" name="middleInitial" id="middleInitial" class="form-control" value="#user.middleInitial#">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Last Name</label>
            <div class="col-lg-10">
                <input type="text" name="lastName" id="lastName" class="form-control" value="#user.lastName#">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Gender:</label>
            <div class="col-lg-10">
                <cfset gender = user.gender>
                <select name="gender" class="form-control">
                    <option value="M" <cfif gender EQ "M">selected</cfif>>Male</option>
                    <option value="F" <cfif gender EQ "F">selected</cfif>>Female</option>
                    <option value="O" <cfif gender EQ "O">selected</cfif>>Other</option>
                    <option value="" <cfif gender EQ "">selected</cfif>>Prefer not to say</option>                    
                </select>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Date of Birth</label>
            <div class="col-lg-10">
                <input type="date" name="birthday" id="birthday" class="form-control" value="#dateFormat(user.birthday, "yyyy-mm-dd")#">
            </div>
        </div>
        <h4>Settings</h4>
        <hr>        
        <div class="form-group row">            
            <label class="col-lg-2 col-form-label">Initial View</label>
            <div class="col-lg-10">
                <cfset initView = user.remember_page>
                <select name="remember_page" class="custom-select mb-3">
                    <option value="0" <cfif initView EQ 0>selected</cfif>>Dashboard</option>
                    <option value="1" <cfif initView EQ 1>selected</cfif>>My Profile</option>
                    <!---<option value="2" <cfif initView EQ 2>selected</cfif>>Last Page Viewed</option>--->
                </select>
                <input type="checkbox" name="show_tour" id="show_tour" <cfif user.show_tour EQ 1>checked</cfif>> <label for="show_tour">Show welcome screen on login</label>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Geodigraph Maps Credentials</label>
            <div class="col-lg-5">
                <input type="text" name="maps_username" data_lpignore="true" class="form-control" autocomplete="nope" value="#user.maps_username#" placeholder="Geodigraph Maps E-Mail">
            </div>
            <div class="col-lg-5">
                <input type="text" style="-webkit-text-security: disc;" name="maps_password" data_lpignore="true" class="form-control" autocomplete="nope" value="#user.maps_password#" placeholder="Geodigraph Maps Password">
            </div>
        </div>
        <div class="form-group row">
            <div class="col-lg-offset-2 col-lg-10">
                <button type="button" class="btn btn-primary" name="submit" onclick="Prefiniti.submitForm('update-basic');">Save Changes</button>
            </div>
        </div>
    </form>
</cfoutput>