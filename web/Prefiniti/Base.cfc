component output=false extends="Prefiniti.LegacyAPI" displayname="Base" {

    public Prefiniti.Base function init() {
        return this;
    }

    public boolean function loggedIn() {
        
        if(!isDefined("session")) {
            return false;
        }

        if(!session.loggedin) {
            return false;
        }

        return true;


    }

    public numeric function getPercentage(numeric given, numeric max) output=false {
        if(max > 0) {
            return int((given * 100) / max);
        }
        else {
            return 0;
        }
    }

    public void function validateStruct(required struct s, required array r) output=false {

        for(i in r) {
            if(!s.keyExists(i)) {
                throw("The struct is missing required key " & i, "Error" , "Required keys are " & arguments.r.toList(", "));
            }
        }

    }

    public string function getFriendlyDuration(required date d) output=false {

        var minuteDiff = dateDiff("n", d, now());
        var hourDiff = dateDiff("h", d, now());
        var dayDiff = dateDiff("d", d, now());
        var weekDiff = dateDiff("w", d, now());
        var monthDiff = dateDiff("m", d, now());
        var yearDiff = dateDiff("yyyy", d, now());

        if(minuteDiff < 1) return "Just now";
        if(minuteDiff > 1 && minuteDiff < 25) return "A few minutes ago";
        if(minuteDiff >= 25 && minuteDiff < 40) return "About half an hour ago";
        if(minuteDiff >= 40 && minuteDiff < 80) return "About an hour ago";
        if(minuteDiff >= 80 && hourDiff < 24) return "A few hours ago";
        if(hourDiff >= 24 && hourDiff < 48) return "Yesterday";
        if(hourDiff >= 48 && dayDiff < 7) return dayDiff & " days ago";
        if(dayDiff >= 7 && dayDiff < 14) return "About a week ago";
        if(dayDiff >= 14 && monthDiff < 1) return weekDiff & " weeks ago";
        if(monthDiff == 1) return "About a month ago";
        if(monthDiff > 1 && monthDiff < 12) return monthDiff & " months ago";
        if(monthDiff >= 12 && yearDiff < 2) return "Last year";
        if(yearDiff >= 2) return yearDiff & " years ago"; 

    }

   

}