component extends="Prefiniti.Base" {

    remote struct function setViewed() returnformat="JSON" {
        if(!this.loggedIn()) {
            return {
                success: false,
                message: "You are not logged in."
            };
        }

        var method = getHTTPRequestData().method;


        switch(method) {
            case "GET":
                this.setNotificationViewed(url.id);
                return {
                    success: true
                };
            break;
        }

        return {
            success: false,
            message: "Invalid HTTP method " & method & "."
        };

    }

    remote struct function get() returnformat="JSON" {
        if(!this.loggedIn()) {
            return {
                success: false,
                message: "You are not logged in."
            };
        }

        var method = getHTTPRequestData().method;


        switch(method) {
            case "GET":

                var notifications = this.getNotifications();

                var delivered = 0;
                var viewed = 0;
                var notViewed = 0;

                if(notifications.recordCount > 0) {

                    var notify = [];

                    for(notification in notifications) {
                        notify.append({
                            id: notification.id,
                            created_date: notification.created_date,
                            delivered: notification.delivered,
                            viewed: notification.viewed,
                            notification_text: notification.notification_text
                        });

                        if(notification.delivered) delivered++;
                        if(notification.viewed == 1) {
                            viewed++;
                        }
                        else {
                            notViewed++;
                        }

                        this.setNotificationDelivered(notification.id);
                    }



                    return {
                        total: notifications.recordCount,
                        delivered: delivered,
                        viewed: viewed,
                        new: notViewed,
                        success: true,
                        notifications: notify
                    };
                }
                else {
                    return {
                        matches: 0,
                        success: true
                    };
                }
                break;
            case "POST":
                return {
                    success: false,
                    message: "POST not implemented"
                };
                break;
        }

        return {
            success: false,
            message: "Invalid HTTP method " & method & "."
        };

    }
}