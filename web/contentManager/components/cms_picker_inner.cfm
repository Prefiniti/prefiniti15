<cfset prefiniti = new Prefiniti.Base()>
<cfset files = prefiniti.cmsGetUserFiles(session.user.id)>

<cfif NOT isDefined("attributes")>
    <cfset attributes = url>
</cfif>

<cfoutput>
    <div <cfif attributes.height NEQ -1>style="max-height: #attributes.height#px; overflow-y: auto;"</cfif>>
        <input type="hidden" id="cms-picker-element-name" value="#attributes.element_name#">
        
        <table class="table table-striped table-hover" id="cms-picker-#attributes.element_name#-table">
            <thead>
                <tr>
                    <th>File</th>                    
                    <th align="right"><i class="fa fa-cogs"></i></th>
                </tr>
            </thead>
            <tbody>
                <cfoutput query="files">
                    <cfset fileType = prefiniti.cmsFileType(id)>
                    <cfset fileURL = "https://#cgi.server_name#/UserContent/#session.user.username#/#basedir#/#filename#">
                    <tr>
                        <td><img src="#fileType.icon#"> <a href="#fileURL#" target="_blank"> #filename#</a></td>                                               
                        <td align="right">
                            <div class="btn-group">
                                <button type="button" class="btn btn-primary btn-sm" onclick="Prefiniti.CMS.choose('#attributes.element_name#', '#id#', '#filename#');">Select</button>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cogs"></i></button>
                                    <div class="dropdown-menu">                                                                  
                                        <cfif fileType.description EQ "Image">
                                            <button class="dropdown-item" type="button" onclick="setProfilePicture(#session.user.id#, '#fileURL#');">Make Profile Photo</button>
                                            <div class="dropdown-divider"></div>
                                        </cfif>
                                        <button class="dropdown-item" type="button" onclick="todo();">Delete File</button>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                </cfoutput>                
            </tbody>
        </table>
    </div>
    <table class="table">
        <tr id="cms-picker-#attributes.element_name#-uploader" style="display: none;">
            <td>
                <div class="input-group">    
                    <div class="input-group-prepend">
                        <select id="cms-picker-#attributes.element_name#-file-type" class="custom-select">
                            <option value="project_files" selected>Project Files</option>
                            <option value="profile_images">My Pictures</option>
                        </select>
                    </div>
                    <div class="custom-file">                
                        <input type="file" class="custom-file-input" id="cms-picker-#attributes.element_name#-file">                        
                        <label class="custom-file-label" for="cms-picker-#attributes.element_name#-file">Choose file</label>
                    </div>
                    <div class="input-group-append">
                        
                        <button type="button" class="btn btn-primary" onclick="Prefiniti.CMS.pickerUpload('#attributes.element_name#', '#attributes.height#');">Upload</button>
                    </div>
                </div>
            </td>
            <td align="right"></td>
        </tr>
    </table>

    <div class="row" id="cms-picker-#attributes.element_name#-display-container" style="display: none;">
        <div class="col-lg-12">
            <div class="input-group">
                <input type="text" class="form-control" id="cms-picker-#attributes.element_name#-display" readonly>
                <div class="input-group-append">
                    <button type="button" class="btn btn-primary" onclick="Prefiniti.CMS.undo('#attributes.element_name#');"><i class="fa fa-redo"></i> Change Selection</button>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div id="picker-upload-progress-#attributes.element_name#" class="progress m-b-1" style="display: none;">
                <div class="progress-bar progress-bar-striped progress-bar-animated"></div>
                <div class="status" style="display:none;">0%</div>
            </div>
        </div>
    </div>
</cfoutput>