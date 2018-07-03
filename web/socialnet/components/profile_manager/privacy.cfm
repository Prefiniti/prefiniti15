<form name="update-privacy" id="update-privacy" method="POST" action="/socialnet/components/profile_manager/privacy_sub.cfm">
    <div class="form-group row">
        <label class="col-lg-2 col-form-label">Profile</label>
        <div class="col-lg-10">
            <label><input type="checkbox" id="allowSearch" name="allowSearch"value="1" <cfif #session.user.allowSearch# EQ 1>checked</cfif>> Allow users to search for me</label>
        </div>
    </div>
    <div class="form-group row">
        <div class="col-lg-offset-2 col-lg-10">
            <button type="button" class="btn btn-primary" name="submit" onclick="Prefiniti.submitForm('update-privacy');">Save Changes</button>
        </div>
    </div>
</form>
