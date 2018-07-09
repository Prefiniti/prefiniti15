<cfset project = new Prefiniti.ProjectManagement.Project(url.id)>

<div class="modal-header">
    <i class="fa fa-map-marker-alt modal-icon"></i>
    <h4 class="modal-title">Add Location</h4>
    <cfoutput> 
        <small class="font-bold">This will add a new location to project <em>#project.project_name#</em>.</small>
    </cfoutput>
</div>
<div class="modal-body">
    <cfoutput>
        <div class="row m-b-lg">
            <div class="col-lg-12">
                <form id="add-location" method="POST" action="/pm/components/add_location_sub.cfm">
                    <input type="hidden" name="project_id" value="#url.id#">
                    <div class="form-group row">
                        <label class="col-lg-2 col-form-label">Location Name:</label>
                        <div class="col-lg-10">
                            <input type="text" id="location_name" name="location_name" class="form-control">
                        </div>
                    </div> 
                    <hr>
                    <div class="form-group row">
                        <label class="col-lg-2 col-form-label">Address:</label>
                        <div class="col-lg-10">
                            <div class="row mb-2">
                                <div class="col-lg-12">
                                    <input type="text" name="address" placeholder="Street Address" class="form-control">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-7">
                                    <input type="text" name="city" placeholder="City" class="form-control">
                                </div>
                                <div class="col-lg-2">
                                    <select name="state" class="custom-select">
                                        <option value="NM">NM</option>
                                    </select>                                                                
                                </div>
                                <div class="col-lg-3">
                                    <input type="text" name="zip" placeholder="ZIP" class="form-control">
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr>
                    <div class="form-group row">
                        <label class="col-lg-2 col-form-label">Lot/Block Survey System:</label>
                        <div class="col-lg-10">
                            <div class="row">
                                <div class="col-lg-6">
                                    <input type="text" name="subdivision" placeholder="Subdivision/Borough" class="form-control">
                                </div>
                                <div class="col-lg-3">
                                    <input type="text" name="lot" placeholder="Lot/Tract/Other" class="form-control">
                                </div>
                                <div class="col-lg-3">
                                    <input type="text" name="block" placeholder="Block" class="form-control">
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr>
                    <div class="form-group row">
                        <label class="col-lg-2 col-form-label">PLSS:</label>
                        <div class="col-lg-10">
                            <div class="row mb-2">
                                <div class="col-lg-12">
                                    <select name="trs_meridian" class="custom-select">
                                        <option value="First Principal">First Principal</option>
                                        <option value="Second Principal">Second Principal</option>
                                        <option value="Third Principal">Third Principal</option>
                                        <option value="Fourth Principal">Fourth Principal</option>
                                        <option value="Fourth Principal (Extended)">Fourth Principal (Extended)</option>
                                        <option value="Fifth Principal">Fifth Principal</option>
                                        <option value="Sixth Principal">Sixth Principal</option>
                                        <option value="Black Hills">Black Hills</option>
                                        <option value="Boise">Boise</option>
                                        <option value="Chickasaw">Chickasaw</option>
                                        <option value="Choctaw">Choctaw</option>
                                        <option value="Cimarron">Cimarron</option>
                                        <option value="Copper River">Copper River</option>
                                        <option value="Fairbanks">Fairbanks</option>
                                        <option value="Gila and Salt River">Gila and Salt River</option>
                                        <option value="Humboldt">Humboldt</option>
                                        <option value="Huntsville">Huntsville</option>
                                        <option value="Indian">Indian</option>
                                        <option value="Kateel River">Kateel River</option>
                                        <option value="Louisiana">Louisiana</option>
                                        <option value="Michigan">Michigan</option>
                                        <option value="Montana">Montana</option>
                                        <option value="Mount Diablo">Mount Diablo</option>
                                        <option value="Navajo">Navajo</option>
                                        <option value="New Mexico Principal">New Mexico Principal</option>
                                        <option value="St. Helena">St. Helena</option>
                                        <option value="St. Stephens">St. Stephens</option>
                                        <option value="Salt Lake">Salt Lake</option>
                                        <option value="San Bernadino">San Bernadino</option>
                                        <option value="Seward">Seward</option>
                                        <option value="Uintah">Uintah</option>
                                        <option value="Umiat">Umiat</option>
                                        <option value="Ute">Ute</option>
                                        <option value="Washington (Mississippi)">Washington (Mississippi)</option>
                                        <option value="Willamette">Willamette</option>
                                        <option value="Wind River">Wind River</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-4">
                                    <div class="input-group">
                                        <input type="text" class="form-control" name="township_number" placeholder="Township">
                                        <div class="input-group-append">
                                            <select name="township_direction" class="custom-select">                                            
                                                <option value="N">North</option>
                                                <option value="S">South</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <div class="input-group">
                                        <input type="text" class="form-control" name="range_number" placeholder="Range">
                                        <div class="input-group-append">
                                            <select name="range_direction" class="custom-select">
                                                <option value="E">East</option>
                                                <option value="W">West</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <input type="text" class="form-control" name="section" placeholder="Section">
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr>
                    <div class="form-group row">
                        <label class="col-lg-2 col-form-label">Geographic:</label>
                        <div class="col-lg-10">
                            <div class="row">
                                <div class="col-lg-4">
                                    <input type="text" name="latitude" class="form-control" placeholder="Latitude">
                                </div>
                                <div class="col-lg-4">
                                    <input type="text" name="longitude" class="form-control" placeholder="Longitude">
                                </div>
                                <div class="col-lg-4">
                                    <input type="text" name="elevation" class="form-control" placeholder="Elevation">
                                </div>

                            </div>
                            <div class="row mt-2">
                                <div class="col-lg-12">
                                    <p class="text-danger">Please note that latitude, longitude, and elevation <strong>MUST</strong> be specified in decimal format.</p>
                                </div>
                            </div>
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </cfoutput>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
    <button type="button" class="btn btn-primary" name="submit" onclick="Prefiniti.submitForm('add-location', Prefiniti.Projects.itemCreated);">Add Location</button>
</div>
