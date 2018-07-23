component extends=Prefiniti.NotificationQueries {

    public Prefiniti.Notification function init(required Prefiniti.Authentication.UserAccount recipient, 
                                                required string notificationKey, 
                                                required struct fieldCollection) output=false {

        var templateName = lcase(arguments.notificationKey);

        try {
            var methods = this.getNotificationMethods(arguments.recipient, arguments.notificationKey);
        }
        catch(any e) {
            // this is probably a Post object whose recipient isn't a user.
            // they'll be notified anyway as stakeholders of the project.
            this.messages = [];
            return this;
        }
        var subject = this.getNotificationName(arguments.notificationKey);


        this.messages = [];

        if(methods.mail) {
            this.messages.append(new Prefiniti.MailTemplate(templateName, arguments.recipient.email, subject, arguments.fieldCollection));            
        }

        if(methods.sms) {
            this.messages.append(new Prefiniti.SMSTemplate(templateName, arguments.recipient, arguments.fieldCollection));            
        }

        if(methods.pm) {
            this.messages.append(new Prefiniti.PMTemplate(templateName, arguments.recipient, subject, arguments.fieldCollection));            
        }

        this.messages.append(new Prefiniti.FeedMessage(templateName, arguments.recipient, arguments.fieldCollection));
        this.messages.append(new Prefiniti.RealtimeNotification(templateName, arguments.recipient, arguments.fieldCollection));

        return this;
    }

    public void function send() output=false {

        for(message in this.messages) {
            //cfthread(action="run") {
                message.send();
            //}
        }

    }

}