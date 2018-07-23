<cfheader name="Content-Type" value="application/json">
<cfscript>
	try {
		message = new Prefiniti.PrivateMessage();

		message.fromuser = form.fromuser;
		message.touser = form.touser;
		message.tsubject = form.tsubject;
		message.tbody = form.tbody;

		message.save();
		message.send();

		result = {
			success: true
		};
	}
	catch (any ex) {
		result = {
			success: false,
			message: ex.message,
			detail: ex.detail
		};
	}
</cfscript>
<cfoutput>#serializeJSON(result)#</cfoutput>