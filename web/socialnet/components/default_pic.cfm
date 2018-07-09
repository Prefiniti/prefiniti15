<cfset prefiniti = new Prefiniti.Base()>

<cfoutput>
	<img src="#session.user.getPicture()#" class="rounded-circle avatar" title="profile photo">
</cfoutput>    