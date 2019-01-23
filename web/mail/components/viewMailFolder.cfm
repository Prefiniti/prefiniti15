<cfset prefiniti = new Prefiniti.Base()>

<div class="wwaf-metadata">    
        <wwaftitle>Mailbox</wwaftitle>
        <wwafbreadcrumbs>Geodigraph Hub,Mailbox</wwafbreadcrumbs>
</div>

<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="MA_VIEW">

<cfif url.mailbox EQ "inbox">
    <cfset mail = session.user.getInboxMessages()>
<cfelse>
    <cfset mail = session.user.getOutboxMessages()>
</cfif>

<cfset unread = session.user.getUnreadMessageCount()>

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
            <div class="mail-box-header">

                <form method="get" action="index.html" class="float-right mail-search">
                    <div class="input-group">
                        <input type="text" id="search-messages" class="form-control form-control-sm" name="search" placeholder="Search Messages" onkeyup="Prefiniti.Mail.searchMessages();">
                        <div class="input-group-append">
                            <button type="button" class="btn btn-sm btn-primary" onclick="Prefiniti.Mail.searchMessages();">
                                Search
                            </button> 
                        </div>
                    </div>
                </form>
                <h2>
                    <cfif url.mailbox EQ "inbox">
                        <cfoutput>Inbox</cfoutput>
                    <cfelse>
                        <cfoutput>Sent Mail</cfoutput>
                    </cfif>
                </h2>
                <div class="mail-tools tooltip-demo m-t-md">
                    <div class="btn-group float-right">
                        <cfoutput>
                            <cfif url.start_at NEQ 1>
                                <button class="btn btn-white btn-sm" onclick="viewMailFolder('#url.mailbox#', #url.start_at - 50#);"><i class="fa fa-arrow-left"></i></button>
                            </cfif>
                            <cfif NOT url.start_at GE mail.len() - 50>
                                <button class="btn btn-white btn-sm" onclick="viewMailFolder('#url.mailbox#', #url.start_at + 50#);"><i class="fa fa-arrow-right"></i></button>
                            </cfif>
                        </cfoutput>
                    </div>
                    <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" title="Refresh inbox" onclick="Prefiniti.reload();"><i class="fa fa-refresh"></i> Refresh</button>
                    <button onclick="Prefiniti.Mail.markSelectedRead();" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="Mark as read"><i class="fa fa-eye"></i> </button>  
                    <button onclick="Prefiniti.Mail.markSelectedUnread();" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="Mark as unread"><i class="fa fa-eye-slash"></i> </button>                   
                    <button onclick="Prefiniti.Mail.deleteSelected();" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="Delete"><i class="fa fa-trash"></i> </button>

                </div>
            </div>
            <div class="mail-box">

                <table class="table table-hover table-mail">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="messages-toggle-all" onclick="Prefiniti.Mail.toggleSelectAll();"></th>
                            <th>
                                <cfif url.mailbox EQ "inbox">
                                    From
                                <cfelse>
                                    To
                                </cfif>
                            </th>
                            <th>Subject</th>
                            <th><i class="fa fa-paperclip"></i></th>
                            <th>
                                <cfif url.mailbox EQ "inbox">
                                    Received
                                <cfelse>
                                    Sent
                                </cfif>
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <cfloop index="idx" from="#url.start_at#" to="#url.start_at + 50#">
                            <cfif idx LE mail.len()>                                
                                <cfset message = mail[idx]>

                                <cfset attachments = message.getAttachments().len()>
                                <cfif message.tread EQ 0>
                                    <cfset rowClass = "unread">
                                <cfelse>
                                    <cfset rowClass = "read">
                                </cfif>

                                <cfoutput>
                                    <cfif url.mailbox EQ "inbox">
                                        <cfset messagePerson = message.from.longName>
                                    <cfelse>
                                        <cfset messagePerson = message.to.longName>
                                    </cfif>

                                    <tr id="message-#message.id#" class="#rowClass# mail-folder-row" data-message-id="#message.id#" data-message-person="#messagePerson#" data-message-subject="#message.tsubject#">
                                        <td class="check-mail">
                                            <input type="checkbox" class="message-checkbox" data-message-id="#message.id#">
                                        </td>
                                        <td class="mail-contact">

                                            <a href="##" onclick="">
                                                <cfif url.mailbox EQ "sent messages">
                                                    #message.to.longName#
                                                <cfelse>
                                                    #message.from.longname#                                            
                                                </cfif>        
                                            </a>
                                        </td>
                                        <td class="mail-subject"><a href="##" onclick="Prefiniti.Mail.viewMessage(#message.id#)">#message.tsubject#</a></td>
                                        <td class="">
                                            <cfif attachments>
                                                <i class="fa fa-paperclip"></i>
                                            </cfif>
                                        </td>
                                        <td class="text-right mail-date">#prefiniti.getFriendlyDuration(message.tdate)#</td>
                                    </tr>
                                </cfoutput>
                            </cfif>                                                    
                        </cfloop>
                        
                    </tbody>
                </table>


            </div>
        </div>
    </div>
</div>
       