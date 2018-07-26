component extends="Prefiniti.Base" output="false" {
    
    public Prefiniti.Authentication.UserAccount function init(required struct user, required boolean isNew) output=false {
        
        this.id = "";
        this.username = "";
        this.password =""
        this.longName = "";
        this.email = "";
        this.smsNumber = "";
        this.picture = "";
        this.account_enabled = 0;
        this.gender = "";
        this.bio = "";
        this.title = "";
        this.confirm_id = createUUID();
        this.phone = "";
        this.fax = "";
        this.confirmed = 0;
        this.online = 0;
        this.sms_conf = "";
        this.sms_confirmed = 0;
        this.last_pwchange = createODBCDateTime(Now());
        this.expired = 0;
        this.last_loaded_page = "";
        this.remember_page = 0;
        this.firstName = "";
        this.lastName = "";
        this.webware_admin = 0;
        this.middleInitial = " ";
        this.allowSearch = 0;
        this.birthday = "";
        this.profile_views = 0;
        this.last_login = "";
        this.show_tour = 1;
        this.last_site_id = 0;
        this.last_event = "";
        this.background = "";
        this.interests = "";
        this.music = "";
        this.last_song = "";
        this.relationship_status = "";
        this.so_id = 0;
        this.zip_code = 88001;
        this.last_assoc_id = 0;
        this.password_question = "";
        this.password_answer = "";
        this.status = "";

        this.maps_username = "";
        this.maps_password = "";
       

        if(!arguments.isNew) {
            var requiredKeys = [];

            if(!arguments.user.keyExists("id") && !arguments.user.keyExists("username")) {
                throw("You must supply either username or id");
            }            
        }
        else {
            var requiredKeys = ["email", 
                                "firstName", 
                                "lastName"];            
        }

        validateStruct(arguments.user, requiredKeys);

        if(!arguments.isNew) {
            if(isDefined("arguments.user.username")) {
                var qry = queryExecute("SELECT * FROM users WHERE username=:username", {username=arguments.user.username}, {datasource="webwarecl"});
            }
            else {
                var qry = queryExecute("SELECT * FROM users WHERE id=:id", {id=arguments.user.id}, {datasource="webwarecl"});
            }

            this.profileQuery = qry;
            this.id = qry.id;
            this.username = qry.username;
            this.password = qry.password;
            this.longName = qry.longName;
            this.email = qry.email;
            this.smsNumber = qry.smsNumber;
            this.picture = qry.picture;
            this.account_enabled = qry.account_enabled;
            this.gender = qry.gender;
            this.bio = qry.bio;
            this.title = qry.title;
            this.confirm_id = qry.confirm_id;
            this.phone = qry.phone;
            this.fax = qry.fax;
            this.confirmed = qry.confirmed;
            this.online = qry.online;
            this.sms_conf = qry.sms_conf;
            this.sms_confirmed = qry.sms_confirmed;
            this.last_pwchange = qry.last_pwchange;
            this.last_loaded_page = qry.last_loaded_page;
            this.remember_page = qry.remember_page;
            this.firstName = qry.firstName;
            this.lastName = qry.lastName;
            this.webware_admin = qry.webware_admin;
            this.middleInitial = qry.middleInitial;
            this.allowSearch = qry.allowSearch;
            this.birthday = qry.birthday;
            this.profile_views = qry.profile_views;
            this.last_login = qry.last_login;
            this.show_tour = qry.show_tour;
            this.last_site_id = qry.last_site_id;
            this.last_event = qry.last_event;
            this.background = qry.background;
            this.interests = qry.interests;
            this.music = qry.music;
            this.last_song = qry.last_song;
            this.relationship_status = qry.relationship_status;
            this.so_id = qry.so_id;
            this.zip_code = qry.zip_code;
            this.last_assoc_id = qry.last_assoc_id;
            this.password_question = qry.password_question;
            this.password_answer = qry.password_answer;
            this.status = qry.status;            
            this.tfa_enabled = qry.tfa_enabled;
            this.tfa_secret = qry.tfa_secret;

            this.maps_username = qry.maps_username;
            this.maps_password = qry.maps_password;

        }
        else {
            // new account
            
            var longName = "";
            var middleInitial = " ";

            if(structKeyExists(user, "middleInitial")) {
                longName = user.firstName & " " & user.middleInitial & ". " & user.lastName;
            }
            else {
                longName = user.firstName & " " & user.lastName;
            }

            var qrySql = "INSERT INTO users (username, longName, email, firstName, middleInitial, lastName, confirm_id) ";
            var qrySql = qrySql & "VALUES (:username, :longName, :email, :firstName, :middleInitial, :lastName, :confirm_id)"

            var qry = queryExecute(qrySql, {
                username = user.email,
                longName = longName,
                email = user.email,
                firstName = user.firstName,
                middleInitial = middleInitial,
                lastName = user.lastName,
                confirm_id = this.confirm_id
            }, {datasource="webwarecl"});

            var qrySql = "SELECT id FROM users WHERE confirm_id=:confirm_id";
            var userQry = queryExecute(qrySql, {confirm_id=this.confirm_id}, {datasource="webwarecl"});

            var basePath = expandPath("/UserContent");

            directoryCreate(basePath & "/" & user.email);
            directoryCreate(basePath & "/" & user.email & "/profile_images");
            directoryCreate(basePath & "/" & user.email & "/project_files");


            var acct = new Prefiniti.Authentication.UserAccount({id: userQry.id}, false);

            var assoc_id = acct.addSiteAssociation(5, "client");

            var initialPerms = ["AS_LOGIN",
                                "MA_VIEW",
                                "MA_WRITE"];

            for(permKey in initialPerms) {
                acct.grantPermission(assoc_id, permKey);
            }

            acct.sendConfirmation();

            return new Prefiniti.Authentication.UserAccount({id: userQry.id}, false);
        }

        return this;
    }

    public void function sendConfirmation() output=false {

        var message = new Prefiniti.MailTemplate("verify_account", this.email, "Geodigraph PM Account Verification", {
            firstName: this.firstName,
            confirm_id: this.confirm_id
        });

        message.send();

    }

    public boolean function mapsLogin() output=false {

        if(this.maps_username == "") return false;
        if(this.maps_password == "") return false;

        var apiUrl = "https://maps.geodigraph.com/api/auth/"

        try {
            cfhttp(method="POST", charset="utf-8", url="#apiUrl#", result="result") {
                cfhttpparam(name="username", type="formfield", value="#this.maps_username#");
                cfhttpparam(name="password", type="formfield", value="#this.maps_password#");
                cfhttpparam(name="hashed", type="formfield", value="true");
            }

            return true;
        }
        catch(any ex) {
            return false;
        }

    }

    public string function enableTFA() output=false {

        var tfa = new Prefiniti.Authentication.GoogleAuthenticator();
        var key = tfa.generateKey(this.password);

        var qrySql = "UPDATE users SET tfa_enabled=1, tfa_secret=:tfa_secret WHERE id=:id";
        var result = queryExecute(qrySql, {tfa_secret=key, id=this.id}, {datasource="webwarecl"});

        this.tfa_secret = key;
        this.tfa_enabled = 1;
        
        return this.tfaQRCodeURL();
    }

    public void function disableTFA() output=false {

        var qrySql = "UPDATE users SET tfa_enabled=0, tfa_secret=:tfa_secret WHERE id=:id";
        var result = queryExecute(qrySql, {tfa_secret="", id=this.id}, {datasource="webwarecl"});

        this.tfa_secret = "";
        this.tfa_enabled = 0;
        
    }

    public string function tfaQRCodeURL() output=false {
        var tfa = new Prefiniti.Authentication.GoogleAuthenticator();

        var otpurl = tfa.getOTPURL("GeodigraphPM", this.tfa_secret);

        return tfa.getOTPQRURL(otpurl);
    }

    public struct function getRoles() output=false {
        var result = {};

        var qry = this.getAssociationsByUser(this.id);

        for(row in qry) {
           
            if(row.assoc_type == 0) {
                result[row.site_id].client = row.id;
            }
            if(row.assoc_type == 1) {
                result[row.site_id].employee = row.id;
            }
        }

        return result;
    }

    public array function getUserPosts() output=false {

        var result = [];
        var qrySql = "SELECT id FROM posts WHERE recipient_id=:id AND parent_post_id=0 ORDER BY post_date DESC";
        var postRecords = queryExecute(qrySql, {id=this.id}, {datasource="webwarecl"});

        for(post in postRecords) {
            var postObj = new Prefiniti.SocialNetworking.Post();
            postObj = postObj.retrieve(post.id);
            result.append(postObj);
        }

        return result;

    }

    public string function getPicture() output=false {

        if(this.picture == "") {
            if(this.gender == "M") {
                return "https://ssl.gstatic.com/accounts/ui/avatar_2x.png";
            }
            else if (this.gender == "F") {
                return "https://ssl.gstatic.com/accounts/ui/avatar_2x.png";
            }
            else {
                return "https://ssl.gstatic.com/accounts/ui/avatar_2x.png";
            }
        }
        else {
            return this.picture;
        }

    }

    public void function requestFriend(required Prefiniti.Authentication.UserAccount requester) {
        
        var qrySql = "SELECT id FROM friends WHERE source_id=:source_id AND target_id=:target_id";
        var chkReq = queryExecute(qrySql, {source_id=arguments.requester.id, target_id=this.id}, {datasource="webwarecl"});

        if(chkReq.recordCount == 0) {
            qrySql = "INSERT INTO friends (source_id, target_id, request_date, confirmed) ";
            qrySql = qrySql & "VALUES (:source_id, :target_id, #createODBCDateTime(now())#, 0)";

            queryExecute(qrySql, {source_id=arguments.requester.id, target_id=this.id}, {datasource="webwarecl"});
        }

        ntNotify(this.id, "SN_FRIEND_REQUEST", "#arguments.requester.longName# has requested to be your friend.", "");

    }

    public void function acceptFriendRequest(required Prefiniti.Authentication.UserAccount requester) {


        var qrySql = "UPDATE friends SET confirmed=1 WHERE source_id=:source_id AND target_id=:target_id";
        queryExecute(qrySql, {source_id=arguments.requester.id, target_id=this.id}, {datasource="webwarecl"});

        qrySql = "INSERT INTO friends (source_id, target_id, request_date, confirmed) ";
        qrySql = qrySql & "VALUES (:source_id, :target_id, #createODBCDateTime(now())#, 1)";

        queryExecute(qrySql, {source_id=this.id, target_id=arguments.requester.id}, {datasource="webwarecl"});

        ntNotify(arguments.requester.id, "SN_FRIEND_ACCEPT", "#this.longName# has accepted you as a friend.", "");

        var eventText = this.longName & " and " & arguments.requester.longName & " are now friends.";

        writeUserEvent(this.id, "heart_add.png", eventText);
        if(this.id != arguments.requester.id) {
            writeUserEvent(arguments.requester.id, "heart_add.png", eventText);
        }

    }

    public void function rejectFriendRequest(required Prefiniti.Authentication.UserAccount requester) {

        var qrySql = "DELETE FROM friends WHERE source_id=:source_id AND target_id=:target_id";
        queryExecute(qrySql, {source_id=arguments.requester.id, target_id=this.id}, {datasource="webwarecl"});
    
        ntNotify(arguments.requester.id, "SN_FRIEND_REJECT", "#this.longName# has rejected your friend request.", "");

        var eventText = this.longName & " has rejected " & arguments.requester.longName & "'s friend request.";
        
        writeUserEvent(this.id, "heart_delete.png", eventText);
        if(this.id != arguments.requester.id) {
            writeUserEvent(arguments.requester.id, "heart_delete.png", eventText);
        }

    }

    public void function deleteFriend(required Prefiniti.Authentication.UserAccount friend) {

        var qrySql = "DELETE FROM friends WHERE source_id=:source_id AND target_id=:target_id";
        queryExecute(qrySql, {source_id=this.id, target_id=arguments.friend.id}, {datasource="webwarecl"});

        qrySql = "DELETE FROM friends WHERE source_id=:target_id AND target_id=:source_id";
        queryExecute(qrySql, {source_id=this.id, target_id=arguments.friend.id}, {datasource="webwarecl"});

        ntNotify(arguments.friend.id, "SN_FRIEND_DELETE", "#this.longName# has deleted you as a friend.", "");

        var eventText = this.longName & " and " & arguments.friend.longName & " are no longer friends.";
        
        writeUserEvent(this.id, "heart_delete.png", eventText);
        if(this.id != arguments.friend.id) {
            writeUserEvent(arguments.friend.id, "heart_delete.png", eventText);
        }

    }

    public array function getFriends() {

        var result = [];
        var qrySql = "SELECT * FROM friends WHERE source_id=:source_id AND confirmed=1";
        var friends = queryExecute(qrySql, {source_id=this.id}, {datasource="webwarecl"});

        for(friend in friends) {
            result.append(new Prefiniti.Authentication.UserAccount({id: friend.target_id}, false));
        }

        return result;

    }

    public numeric function addSiteAssociation(required numeric site_id, required string assoc_type) {

        var assocType = "";
        var notifyAssoc = "";

        switch(arguments.assoc_type) {
            case "employee": 
                assocType = 1; 
                notifyAssoc = "an employee";
                break;
            case "client": 
                assocType = 0; 
                notifyAssoc = "a client";
                break;
        }

        var confID = createUUID();
        var qrySql = "INSERT INTO site_associations (user_id, site_id, assoc_type, conf_id) ";
        qrySql = qrySql & "VALUES (:user_id, :site_id, :assoc_type, :conf_id)";

        var res = queryExecute(qrySql, {user_id=this.id, site_id=arguments.site_id, assoc_type=assocType, conf_id=confID}, {datasource="sites"});

        qrySql = "SELECT id FROM site_associations WHERE conf_id=:conf_id";

        var result = queryExecute(qrySql, {conf_id=confID}, {datasource="sites"});
        var siteName = this.getSiteNameByID(arguments.site_id);
        
        var message = new Prefiniti.MailTemplate("new_association", this.email, "Company Membership Added", {
            siteName: siteName,
            firstName: this.firstName,
            assocType: notifyAssoc
        });
        message.send();


        return result.id;

    }

    public void function removeSiteAssociation(required numeric site_id, required string assoc_type) {

        var assocType = "";

        switch(arguments.assoc_type) {
            case "employee": assocType = 1; break;
            case "client": assocType = 0; break;
        }

        var qrySql = "DELETE FROM site_associations WHERE site_id=:site_id AND assoc_type=:assoc_type";
        var res = queryExecute(qrySql, {site_id=arguments.site_id, assoc_type=assocType}, {datasource="sites"});

    }

    public void function grantPermission(required numeric assoc_id, required string permission_key) {

        cfstoredproc(procedure="grantPermission", datasource="sites") {
            cfprocparam(cfsqltype="CF_SQL_BIGINT", value=arguments.assoc_id);
            cfprocparam(cfsqltype="CF_SQL_VARCHAR", value=arguments.permission_key)
        }

    }

    public numeric function getUnreadMessageCount() {
        
        var qrySql = "SELECT id FROM messageinbox WHERE touser=:touser AND tread=0 AND draft=0 AND deleted_recipient_inbox=0";
        var result = queryExecute(qrySql, {touser=this.id}, {datasource="webwarecl"});

        return result.recordCount;
    }

    public array function getInboxMessages() {

        var result = [];

        var qrySql = "SELECT id FROM messageinbox WHERE touser=:touser AND draft=0 ORDER BY tdate DESC";
        var messages = queryExecute(qrySql, {touser=this.id}, {datasource="webwarecl"});

        for(message in messages) {
            var msg = new Prefiniti.PrivateMessage(message.id);

            if(msg.deleted_recipient_inbox != 1 && msg.draft == 0) {
                result.append(msg);
            }
        }

        return result;
    }

    public array function getOutboxMessages() {

        var result = [];

        var qrySql = "SELECT id FROM messageinbox WHERE fromuser=:fromuser AND draft=0";
        var messages = queryExecute(qrySql, {fromuser=this.id}, {datasource="webwarecl"});

        for(message in messages) {
            var msg = new Prefiniti.PrivateMessage(message.id);
            if(msg.deleted_sender_outbox != 1 && msg.draft == 0) {
                result.append(msg);
            }
        }

        return result;
    }

    public array function getDraftMessages() {

        var result = [];

        var qrySql = "SELECT id FROM messageinbox WHERE fromuser=:fromuser";
        var messages = queryExecute(qrySql, {fromuser=this.id}, {datasource="webwarecl"});

        for(message in messages) {
            var msg = new Prefiniti.PrivateMessage(message.id);
            if(msg.deleted_sender_outbox != 1 && msg.draft == 1) {
                result.append(msg);
            }
        }

        return result;
    }

}