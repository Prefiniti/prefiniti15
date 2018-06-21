<cfinclude template="/contentManager/cm_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<cfset userFiles = cmsGetUserFiles(session.userid)>

<div class="wrapper">
    <h1>My Files</h1>

    <div class="row">
        <div class="col-md-3">
            <div id="cms-file-upload" class="card">
                <div class="card-header">
                    <i class="fa fa-upload"></i> Upload File
                </div>
                <div class="card-body">
                    <cfoutput>
                        <form method="post" id="cms-upload-form" action="/contentManager/components/process_upload_new.cfm" enctype="multipart/form-data" target="cms-upload-frame">
                            <div class="form-group">
                                <input type="file" name="fileData" class="form-control-file">                                
                            </div>                            
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="profilePhoto" id="cms-profile-photos" value="">
                                <label class="form-check-label" for="cms-profile-photos">This is a profile photo</label>
                            </div>
                            <div class="form-group">
                                <div id="cms-upload-button">
                                    <button type="button" onclick="Prefiniti.submitUpload();" class="btn btn-sm btn-primary float-right mt-3">Upload File</button>
                                </div>
                                <div id="cms-upload-status" class="float-right text-small" style="display: none;">
                                    <img src="/graphics/ajax-loader.gif">
                                </div>

                            </div>                            
                        </form>
                    </cfoutput>

                    <iframe id="cms-upload-frame" name="cms-upload-frame" style="display:none;"></iframe>
                </div>

            </div>

        </div>
        <div class="col-md-9">

            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Associations</th>
                        <th>Last Access</th>
                        <th>Size</th>
                    </tr>
                </thead>
                <tbody>
                    <cfoutput query="userFiles">
                        <cfset fileType = cmsFileType(id)>
                        <tr>
                            <td><img src="#fileType.icon#"> <a href="http://#cgi.server_name#/UserContent/#session.username#/#basedir#/#filename#" target="_blank">#filename#</a></td>
                            <td></td>
                            <td>#dateFormat(last_access, "mmm d, yyyy")#</td>
                            <td>#cmsUserFileSize(id)#</td>
                        </tr>
                    </cfoutput>
                </tbody>
            </table>

        </div>
    </div>
</div>

