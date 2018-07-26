<cfset prefiniti = new Prefiniti.Base()>

<div class="wwaf-metadata">
    <wwaftitle>View Message</wwaftitle>
    <wwafbreadcrumbs>Geodigraph PM,Mailbox,View Message</wwafbreadcrumbs>
</div>

<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="MA_VIEW">

<cfset message = new Prefiniti.PrivateMessage(url.id)>
<cfset attachments = message.getAttachments()>
<cfset message.markAsRead()>


<div class="wrapper wrapper-content">
    <div class="row">
        <div class="col-lg-3">
            <div class="ibox ">
                <div class="ibox-content mailbox-content">
                    <cfinclude template="/mail/components/mail_sidebar.cfm">
                </div>
            </div>
        </div>
        <div class="col-lg-9 animated fadeInRight">
            <cfoutput>
                <div class="mail-box-header">
                    <div class="float-right tooltip-demo">
                        <a href="##" onclick="Prefiniti.Mail.replyMessage(#message.id#);" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="Reply"><i class="fa fa-reply"></i> Reply</a>
                        <a href="##" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="Print"><i class="fa fa-print"></i> </a>
                        <a href="##" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="Delete" onclick="Prefiniti.Mail.deleteMessageFromView(#message.id#);"><i class="fa fa-trash-alt"></i> </a>
                    </div>
                    <h2>
                        View Message
                    </h2>
                    <div class="mail-tools tooltip-demo m-t-md">


                        <h3>
                            <span class="font-normal">Subject: </span>#message.tsubject#
                        </h3>
                        <h5>
                            <span class="float-right font-normal">#dateFormat(message.tdate, "mmmm d, yyyy")# #timeFormat(message.tdate, "h:mm tt")#</span>
                            <span class="font-normal">From: </span>#message.from.longName#
                        </h5>
                    </div>
                </div>
            </cfoutput>
            <div class="mail-box">
                <div class="mail-body">
                    <cfoutput>#message.tbody#</cfoutput>
                </div>
                <cfif attachments.len() GT 0>
                    <div class="mail-attachment">
                        <p>
                            <span><i class="fa fa-paperclip"></i> <cfoutput>#attachments.len()#</cfoutput> attachment(s) - </span>
                            <a href="#">Download all</a>
                            |
                            <a href="#">View all images</a>
                        </p>

                        <div class="attachment">
                            <cfloop array="#attachments#" item="attachment">
                                <div class="file-box">
                                    <div class="file">
                                        <a href="##">
                                            <span class="corner"></span>

                                            <div class="icon">
                                                <i class="fa fa-file"></i>
                                            </div>
                                            <div class="file-name">
                                                <a href="##" onclick="cmsViewFile(#attachment.file_id#, 'user');">#prefiniti.cmsUserFileName(attachment.file_id)#</a>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            </cfloop>
                            
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </cfif>
                <div class="mail-body text-right tooltip-demo">
                    <cfoutput>
                        <a class="btn btn-sm btn-white" href="##" onclick="Prefiniti.Mail.replyMessage(#message.id#);"><i class="fa fa-reply"></i> Reply</a>  
                        <button title="" data-placement="top" data-toggle="tooltip" data-original-title="Trash" class="btn btn-sm btn-white" onclick="Prefiniti.Mail.deleteMessageFromView(#message.id#);"><i class="fa fa-trash-alt"></i> Remove</button>
                    </cfoutput>
                </div>
                <div class="clearfix"></div>


            </div>
            
        </div>
    </div>
</div>
