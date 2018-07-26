Prefiniti.extend("Mail", {

    currentFolder: null,

    viewFolder: function(folder, startAt) {
        let url = "/mail/components/viewMailFolder.cfm?mailbox=" + folder + "&start_at=" + startAt;

        Prefiniti.loadPage(url, function() {

            Prefiniti.Mail.currentFolder = folder;

            $(".i-checks").iCheck({
                checkboxClass: 'icheckbox_square-green'
            });
        });
    },

    viewMessage: function(id) {
        let url = "/mail/components/viewMessage.cfm?id=" + id;

        Prefiniti.loadPage(url);
    },

    writeMessage: function(recipientId) {

        var url = "";

        if(!recipientId) {
            url = "/mail/components/writeMessage.cfm?mode=new";
        }
        else {
            url = "/mail/components/writeMessage.cfm?recipient_id=" + recipientId + "&mode=new";
        }

        Prefiniti.loadPage(url, function() {
            if(!recipientId) {
                Prefiniti.Mail.selectRecipient();
            }
        });
    },

    replyMessage: function(msgId) {

        let url = "/mail/components/writeMessage.cfm?msg_id=" + msgId + "&mode=reply";

        Prefiniti.loadPage(url, function () {

        });

    },

    selectRecipient: function() {
        let url = "/mail/components/select_recipient.cfm";

        Prefiniti.dialog(url);
    },

    recipientSelected: function() {
        let userId = $("#user-picker-selected_user_id-selection").val();

        let url = "/mail/components/get_mail_user.cfm?id=" + userId;

        $.get(url, function (data) {
    
            $("#mail-recipient-name").val(data.name);
            $("#mail-touser").val(userId);

            $("#generic-window").modal("hide");
        });
        
    },

    sendMessage: function() {

        let formData = {
            fromuser: $("#mail-fromuser").val(),
            touser: $("#mail-touser").val(),
            tsubject: $("#mail-subject").val(),
            tbody: $("#mail-body").val()
        };

        $.ajax({
            type: "POST",
            url: "/mail/components/writeMessageSubmit.cfm",
            data: formData,
            encode: true
        }).done(function(data) {
            console.log(data);

            toastr.options = {
                closeButton: true,
                progressBar: true,
                showMethod: 'slideDown',
                timeout: 2000
            };

            toastr.success("Message sent."); 

            Prefiniti.Mail.viewFolder("inbox", 1);
        });

    },

    toggleSelectAll: function() {
        if($("#messages-toggle-all").is(":checked")) {
            $(".message-checkbox").prop("checked", true);
        }
        else {
            $(".message-checkbox").prop("checked", false);
        }
    },


    deleteMessage: function(id) {
        let url = "/mail/components/modify_message.cfm?folder=" + Prefiniti.Mail.currentFolder;
        url += "&id=" + id + "&action=delete";

        $.get(url, function(data) {
            if(data.success) {
                $("#message-" + id).hide("slow");
            }
        });
    },

    deleteMessageFromView: function(id) {
        let url = "/mail/components/modify_message.cfm?folder=" + Prefiniti.Mail.currentFolder;
        url += "&id=" + id + "&action=delete";

        $.get(url, function(data) {
            if(data.success) {
                Prefiniti.Mail.viewFolder("inbox", 1);
            }
        });
    },

    markRead: function(id) {
        let url = "/mail/components/modify_message.cfm?folder=" + Prefiniti.Mail.currentFolder;
        url += "&id=" + id + "&action=read";

        $.get(url, function(data) {
            if(data.success) {
                $("#message-" + id).removeClass("unread").addClass("read");
            }
        });
    },

    markUnread: function(id) {
        let url = "/mail/components/modify_message.cfm?folder=" + Prefiniti.Mail.currentFolder;
        url += "&id=" + id + "&action=unread";

        $.get(url, function(data) {
            if(data.success) {
                $("#message-" + id).removeClass("read").addClass("unread");
            }
        });
    },

    deleteSelected: function() {
        let selected = Prefiniti.Mail.getSelectedMessages();

        for(index in selected) {
            Prefiniti.Mail.deleteMessage(selected[index]);
        }

    },

    markSelectedRead: function() {
        let selected = Prefiniti.Mail.getSelectedMessages();

        for(index in selected) {
            Prefiniti.Mail.markRead(selected[index]);
        }
    },

    markSelectedUnread: function() {
        let selected = Prefiniti.Mail.getSelectedMessages();

        for(index in selected) {
            Prefiniti.Mail.markUnread(selected[index]);
        }
    },

    getSelectedMessages: function() {

        let messages = [];

        $(".message-checkbox").each(function(index) {

            let msgId = $(this).attr("data-message-id");
            
            if($(this).is(":checked")) {
                messages.push(msgId);
            }
            
        });

        return messages;

    },

    searchMessages: function() {

        let searchTerms = $("#search-messages").val().toLowerCase();

        $(".mail-folder-row").each(function(index) {

            let person = $(this).attr("data-message-person").toLowerCase();
            let subject = $(this).attr("data-message-subject").toLowerCase();


            if(person.includes(searchTerms) || subject.includes(searchTerms)) {
                $(this).show("slow");
            }
            else {
                $(this).hide("slow");
            }
        });
    }

});