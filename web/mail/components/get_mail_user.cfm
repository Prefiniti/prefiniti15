<cfheader name="Content-Type" value="application/json">
<cfset user = new Prefiniti.Authentication.UserAccount({id: url.id}, false)>
<cfset result = {
	name: user.longName
}>
<cfoutput>#serializeJSON(result)#</cfoutput>