<cfset prefiniti = new Prefiniti.Base()>

<cfset mail = prefiniti.getMailbox(session.user.id, "inbox", 10)>

<cfoutput query="mail">

    <cfset user = new Prefiniti.Authentication.UserAccount({id: mail.sender_id}, false)>
    <cfif user.id NEQ 0 AND user.id NEQ 143>
        <cfset pic = user.getPicture()>
    <cfelse>
        <cfset pic = "/graphics/pi.png">
    </cfif>

    <li>
        <div class="dropdown-messages-box">
            <a class="dropdown-item float-left" href="##" onclick="Prefiniti.viewProfile(#user.id#);">
                <img alt="image" class="rounded-circle avatar-sm" src="#pic#">
            </a>
            <div class="media-body" onclick="viewMessage(#msgid#);">
                <small class="float-right">#user.longName#</small>
                <strong>#tsubject#</strong> <br>
                <small class="text-muted">#prefiniti.getFriendlyDuration(tdate)# at #timeFormat(tdate, "h:mm tt")# - #dateFormat(tdate, "m.dd.yyyy")#</small>
            </div>
        </div>
    </li>
    <li class="dropdown-divider"></li>
</cfoutput>

<li>
    <cfoutput>
    <div class="text-center link-block">
        <a href="##" class="dropdown-item" onclick="viewMailFolder('inbox', 1);">
            <i class="fa fa-envelope"></i> <strong>Read All Messages</strong>
        </a>
    </div>
    </cfoutput>
</li>