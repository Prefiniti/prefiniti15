<cfset prefiniti = new Prefiniti.Base()>

<cfset friends = session.user.getFriends()>

<div class="p-3">
    <table class="table table-hover">
        <tbody>
            <cfloop array="#friends#" item="friend">
                <tr>        
                    <cfoutput>

                        <cfif friend.online EQ 1>
                            <cfset friendPic = friend.getPicture()>
                            <cfset friendName = friend.longName>
                            
                            <td class="client-avatar">
                                <img src="#friendPic#" class="rounded-circle avatar-sm">
                            </td>
                            <td>
                                <a href="##" class="client-link" onclick="Prefiniti.viewProfile(#friend.id#);">#friendName#</a>
                            </td>
                        </cfif>
                       
                    </cfoutput>
                </tr>
            </cfloop>
        </tbody>
    </table>
</div>