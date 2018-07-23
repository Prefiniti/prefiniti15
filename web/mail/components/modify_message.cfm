<cfheader name="Content-Type" value="application/json">
<cfscript>
message = new Prefiniti.PrivateMessage(url.id);

try {
    switch(url.action) {
        case "read":
            message.markAsRead();
            break;
        case "unread":
            message.markAsUnread();
            break;
        case "delete":
            if(url.folder == "inbox") {
                message.deleteFromInbox();
            }
            if(url.folder == "sent messages") {
                message.deleteFromOutbox();
            }
            break;
    }

    result = {
        success: true,
        action: url.action
    };
}
catch(any ex) {
    result = {
        success: false,
        action: url.action
    };
}
</cfscript>
<cfoutput>#serializeJSON(result)#</cfoutput>