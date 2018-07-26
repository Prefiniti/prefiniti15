<cfoutput>
    <form name="update-privacy" id="update-privacy" method="POST" action="/socialnet/components/profile_manager/privacy_sub.cfm">
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Privacy</label>
            <div class="col-lg-10">
                <label><input type="checkbox" id="allowSearch" name="allowSearch"value="1" <cfif #session.user.allowSearch# EQ 1>checked</cfif>> Allow users to search for me</label>
            </div>
        </div>
        <hr>
        <div class="form-group row">
            <!--- below, we use weird names (zXpssa and zXpssa_confirm) for the password fields to trip up autocomplete and password managers --->
            <!--- browser vendors should be shot for overriding autocomplete="off" and then calling such fuckery a "feature" --->
            <label class="col-lg-2 col-form-label">Password</label>
            <div class="col-lg-5">
                <input type="password" class="form-control" name="zXpssa" placeholder="Password" autocomplete="nope" value="#session.user.password#">
            </div>
            <div class="col-lg-5">
                <input type="password" class="form-control" name="zXpssa_confirm" placeholder="Confirm Password" autocomplete="nope" value="#session.user.password#">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Password Question</label>
            <div class="col-lg-10">
                <select name="password_question" class="custom-select">
                    <option value="What is your mother's maiden name?" <cfif session.user.password_question EQ "What is your mother's maiden name?">selected</cfif>>What is your mother's maiden name?</option>
                    <option value="In what city were you born?" <cfif session.user.password_question EQ "In what city were you born?">selected</cfif>>In what city were you born?</option>
                    <option value="What was the name of your first pet?" <cfif session.user.password_question EQ "What was the name of your first pet?">selected</cfif>>What was the name of your first pet?</option>
                    <option value="What was the make and model of your first car?" <cfif session.user.password_question EQ "What was the make and model of your first car?">selected</cfif>>What was the make and model of your first car?</option>
                    <option value="" <cfif session.user.password_question EQ "">selected</cfif>>None selected</option>
                </select>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Password Answer</label>
            <div class="col-lg-10">
                <input type="text" name="password_answer" class="form-control" value="#session.user.password_answer#">
            </div>
        </div>
        <hr>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Two-Factor Authentication</label>
            <div class="col-lg-10">
                <cfif session.user.tfa_enabled>
                    <p class="text-success font-bold">Two-Factor Authentication is enabled.</p>
                    <button type="button" class="btn btn-warning" onclick="Prefiniti.Security.disableTfa();">Disable (Not Recommended)</button>
                <cfelse>
                    <p class="text-danger font-bold">Two-Factor Authentication has not been set up.</p>
                    <button type="button" class="btn btn-primary" onclick="Prefiniti.Security.enableTfa();">Set Up Now (Recommended)</button>
                </cfif>
            </div>
        </div>
        <div class="form-group row">
            <div class="col-lg-offset-2 col-lg-10">
                <button type="button" class="btn btn-primary" name="submit" onclick="Prefiniti.submitForm('update-privacy');">Save Changes</button>
            </div>
        </div>
    </form>
</cfoutput>
