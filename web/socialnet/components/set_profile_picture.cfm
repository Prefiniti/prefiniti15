<cfset prefiniti = new Prefiniti.Base()>
<cfset eventText = session.user.longName & " has changed " & prefiniti.getHisHer(session.user.id) & " profile photo">
<cfset prefiniti.setProfilePicture(url.user_id, url.filename)>
<cfset prefiniti.writeUserEvent(session.user.id, "photos.png", eventText)>
<cfset session.user = new Prefiniti.Authentication.UserAccount({id: url.user_id}, false)>