component extends="Prefiniti.Base" {

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

                var qryChk = queryExecute("SELECT id FROM users WHERE email=:email", {email=url.email}, {datasource="webwarecl"});

                if(qryChk.recordCount > 0) {
                    return {
                        matches: qryChk.recordCount,
                        account: new Prefiniti.Authentication.UserAccount({id: qryChk.id}, false),
                        success: true,
                        email: url.email
                    };
                }
                else {
                    return {
                        matches: 0,
                        success: true,
                        email: url.email
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