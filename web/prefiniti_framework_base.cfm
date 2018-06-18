<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">

    <title>Prefiniti</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link href="css/prefiniti.css" rel="stylesheet" type="text/css">
    
    <cfinclude template="configRSS.cfm">
</head>

<body onresize="handleAppResize();" onunload="handleAppUnload();">

    <cfif #session.loggedin# EQ "yes">
        <cfinclude template="webwareConfigLoad.cfm">
    </cfif>
    <cfoutput>
        <cfif #session.loggedin# EQ "yes">            
            <cfinclude template="/generateMenus.cfm">
            <cfinclude template="miniSiteSelect.cfm">
        </cfif>
    </cfoutput>

    <cfinclude template="maintCheck.cfm">
    <cfinclude template="sessionMessage.cfm">
    <cfinclude template="genericMessage.cfm">
    <cfinclude template="/help/components/helpWrapper.cfm">
    <cfinclude template="/cms_add_file_assoc_wrapper.cfm">
    <cfinclude template="/cms_minibrowser_wrapper.cfm">
    <cfinclude template="/windowWrapper.cfm">

    <!-- Open the div element for the main client area -->    
    <div class="bodyWrapper" id="appArea" style="margin: 0; padding: 0;">

        <div class="sidebarBlock"  style="height: 100%; width:240px; margin: 0;" id="sbWrapper">
            <span style="background-color:#EFEFEF; display:block; padding:5px; -moz-border-radius-topleft:10px;">
                <span id="packageIcon" style="padding-left:10px;"></span><span id="packageName" style="padding-left:3px; padding-right:3px;"></span>
            </span>

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

        </div> <!-- sidebarBlock -->
        

        <div id="stWrapper" class="orderListBlock" style="margin: 0; padding: 0;">

            <div id="stT" style="width:100%;">
                <cfif #session.loggedin# EQ "yes">

                    <div style="width:100%; background-color:#EFEFEF;">

                        <a href="javascript:navigateBack();">
                            <img src="/graphics/resultset_previous.png" border="0" align="absmiddle" />
                        </a>
                        <a href="javascript:navigateForward();">
                            <img src="/graphics/resultset_next.png" border="0" align="absmiddle"/>
                        </a>
                        <a href="javascript:loadHomeView();">
                            <img src="graphics/house.png" border="0" align="absmiddle" />
                        </a>
                        <a href="javascript:AjaxRefreshTarget();">
                            <img src="graphics/arrow_refresh.png" border="0" align="absmiddle" />
                        </a>

                        <span id="documentName" style="color:black; padding-left:5px; padding-right:5px;"></span> 
                        
                        History: <select style="margin-top:3px;" id="history" name="history" size="1" onchange="AjaxLoadPageToDiv('tcTarget', GetValue('history'));"><option value=""> </option></select>


                        
                        <span id="file_action" style="display: none;">
                            <input type="hidden" name="selected_file_id" id="selected_file_id" value="">
                            <input type="hidden" name="current_mode" id="current_mode" value="" />
                               
                            <span id="cms_send_file">
                                <img src="/graphics/email_attach.png" border="0" align="absmiddle"> <a href="javascript:mailWithAttachments(GetValue('selected_file_id'))">Send File</a> |&nbsp;
                            </span>
                            
                            <span id="cms_delete_file"><img src="/graphics/bin.png" border="0" align="absmiddle"> <a href="javascript:cmsDeleteFile(GetValue('selected_file_id'), GetValue('current_mode'));">Delete File</a> |&nbsp;
                            </span>
                            
                            <img src="/graphics/zoom.png" border="0" align="absmiddle"> <a href="javascript:cmsViewFile(GetValue('selected_file_id'), GetValue('current_mode'));">View File</a>
                       </span>
                    

                   </div>
               </cfif>
           </div> <!-- stT -->

           <div id="sbTarget" style=" min-height:20px; height:auto;width:100%; border-bottom:1px solid #EFEFEF; vertical-align:bottom; padding-top:10px; padding-left:3px; overflow:auto;">

           </div> <!-- sbTarget -->

           <div id="tcTarget">

           </div> <!-- tcTarget -->
        </div> <!-- stWrapper -->
    </div> <!-- bodyWrapper -->
    
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>   
    <script src="/framework/framework.js"></script>
    <script src="/tc/timecard.js"></script>
    <script src="/calendar2.js"></script>
    <script src="/workFlow/components/projectStatus.js"></script>
    <script src="/workFlow/projects.js"></script>
    <script src="/MyCL/components/collapse.js"></script>
    <script src="/contentManager/contentManager.js"></script>
    <script src="/contentManager/swfupload.js"></script>
    <script src="/contentManager/handlers.js"></script>     
    <script src="/mapping/mapping.js"></script>
    <script src="/legalSection/legalsection.js"></script>
    <script src="/news/news.js"></script>
    <script src="/authentication/authentication.js"></script>
    <script src="/globals.js"></script>
    <script src="/mail/mail.js"></script>
    <script src="/scheduling/scheduling.js"></script>
    <script src="/help/help.js"></script>
    <script src="/soundmanager.js"></script>
    <script src="/netsearch/netsearch.js"></script>
    <script src="/chat/chat.js"></script>
    <script src="/socialnet/socialnet.js"></script>
    <script src="/datetimepicker.js"></script>
    <script src="/controls/date_picker.js"></script>
    <script src="/controls/record_scroller.js"></script>
    <script src="/notifications/notifications.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    
    <cfset session.framework_loaded="1">
    <cfoutput>        
        <cfset session.pwdiff=DateDiff("d", qryGetLogin.last_pwchange, Now())>
        <cfif #session.pwdiff# GE 30>
            <script language="javascript">
                AjaxLoadPageToDiv('tcTarget', '/authentication/components/changePassword.cfm?id=#session.userid#&expired=true');
            </script>
        <cfelse>
            <cfif #session.last_loaded_page# EQ "">
                <script language="javascript">
                    loadHomeView();
                </script>
            <cfelse>
                <cfif #session.remember_page# EQ 1>
                    <script language="javascript">
                        AjaxLoadPageToDiv('tcTarget', '#session.last_loaded_page#');
                    </script>
                <cfelse>
                    <script language="javascript">
                        loadHomeView();
                    </script>   
                </cfif>             
            </cfif>
        </cfif>

        <script language="javascript">
            handleAppResize();
            loadSiteStats();
        </script>
         					
    </cfoutput>
</body>
</html>
