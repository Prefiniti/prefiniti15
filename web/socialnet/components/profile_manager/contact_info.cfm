<cfset user = new Prefiniti.Authentication.UserAccount({id: attributes.user_id}, false)>

<cfoutput>
    <form name="update-contact" id="update-contact" method="POST" action="/socialnet/components/profile_manager/contact_info_sub.cfm">
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Primary Phone</label>
            <div class="col-lg-10">
                <input type="tel" name="phone" id="phone" class="form-control" value="#user.phone#">
            </div>
        </div>    
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Mobile Phone</label>
            <div class="col-lg-10">
                <input type="tel" name="smsNumber" id="smsNumber" class="form-control" value="#user.smsNumber#">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Fax</label>
            <div class="col-lg-10">
                <input type="tel" name="fax" id="fax" class="form-control" value="#user.fax#">
            </div>
        </div>  
        <div class="form-group row">
            <div class="col-lg-offset-2 col-lg-10">
                <button type="button" class="btn btn-primary" name="submit" onclick="Prefiniti.submitForm('update-contact');">Save Changes</button>
            </div>
        </div>
        
    </form>
</cfoutput>