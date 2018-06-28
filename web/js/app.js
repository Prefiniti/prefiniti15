var Prefiniti = {
    
    state: {
        userId: glob_userid
    },

    getNotifications: function () {

        $.get("/framework/components/sitestats_json.cfm", function(data) {
            let notifyTotal = 0;

            for(key in data) {
                notifyTotal += data[key];
            }

            notifyTotal -= data.UNREADMAIL;
            notifyTotal -= data.NEWFRIENDREQUESTS;

            $("#badge-messages").html(data.UNREADMAIL);
            $("#badge-friend-requests").html(data.NEWFRIENDREQUESTS);
            $("#badge-notifications").html(notifyTotal);

            if(data.UNREADMAIL === 0) {
                $("#badge-messages").hide();
            }
            else {
                $("#badge-messages").show();
            }

            if(data.NEWFRIENDREQUESTS === 0) {
                $("#badge-friend-requests").hide();
            }
            else {
                $("#badge-friend-requests").show();
            }

            if(notifyTotal === 0) {
                $("#badge-notifications").hide();
            }
            else {
                $("#badge-notifications").show();
            }
        });

        $.get("/mail/components/mail_dropdown.cfm", function(data) {
            $("#dropdown-mail-menu").html(data);
        });

    },

    onLoad: function() {

        setInterval(Prefiniti.getNotifications, 3000);


        loadHomeView();
    },

    setAssociation: function(assocId) {
        console.log(assocId);

        $("#ss-assoc").val(assocId);
        $("#ss-form").submit();
    },

    submitUpload: function() {
        $("#cms-upload-button").hide();
        $("#cms-upload-status").show();
        $("#cms-upload-frame").on("load", Prefiniti.uploadDone);
        $("#cms-upload-form").submit();
    },

    uploadDone: function(tgt) {
        toastr.options = {
            closeButton: true,
            positionClass: "toast-bottom-right"
        };
        
        toastr.info('Upload complete');
        AjaxLoadPageToDiv('tcTarget', '/contentManager/components/cms_browse.cfm');
    },

    viewProfile: function(userid) {
        AjaxLoadPageToDiv('tcTarget', '/authentication/components/viewProfile.cfm?userid=' + userid);
    },

    loadPage: function(url, opts) {
        let success = opts.onSuccess || function() { return true };
        let error = opts.onError || function() { return true };

    },

    revealCommentBox: function() {
        $('#user-post-comment').show(); 
        $('#comment-body-copy').select();
    },

    cancelComment: function() {
        $('#comment-body-copy').val("");
        $('#user-post-comment').hide();
    },

    submitComment: function() {
        let formData = {
            parent_post_id: $("#comment-parent").val(),
            author_id: $("#comment-from").val(),
            recipient_id: $("#comment-to").val(),
            body_copy: $("#comment-body-copy").val()
        };

        $.ajax({
            type: "POST",
            url: "/socialnet/components/post_comment_sub.cfm",
            data: formData,
            encode: true
        }).done(function(data) {
            console.log(data);

            Prefiniti.viewProfile(formData.recipient_id);
        });
    },

    revealPostReply: function(id) {
        $("#post-reply-" + id).show();
        $("#post-reply-body-" + id).select();
    },

    replyPost: function(id) {
        let formData = {
            parent_post_id: $("#post-reply-parent-" + id).val(),
            author_id: $("#post-reply-author-" + id).val(),
            recipient_id: $("#post-reply-recipient-" + id).val(),
            body_copy: $("#post-reply-body-" + id).val()
        };

        $.ajax({
            type: "POST",
            url: "/socialnet/components/post_comment_sub.cfm",
            data: formData,
            encode: true
        }).done(function(data) {
            Prefiniti.viewProfile(formData.recipient_id);
        });
    },

    likePost: function(id, userId) {

        $.ajax({
            type: "POST",
            url: "/socialnet/components/react_to_post.cfm",
            data: {
                post_id: id,
                reaction: "like"
            },
            encode: true
        }).done(function(data) {
            Prefiniti.viewProfile(userId);
        });

    },

    dislikePost: function(id, userId) {

         $.ajax({
            type: "POST",
            url: "/socialnet/components/react_to_post.cfm",
            data: {
                post_id: id,
                reaction: "dislike"
            },
            encode: true
        }).done(function(data) {
            Prefiniti.viewProfile(userId);
        });

    },

    deletePost: function(id, userId) {

        $.ajax({
            type: "POST",
            url: "/socialnet/components/delete_post.cfm",
            data: {
                post_id: id
            },
            encode: true
        }).done(function(data) {
            Prefiniti.viewProfile(userId);
        });

    },

    requestFriend: function(source_id, target_id) {

        $.ajax({
            type: "POST",
            url: "/socialnet/components/request_friend.cfm",
            data: {
                source_id: source_id,
                target_id: target_id
            },
            encode: true
        }).done(function(data) {
            Prefiniti.viewProfile(target_id);
        });
    },

    showEditIcon: function(baseId) {
        let el = "#" + baseId + "-editicon";

        $(el).show();
    },

    hideEditIcon: function(baseId) {
        let el = "#" + baseId + "-editicon";

        $(el).hide();
    },

    beginEditingField: function(baseId) {

        let viewEl = "#" + baseId + "-view";
        let editEl = "#" + baseId + "-edit";
        let contentEl = "#" + baseId + "-content";

        let editUrl = "/field_editors/" + baseId + ".cfm";


        $(editEl).blur(function () {            

            $.post(editUrl, {
                newValue: $(editEl).val()
            }).done(function(data) {                
                $(editEl).hide();
                $(contentEl).html(data);
                $(viewEl).show();
            });
        });

        $(editEl).val($(contentEl).html());

        $(viewEl).hide();
        $(editEl).show();
        $(editEl).select();
    }


};