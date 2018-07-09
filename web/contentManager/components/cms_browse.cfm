<cfinclude template="/contentManager/cm_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">

<div class="wwaf-metadata">
    <wwaftitle>My Files</wwaftitle>
    <wwafbreadcrumbs>Prefiniti,Content Management,My Files</wwafbreadcrumbs>
</div>

<cfset userFiles = cmsGetUserFiles(session.userid)>

<div class="wrapper">    

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

            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Associated Projects</th>
                        <th>Last Access</th>
                        <th>Size</th>
                        <th><i class="fa fa-cogs"></i></th>
                    </tr>
                </thead>
                <tbody>
                    <cfoutput query="userFiles">
                        <cfset fileType = cmsFileType(id)>
                        <cfset fileURL = "http://#cgi.server_name#/UserContent/#session.username#/#basedir#/#filename#">
                        <tr>
                            <td><img src="#fileType.icon#"> <a href="#fileURL#" target="_blank">#filename#</a></td>
                            <td></td>
                            <td>#dateFormat(last_access, "mmm d, yyyy")#</td>
                            <td>#cmsUserFileSize(id)#</td>
                            <td>
                                <button type="button" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cogs"></i></button>
                                <div class="dropdown-menu">   
                                    <button class="dropdown-item" type="button" onclick="todo();">Associate Project...</button>
                                    <div class="dropdown-divider"></div>                            
                                    <cfif fileType.description EQ "Image">
                                        <button class="dropdown-item" type="button" onclick="setProfilePicture(#session.user.id#, '#fileURL#');">Make Profile Photo</button>
                                        <div class="dropdown-divider"></div>
                                    </cfif>
                                    <button class="dropdown-item" type="button" onclick="todo();">Delete File</button>
                                </div>
                            </td>
                        </tr>
                    </cfoutput>
                </tbody>
            </table>

        </div>
    </div>
</div>

