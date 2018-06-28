<cfset prefiniti = new Prefiniti.LegacyAPI()>

<cfset mail = prefiniti.getMailbox(session.user.id, "inbox", 10)>

<cfoutput query="mail">

    <cfset user = new Prefiniti.Authentication.UserAccount({id: mail.sender_id}, false)>
    <cfif user.id NEQ 0 AND user.id NEQ 143>
        <cfset pic = user.getPicture()>
    <cfelse>
        <cfset pic = "/graphics/pi.png">
    </cfif>
    <div class="container-fluid">
        <div class="row m-1">
            <div class="col-sm-1">
                <div class="text-center mt-3">
                    <a href="##" onclick="Prefiniti.viewProfile(#user.id#);">
                        <img class="rounded-circle avatar-sm" src="#pic#">
                    </a>
                </div>
            </div>
            <div class="col-sm-8">
                <a class="dropdown-item" href="##" onclick="Prefiniti.viewProfile(#user.id#);"><small><b>#user.longName#</b></small></a>
                <a class="dropdown-item" href="##" onclick="viewMessage(#msgid#);"><small>#tsubject#</small></a>
            </div>
        </div>
    </div>
    <div role="separator" class="dropdown-divider"></div>
</cfoutput>
