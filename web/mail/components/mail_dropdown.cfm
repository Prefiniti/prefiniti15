<cfif isDefined("session.user")>
    <cfif isDefined("session.user.id")>
        <cfset prefiniti = new Prefiniti.Base()>

        <cfset mail = session.user.getInboxMessages()>

        <cfset shown = 0>

        <cfloop array="#mail#" item="message">

            <cfif shown LE 5>
                <cfoutput>
                    <cfset user = message.from>
                    <cfif user.id NEQ 0 AND user.id NEQ 143>
                        <cfset pic = user.getPicture()>
                    <cfelse>
                        <cfset pic = "/graphics/geodigraph-square.png">
                    </cfif>

                    <li>
                        <div class="dropdown-messages-box">
                            <a class="dropdown-item float-left" href="##" onclick="Prefiniti.Social.loadProfile(#user.id#);">
                                <img alt="image" class="rounded-circle avatar-sm" src="#pic#">
                            </a>
                            <div class="media-body" onclick="Prefiniti.Mail.viewMessage(#message.id#);">
                                <small class="float-right">#user.longName#</small>
                                <strong>#message.tsubject#</strong> <br>
                                <small class="text-muted">#prefiniti.getFriendlyDuration(message.tdate)# at #timeFormat(message.tdate, "h:mm tt")# - #dateFormat(message.tdate, "m.dd.yyyy")#</small>
                            </div>
                        </div>
                    </li>
                    <li class="dropdown-divider"></li>
                </cfoutput>
                <cfset shown = shown + 1>
            </cfif>
        </cfloop>

        <li>
            <cfoutput>
            <div class="text-center link-block">
                <a href="##" class="dropdown-item" onclick="Prefiniti.Mail.viewFolder('inbox', 1);">
                    <i class="fa fa-envelope"></i> <strong>Read All Messages</strong>
                </a>
            </div>
            </cfoutput>
        </li>
    </cfif>
</cfif>