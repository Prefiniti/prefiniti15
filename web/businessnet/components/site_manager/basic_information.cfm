<cfquery name="getSite" datasource="sites">
    SELECT * FROM sites WHERE SiteID=<cfqueryparam cfsqltype="cf_sql_bigint" value="#session.current_site_id#">
</cfquery>


<cfoutput query="getSite">
    <form name="update-general" id="update-general" method="POST" action="/businessnet/components/site_manager/basic_information_sub.cfm">
        <h4>Basic Info</h4>
        <hr>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Company Name</label>
            <div class="col-lg-10">
                <input type="text" name="SiteName" id="SiteName" class="form-control" value="#SiteName#">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Industry</label>
            <div class="col-lg-10">
                <select name="industry" class="custom-select">
                    <option value="Land Survey" <cfif industry EQ "Land Survey">selected</cfif>>Land Survey</option>
                    <option value="Drone Imaging/Mapping" <cfif industry EQ "Drone Imaging/Mapping">selected</cfif>>Drone Imaging/Mapping</option>
                    <option value="Civil Engineering" <cfif industry EQ "Civil Engineering">selected</cfif>>Civil Engineering</option>
                    <option value="Architecture" <cfif industry EQ "Architecture">selected</cfif>>Architecture</option>
                    <option value="GIS Software Development" <cfif industry EQ "GIS Software Development">selected</cfif>>GIS Software Development</option>
                    <option value="Abstract and Title" <cfif industry EQ "Abstract and Title">selected</cfif>>Abstract and Title</option>
                    <option value="Real Estate" <cfif industry EQ "Real Estate">selected</cfif>>Real Estate</option>
                    <option value="Government" <cfif industry EQ "Government">selected</cfif>>Government</option>
                    <option value="Drone Hobbyist" <cfif industry EQ "Drone Hobbyist">selected</cfif>>Drone Hobbyist</option>
                    <option value="GIS Consulting" <cfif industry EQ "GIS Consulting">selected</cfif>>GIS Consulting</option>
                    <option value="" <cfif industry EQ "">selected</cfif>>None Selected</option>                    
                </select>
            </div>
        </div> 
       
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Slogan</label>
            <div class="col-lg-10">
                <input type="text" name="slogan" id="slogan" class="form-control" value="#slogan#">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Summary</label>
            <div class="col-lg-10">
                <input type="text" name="summary" id="summary" class="form-control" value="#summary#">
            </div>
        </div>
        <h4>Contact</h4>
        <hr>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Website</label>
            <div class="col-lg-10">
                <input type="text" name="website" id="website" class="form-control" value="#website#">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Phone</label>
            <div class="col-lg-10">
                <input type="text" name="phone" id="phone" class="form-control" value="#phone#">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Fax</label>
            <div class="col-lg-10">
                <input type="text" name="fax" id="fax" class="form-control" value="#fax#">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Contact E-Mail</label>
            <div class="col-lg-10">
                <input type="email" name="contact_email" id="contact_email" class="form-control" value="#contact_email#">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Sales E-Mail</label>
            <div class="col-lg-10">
                <input type="email" name="sales_email" id="sales_email" class="form-control" value="#sales_email#">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Billing E-Mail</label>
            <div class="col-lg-10">
                <input type="email" name="billing_email" id="billing_email" class="form-control" value="#billing_email#">
            </div>
        </div>
        <h4>Social Networking</h4>
        <hr>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Facebook Handle</label>
            <div class="col-lg-10">
                <input type="text" name="facebook_handle" id="facebook_handle" class="form-control" value="#facebook_handle#">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Twitter Handle</label>
            <div class="col-lg-10">
                <input type="text" name="twitter_handle" id="twitter_handle" class="form-control" value="#twitter_handle#">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Instagram Handle</label>
            <div class="col-lg-10">
                <input type="text" name="instagram_handle" id="instagram_handle" class="form-control" value="#instagram_handle#">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">LinkedIn Handle</label>
            <div class="col-lg-10">
                <input type="text" name="linkedin_handle" id="linkedin_handle" class="form-control" value="#linkedin_handle#">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">YouTube Handle</label>
            <div class="col-lg-10">
                <input type="text" name="youtube_handle" id="youtube_handle" class="form-control" value="#youtube_handle#">
            </div>
        </div>
        <h4>Location</h4>
        <hr>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Address</label>
            <div class="col-lg-10">
                <div class="row">
                    <div class="col-lg-12">
                        <input type="text" name="address" id="address" class="form-control" value="#address#" placeholder="Street Address"> 
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-lg-8">
                        <input type="text" name="city" id="city" class="form-control" value="#city#" placeholder="City">
                    </div>
                    <div class="col-lg-2">
                        <select name="state" class="custom-select">
                            <option value="NM" <cfif state EQ "NM">selected</cfif>>New Mexico</option>
                        </select>
                    </div>
                    <div class="col-lg-2">
                        <input type="text" name="zip" id="zip" class="form-control" value="#zip#" placeholder="ZIP" maxlength="10">
                    </div>
                </div>
            </div>
        </div>
       

        <h4>Statements</h4>
        <hr>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">About Us</label>
            <div class="col-lg-10">
                <textarea class="summernote" name="about">
                    #about#
                </textarea>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Mission Statement</label>
            <div class="col-lg-10">
                <textarea class="summernote" name="mission_statement">
                    #mission_statement#
                </textarea>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Vision Statement</label>
            <div class="col-lg-10">
                <textarea class="summernote" name="vision_statement">
                    #vision_statement#
                </textarea>
            </div>
        </div>

        <div class="form-group row">
            <div class="col-lg-offset-2 col-lg-10">
                <button type="button" class="btn btn-primary" name="submit" onclick="Prefiniti.submitForm('update-general');">Save Changes</button>
            </div>
        </div>
    </form>
</cfoutput>