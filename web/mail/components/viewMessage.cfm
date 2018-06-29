<cfset prefiniti = new Prefiniti.Base()>

<div class="wwaf-metadata">
    
        <wwaftitle>View Message</wwaftitle>
        <wwafbreadcrumbs>Prefiniti,Mailbox,View Message</wwafbreadcrumbs>
</div>

<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="MA_VIEW">

<cfset message = prefiniti.getMessage(url.id)>
<cfset attachments = prefiniti.mailGetAttachments(url.id)>


<div class="wrapper wrapper-content">
    <div class="row">
        <div class="col-lg-3">
            <div class="ibox ">
                <div class="ibox-content mailbox-content">
                    <div class="file-manager">
                        <a class="btn btn-block btn-primary compose-mail" href="##" onclick="writeMessage();">Compose Mail</a>
                        <div class="space-25"></div>
                        <h5>Folders</h5>
                        <ul class="folder-list m-b-md" style="padding: 0">
                            <li><a href="##" onclick="viewMailFolder('inbox', 1);"> <i class="fa fa-inbox"></i> Inbox <span class="label label-warning float-right">16</span> </a></li>
                            <li><a href="##" onclick="viewMailFolder('sent messages', 1);"> <i class="fa fa-envelope"></i> Sent Mail</a></li>
                            
                        </ul>
                        
                        <h5>Categories</h5>
                        <ul class="category-list" style="padding: 0">
                            <li><a href="#"> <i class="fa fa-circle text-navy"></i> Work </a></li>
                            <li><a href="#"> <i class="fa fa-circle text-danger"></i> Documents</a></li>
                            <li><a href="#"> <i class="fa fa-circle text-primary"></i> Social</a></li>
                            <li><a href="#"> <i class="fa fa-circle text-info"></i> Advertising</a></li>
                            <li><a href="#"> <i class="fa fa-circle text-warning"></i> Clients</a></li>
                        </ul>

                        <h5 class="tag-title">Labels</h5>
                        <ul class="tag-list" style="padding: 0">
                            <li><a href=""><i class="fa fa-tag"></i> Family</a></li>
                            <li><a href=""><i class="fa fa-tag"></i> Work</a></li>
                            <li><a href=""><i class="fa fa-tag"></i> Home</a></li>
                            <li><a href=""><i class="fa fa-tag"></i> Children</a></li>
                            <li><a href=""><i class="fa fa-tag"></i> Holidays</a></li>
                            <li><a href=""><i class="fa fa-tag"></i> Music</a></li>
                            <li><a href=""><i class="fa fa-tag"></i> Photography</a></li>
                            <li><a href=""><i class="fa fa-tag"></i> Film</a></li>
                        </ul>
                        
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-9 animated fadeInRight">
            <cfoutput query="message">
                <div class="mail-box-header">
                    <div class="float-right tooltip-demo">
                        <a href="##" onclick="replyMessage(#fromuser#, '#tsubject#', '#HTMLEditFormat(tbody)#');" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="Reply"><i class="fa fa-reply"></i> Reply</a>
                        <a href="##" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="Print email"><i class="fa fa-print"></i> </a>
                        <a href="##" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="Move to trash"><i class="fa fa-trash-o"></i> </a>
                    </div>
                    <h2>
                        View Message
                    </h2>
                    <div class="mail-tools tooltip-demo m-t-md">


                        <h3>
                            <span class="font-normal">Subject: </span>#tsubject#
                        </h3>
                        <h5>
                            <span class="float-right font-normal">#dateFormat(tdate, "mmmm d, yyyy")# #timeFormat(tdate, "h:mm tt")#</span>
                            <span class="font-normal">From: </span>#longName#
                        </h5>
                    </div>
                </div>
            </cfoutput>
            <div class="mail-box">
                <div class="mail-body">
                    <cfoutput>#message.tbody#</cfoutput>
                </div>
                <cfif attachments.recordCount GT 0>
                    <div class="mail-attachment">
                        <p>
                            <span><i class="fa fa-paperclip"></i> <cfoutput>#attachments.recordCount#</cfoutput> attachment(s) - </span>
                            <a href="#">Download all</a>
                            |
                            <a href="#">View all images</a>
                        </p>

                        <div class="attachment">
                            <cfoutput query="attachments">
                                <div class="file-box">
                                    <div class="file">
                                        <a href="##">
                                            <span class="corner"></span>

                                            <div class="icon">
                                                <i class="fa fa-file"></i>
                                            </div>
                                            <div class="file-name">
                                                <a href="##" onclick="cmsViewFile(#file_id#, 'user');">#prefiniti.cmsUserFileName(file_id)#</a>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            </cfoutput>
                            
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </cfif>
                <div class="mail-body text-right tooltip-demo">
                    <cfoutput>
                        <a class="btn btn-sm btn-white" href="##" onclick="replyMessage(#message.fromuser#, '#message.tsubject#', '#HTMLEditFormat(message.tbody)#');"><i class="fa fa-reply"></i> Reply</a>  
                    </cfoutput>                                  
                    <button title="" data-placement="top" data-toggle="tooltip" data-original-title="Trash" class="btn btn-sm btn-white"><i class="fa fa-trash-o"></i> Remove</button>
                </div>
                <div class="clearfix"></div>


            </div>
            
        </div>
    </div>
</div>
