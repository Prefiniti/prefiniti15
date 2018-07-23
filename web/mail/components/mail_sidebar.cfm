<cfset unread = session.user.getUnreadMessageCount()>
<div class="file-manager">
    <a class="btn btn-block btn-primary compose-mail" href="##" onclick="Prefiniti.Mail.writeMessage();">Compose Mail</a>
    <div class="space-25"></div>
    <h5>Folders</h5>
    <ul class="folder-list m-b-md" style="padding: 0">
        <li><a href="##" onclick="Prefiniti.Mail.viewFolder('inbox', 1);"> <i class="fa fa-inbox"></i> Inbox <span class="label label-warning float-right"><cfoutput>#unread#</cfoutput></span> </a></li>
        <li><a href="##" onclick="Prefiniti.Mail.viewFolder('sent messages', 1);"> <i class="fa fa-envelope"></i> Sent Mail</a></li>
        
    </ul>
    
   
    
    <div class="clearfix"></div>
</div>