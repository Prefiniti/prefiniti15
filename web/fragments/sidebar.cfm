
<div class="card">
    <div class="card-body bg-dark text-light">
        <cfquery name="profile" datasource="webwarecl">
            SELECT * FROM users WHERE id=#session.userid#
        </cfquery>

        <cfoutput query="profile">
            <div class="row">
                <div class="col-md-4">
                    <cfif #picture# EQ "">
                        <cfif #gender# EQ "M">
                            <img src="/graphics/genpicmale.png" class="img-fluid rounded-circle">
                        <cfelseif #gender# EQ "F">
                            <img src="/graphics/genpicfemale.png" class="img-fluid rounded-circle">
                        <cfelse>
                            <img src="/graphics/genpicmale.png" class="img-fluid rounded-circle">
                        </cfif>
                    <cfelse>
                        <img src="#picture#" class="img-fluid rounded-circle">
                    </cfif>
                </div>
                <div class="col-md-8">
                    <div class="dropdown">
                        <a class="btn btn-secondary dropdown-toggle" href="##" role="button" data-toggle="dropdown" id="user-menu">#longName#</a>
                        <div class="dropdown-menu" aria-labelledby="user-menu">
                            <a class="dropdown-item" href="##" onclick="editUser(#session.userid#, 'basic_information.cfm');">Edit Profile</a>
                            <a class="dropdown-item" href="##" onclick="viewProfile(#session.userid#);">View Profile</a>
                            <a class="dropdown-item" href="##" onclick="AjaxLoadPageToDiv('tcTarget', '/socialnet/components/search_users.cfm');">Friend Search</a>
                            <a class="dropdown-item" href="##" onclick="viewPictures(#session.userid#, true);">Pictures</a>
                            <a class="dropdown-item" href="##" onclick="cmsBrowseFolder(#session.userid#, 'project_files', '', 'user', '');">My Files</a>
                            <a class="dropdown-item" href="##" onclick="AjaxLoadPageToDiv('tcTarget', '/businessnet/components/my_departments.cfm');">My Departments</a>
                            <a class="dropdown-item" href="##" onclick="AjaxLoadPageToDiv('tcTarget', '/scheduling/my_schedule.cfm?date=#DateFormat(Now(), "yyyy/mm/dd")#');">My Schedule</a>
                            <a class="dropdown-item" href="##" onclick="logoff.cfm">Sign Out</a>
                        </div>
                    </div>
                    <div id="currentStats" align="left"></div>
                    <div id="statTarget" align="left" style="color:red; font-weight:bold;"></div>
                    
                </div>

            </div>
        </cfoutput>
    </div>
</div>

<!---
<div class="picWrap" align="center">
    <div id="profilePicture">
        <cfoutput query="profile">
            <span id="mainPic">
                <cfif #picture# EQ "">
                    <cfif #gender# EQ "M">
                        <img src="/graphics/genpicmale.png" width="220"  />
                    <cfelseif #gender# EQ "F">
                        <img src="/graphics/genpicfemale.png" width="220" >
                    <cfelse>
                        <img src="/graphics/genpicmale.png" width="220">
                    </cfif>
                <cfelse>
                    <img src="#picture#" width="220" style="-moz-border-radius:5px;" >
                </cfif>
            </span>
            <strong>
                <a href="javascript:editUser(#session.userid#, 'basic_information.cfm');">Edit Profile</a> |&nbsp; 
                <a href="javascript:viewProfile(#session.userid#);">View Profile</a><br>
                <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/socialnet/components/search_users.cfm');">Friend Search</a> |&nbsp; 
                <a href="javascript:viewPictures(#session.userid#, true);">Pictures</a><br />
                <a href="javascript:cmsBrowseFolder(#session.userid#, 'project_files', '', 'user', '');">My Files</a> |&nbsp; 
                <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/businessnet/components/my_departments.cfm');">My Departments</a> |&nbsp; 
                <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/scheduling/my_schedule.cfm?date=#DateFormat(Now(), "yyyy/mm/dd")#');">My Schedule</a>                            
            </strong>
        </cfoutput>                   
    </div> <!-- profilePicture -->
    <br />
    <div id="currentStats" align="left"></div>
    <div id="framework_status" style="font-size:6pt; padding-top:16px;" align="left"></div>

    <div id="statTarget" align="left" style="color:red; font-weight:bold;">

    </div>
</div> <!-- picWrap -->
--->