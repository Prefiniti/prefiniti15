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
                return {
                    success: true,
                    session: session
                };
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