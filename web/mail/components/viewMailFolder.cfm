<cfset prefiniti = new Prefiniti.Base()>

<div class="wwaf-metadata">
    
        <wwaftitle>Mailbox</wwaftitle>
        <wwafbreadcrumbs>Prefiniti,Mailbox</wwafbreadcrumbs>
</div>

<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="MA_VIEW">

<cfset mail = prefiniti.getMailbox(session.user.id, url.mailbox)>
<cfset unread = prefiniti.getSiteStats(session.current_site_id, session.user.id).unreadMail>


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
            <div class="mail-box-header">

                <form method="get" action="index.html" class="float-right mail-search">
                    <div class="input-group">
                        <input type="text" class="form-control form-control-sm" name="search" placeholder="Search email">
                        <div class="input-group-btn">
                            <button type="submit" class="btn btn-sm btn-primary">
                                Search
                            </button> 
                        </div>
                    </div>
                </form>
                <h2>
                    <cfif url.mailbox EQ "inbox">
                        <cfoutput>Inbox (#unread#)</cfoutput>
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
                            <cfif NOT url.start_at GE mail.RecordCount - 50>
                                <button class="btn btn-white btn-sm" onclick="viewMailFolder('#url.mailbox#', #url.start_at + 50#);"><i class="fa fa-arrow-right"></i></button>
                            </cfif>
                        </cfoutput>
                    </div>
                    <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" title="Refresh inbox" onclick="Prefiniti.reload();"><i class="fa fa-refresh"></i> Refresh</button>
                    <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="Mark as read"><i class="fa fa-eye"></i> </button>                    
                    <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="Move to trash"><i class="fa fa-trash"></i> </button>

                </div>
            </div>
            <div class="mail-box">

                <table class="table table-hover table-mail">
                    <tbody>
                        <cfoutput query="mail" maxrows="50" startrow="#url.start_at#">
                            <cfset attachments = prefiniti.mailGetAttachments(msgid).recordCount>
                            <cfif tread EQ "no">
                                <cfset rowClass = "unread">
                            <cfelse>
                                <cfset rowClass = "read">
                            </cfif>

                            <tr class="#rowClass#">
                                <td class="check-mail">
                                    <input type="checkbox" class="i-checks">
                                </td>
                                <td class="mail-ontact">

                                    <a href="##" onclick="">
                                        <cfif url.mailbox EQ "sent messages">
                                            #prefiniti.getLongname(touser)#
                                        <cfelse>
                                            #longName#                                            
                                        </cfif>        
                                    </a>
                                </td>
                                <td class="mail-subject"><a href="##" onclick="viewMessage(#msgid#)">#tsubject#</a></td>
                                <td class="">
                                    <cfif attachments>
                                        <i class="fa fa-paperclip"></i>
                                    </cfif>
                                </td>
                                <td class="text-right mail-date">#prefiniti.getFriendlyDuration(tdate)#</td>
                            </tr>
                                                    
                        </cfoutput>
                        
                    </tbody>
                </table>


            </div>
        </div>
    </div>
</div>
       