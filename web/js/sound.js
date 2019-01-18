Prefiniti.extend("Sound", {

    theme: {
        name: "default",
        events: {
            windowOpen: "WINDOW_OPEN.mp3",
            windowClose: "WINDOW_CLOSE.mp3",
            mailReceived: "APP_MAIL_RECEIVED.mp3",
            login: "SESSION_STARTUP.mp3",
            logout: "SESSION_LOGOUT.mp3",
            alert: "SYSTEM_ALARM.mp3",
            warning: "SYSTEM_WARNING.mp3",
            uploadComplete: "SYSTEM_UPLOAD_COMPLETE.mp3",
            click: "click.mp3",
            loaded: "SESSION_SWITCH_USERS.mp3"
        }
    },

    event: function(eventId) {
        if(Prefiniti.Sound.theme.events[eventId]) {
            let snd = "/sound/themes/" + Prefiniti.Sound.theme.name + "/" + Prefiniti.Sound.theme.events[eventId];
            let aud = new Audio(snd);
            try {
                //aud.play();
            }
            catch(ex) {
                console.log("Audio playback failed because Google is evil.")
            }
        }
    }

});