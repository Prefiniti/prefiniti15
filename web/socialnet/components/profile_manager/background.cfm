<cfset user = new Prefiniti.Authentication.UserAccount({id: session.user.id}, false)>

<cfoutput>
    <form name="update-background" id="update-background" method="POST" action="/socialnet/components/profile_manager/background_sub.cfm">
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Biography</label>
            <div class="col-lg-10">
                <textarea name="bio" class="form-control summernote" rows="15">
                    #user.bio#
                </textarea>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Background</label>
            <div class="col-lg-10">
                <textarea name="background" class="form-control summernote" rows="15">
                    #user.background#
                </textarea>
            </div>
        </div>        
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Interests</label>
            <div class="col-lg-10">
                <input type="text" name="interests" id="interests" class="tagsinput form-control" value="#user.interests#">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Music</label>
            <div class="col-lg-10">
                <input type="text" name="music" id="music" class="tagsinput form-control" value="#user.music#">
            </div>
        </div>
        <div class="form-group row">
            <div class="col-lg-offset-2 col-lg-10">
                <button type="button" class="btn btn-primary" name="submit" onclick="Prefiniti.submitForm('update-background');">Save Changes</button>
            </div>
        </div>
    </form>
</cfoutput>