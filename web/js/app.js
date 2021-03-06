var Prefiniti = {

    state: {
        userId: null,
        currentPage: null,        
        history: []
    },

    extend: function(componentName, component) {
        if(!Prefiniti[componentName]) {
            Prefiniti[componentName] = component;
            console.log("Prefiniti framework extended with component [%s].", componentName);
        }
        else {
            throw("Prefiniti.extend():  name conflict [%s]; cannot extend.", componentName);
        }
    },

    welcome: function() {
        let url = "/framework/components/welcome.cfm";

        Prefiniti.dialog(url, function() {
            $(".i-checks").iCheck({
                checkboxClass: 'icheckbox_square-green'
            });

            $(".i-checks").on('ifChecked', function(event) {
                $.get("/framework/components/enable_welcome_screen.cfm", function(data) {});
            });
            $(".i-checks").on('ifUnchecked', function(event) {
                $.get("/framework/components/disable_welcome_screen.cfm", function(data) {});
            });
        });
    },

    
    notificationClicked: function(id) {
        console.log("Clicked notification id " + id);

        $.get("/Prefiniti/REST/Notifications.cfc?method=setViewed&id=" + id, function(data) {
            Prefiniti.getNotifications();

            try {
                $("#all-alerts-" + id).hide("slow");
            }
            catch(ex) {

            }
        });
    },

    getNotifications: function () {

        $.get("/Prefiniti/REST/Notifications.cfc?method=get", function(data) {
            
            let PMNotification = function(text, id) {

                this.bodyText = text;
                this.id = id;
                this.caption = "Geodigraph Hub";

                return this;

            };

            PMNotification.prototype.getHtml = function () {

                var html = '<li><div class="dropdown-item notification-item" onclick="Prefiniti.notificationClicked(' + this.id + ');">';

                html += this.bodyText;
                html += '</div></li><div class="dropdown-divider"></div>';

                return html;

            };

            PMNotification.prototype.alert = function () {

                /*var notifyOptions = {
                    body: "You have received a new Geodigraph Hub alert.",
                    icon: "/graphics/geodigraph-square.png",
                };

                if(Notification.permission === "granted") {
                    var notify = new Notification(this.caption, notifyOptions);

                    Notification.requestPermission(function (permission) {
                        if(permission === "granted") {
                            var notify = new Notification(this.caption, notifyOptions);
                        }
                        else {
                            
                        }
                    });
                }*/               

                toastr.options = {
                    closeButton: true,
                    progressBar: true,
                    showMethod: 'slideDown',
                    timeout: 2000
                };

                toastr.success(this.bodyText);           

                Prefiniti.Sound.event("alert");                                                    
            };

            
            $("#dropdown-alerts-menu").empty().html("");

            var shownCount = 0;

            for(index in data.notifications) {

                var itm = data.notifications[index];
                var notification = new PMNotification(itm.notification_text, itm.id);

                if(itm.delivered === 0) {
                    notification.alert();
                }

                if(itm.viewed !== 1) {
                    if(shownCount <= 5) {
                        $("#dropdown-alerts-menu").append(notification.getHtml());
                    }
                    shownCount++;
                }

            }

            if(data.new == 0) {
                $("#badge-alerts-unread").hide();
            }
            else {
                $("#badge-alerts-unread").show();
                $("#badge-alerts-unread").empty().html(data.new);
            }


        });

        $.get("/framework/components/sitestats_json.cfm", function(data) {
            let notifyTotal = 0;

            for(key in data) {
                notifyTotal += data[key];
            }

            notifyTotal -= data.unreadMail;
            notifyTotal -= data.newFriendRequests;

           

            $("#badge-messages-unread-side").empty().html(data.unreadMail);
            $("#badge-messages-unread-top").empty().html(data.unreadMail);
            //$("#badge-messages-total").html(data.TOTALMAIL);
            $("#badge-friend-requests").empty().html(data.newFriendRequests);
            $("#badge-notifications").empty().html(notifyTotal);

            
            if(data.newFriendRequests === 0) {
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
            $("#dropdown-messages-menu").empty().html(data);
        });

        $.get("/socialnet/components/friend_requests_dropdown.cfm", function(data) {
            $("#dropdown-friend-requests-menu").empty().html(data);
        })

    },

    onLoad: function() {

        Prefiniti.getNotifications();

        setInterval(Prefiniti.getNotifications, 30000);

        Prefiniti.home();

        setTimeout(function() {            
            Prefiniti.Sound.event("login");
        }, 1000);

        $("a").click(function() {
            Prefiniti.Sound.event("click");
        });

        $("button").click(function() {
            Prefiniti.Sound.event("click");
        });

    },

    home: function() {
        $.get("/api/session", function(data) {

            if(data.success) {

                switch(data.session.user.remember_page) {
                    case 0:
                        Prefiniti.Dashboard.load();
                        break;
                    case 1:
                        Prefiniti.Social.loadProfile(data.session.user.id);
                        break;
                    case 2:
                        Prefiniti.loadPage(data.session.user.last_loaded_page);
                        break;
                }

            }
            else {
                console.log(data.message);
                Prefiniti.Dashboard.load();
            }

        });
    },

    

    setAssociation: function(assocId) {
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
        Prefiniti.loadPage('/contentManager/components/cms_browse.cfm');
    },


    loadPage: function(url, onLoaded, onError) {

        Prefiniti.reload = function() {
            Prefiniti.loadPage(Prefiniti.state.currentPage, onLoaded || null, onError || null);
        };

        let startTime = new Date().getTime();

        console.log("Prefiniti.loadPage(): loading " + url);
        
        Prefiniti.onNavLoading();

        onLoaded = onLoaded || function (){};
        onError = onError || function (){};

        $.ajax({
            url: url,
            method: "GET", 
            success: function(data) {

                let endTime = new Date();                                                

                Prefiniti.updateNavigation(url, data);
                Prefiniti.renderContent(data);    
                Prefiniti.onNavComplete(url, data);                            

                onLoaded(data);

                $("#tcTarget a").click(function() {
                    Prefiniti.Sound.event("click");
                });

                $("#tcTarget button").click(function() {
                    Prefiniti.Sound.event("click");
                });

                
            },
            error: function(data) {
                Prefiniti.onNavError(data);

                onError(data);
            }
        });

    },

    onNavLoading: function() {
        $("#prefiniti-reload").hide();
        $("#prefiniti-loading").show();
        $("#tcTarget").empty().html("");
        $("#wwaf-page-title").empty().html("Please Wait");
        $("#wwaf-breadcrumbs").empty().html("Loading...");
    },

    onNavError: function(data) {

    },

    onNavComplete: function(url, data) {
        $("#prefiniti-loading").hide();
        $("#prefiniti-reload").show();

        $.ajax({
            url: "/framework/components/update_last_loaded_page.cfm",
            method: "POST",
            data: {
                url: url,
                onload: Prefiniti.state.currentPageOnLoad,
                onerror: Prefiniti.state.currentPageOnError
            },
            encode: true
        });

    },

    updateNavigation: function(url, data) {
        Prefiniti.state.currentPage = url;
        
        let metadata = Prefiniti.parseFragmentMetadata(data);             

        if(!metadata.title) {
            $("#wwaf-page-title").hide();
        }
        else {
            $("#wwaf-page-title").empty().show();
            $("#wwaf-page-title").empty().html(metadata.title);
        }

        if(!metadata.breadcrumbs) {
            $("#wwaf-breadcrumbs").hide();
        }
        else {
            $("#wwaf-breadcrumbs").show();
            $("#wwaf-breadcrumbs").empty().html(metadata.breadcrumbs);
        }

        return metadata;
    },

    renderContent: function(data) {
        $("#tcTarget").empty();
        $("#tcTarget").html(data);

        $('.summernote').summernote({
            height: 200
        });

        $('.tagsinput').tagsinput({
            tagClass: 'badge badge-primary'
        });

        $('.datatables').DataTable({
            pageLength: 25,
            responsive: true
        });

        $("span.pie").peity("pie", {
            fill: ['#1ab394', '#d7d7d7', '#ffffff']
        });
        
    },

    dialog: function(url, onLoad)
    {   
        console.log("Prefiniti.dialog(): loading " + url);

        $("#gen-window-area").empty().html("");

        $("#generic-window").on("hide.bs.modal", function() {
            Prefiniti.Sound.event("windowClose");
        });
        
        $.ajax({
            method: "GET",
            url: url,
            success: function(data) {
                $("#gen-window-area").empty().html(data);
                $("#generic-window").modal();  

                if(onLoad) onLoad();

                $("#generic-window").find("form").submit((event) => { return false; });

                Prefiniti.Sound.event("windowOpen");
            },
            error: function(data) {
                console.log("Prefiniti.dialog():  error %o", data);
            }
        });
            
    },

    parseFragmentMetadata: function(html) {

        let re_title = new RegExp("<wwaftitle>[\n\r\s]*(.*)[\n\r\s]*</wwaftitle>", "gmi");
        let re_breadcrumbs = new RegExp("<wwafbreadcrumbs>[\n\r\s]*(.*)[\n\r\s]*</wwafbreadcrumbs>", "gmi");

        let title = re_title.exec(html);
        var breadcrumbs = re_breadcrumbs.exec(html);

        var result = {};

        if(title) {
            result.title = title[1];
        }
        else {
            result.title = null;
        }


        if(breadcrumbs) {
            breadcrumbs = breadcrumbs[1].split(",");
            var bchtml = "";

            for(i in breadcrumbs) {
                bc = breadcrumbs[i];

                bchtml += '<li class="breadcrumb-item"><a href="##">' + bc + '</a></li>';
            }

            result.breadcrumbs = bchtml;
        }
        else {
            result.breadcrumbs = null;
        }


        return result;
    },

    revealCommentBox: function(baseId) {
        $('#user-post-comment-' + baseId).show(); 
        $('#comment-body-copy-' + baseId).select();
    },

    cancelComment: function(baseId) {
        $('#comment-body-copy-' + baseId).val("");
        $('#user-post-comment-' + baseId).hide();
    },

    submitComment: function(baseId) {
        let formData = {
            parent_post_id: $("#comment-parent-" + baseId).val(),
            author_id: $("#comment-from-" + baseId).val(),
            recipient_id: $("#comment-to-" + baseId).val(),
            body_copy: $("#comment-body-copy-" + baseId).val(),
            post_class: $("#comment-post-class-" + baseId).val()
        };

        console.log(formData);

        $.ajax({
            type: "POST",
            url: "/socialnet/components/post_comment_sub.cfm",
            data: formData,
            encode: true
        }).done(function(data) {
            console.log(data);

            Prefiniti.reload();
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
            body_copy: $("#post-reply-body-" + id).val(),
            post_class: $("#post-reply-post-class-" + id).val()
        };

        $.ajax({
            type: "POST",
            url: "/socialnet/components/post_comment_sub.cfm",
            data: formData,
            encode: true
        }).done(function(data) {
            Prefiniti.reload();
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
            Prefiniti.reload();
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
            Prefiniti.reload();
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
            Prefiniti.reload();
        });

    },

    

    loadPersonDetail: function(id, mode) {

        $.ajax({
            type: "GET",
            url: "/businessnet/components/person_detail.cfm",
            data: {
                user_id: id,
                mode: mode
            },
            encode: true
        }).done(function(data) {
            $("#contact-detail").empty().html(data);
            $("span.pie").peity("pie", {
                fill: ['#1ab394', '#d7d7d7', '#ffffff']
            });
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
                $(contentEl).empty().html(data);
                $(viewEl).show();
            });
        });

        $(editEl).val($(contentEl).empty().html());

        $(viewEl).hide();
        $(editEl).show();
        $(editEl).select();
    },

    deleteLocation: function(id) {

        $.ajax({
            type: "POST",
            url: "/socialnet/components/profile_manager/location_delete_sub.cfm",
            data: {id: id},
            dataType: "json",
            encode: true
        }).done(function(data) {
            if(data.ok) {
                $("#location-row-" + id).hide();
                toastr.options = {
                    closeButton: true,
                    progressBar: true,
                    showMethod: 'slideDown',
                    timeout: 2000
                };

                toastr.success(data.message);
            }
            else {
                toastr.options = {
                    closeButton: true,
                    progressBar: true,
                    showMethod: 'slideDown',
                    timeout: 2000
                };
                
                toastr.error(data.message);
            }
        });

    },

    submitForm: function(formId, onSuccess, onError) {
        let selector = "#" + formId;
        let formDataInput = $(selector).serializeArray();
        let method = $(selector).attr("method");
        let action = $(selector).attr("action");

        var formData = {};

        for(index in formDataInput) {
            formData[formDataInput[index].name] = formDataInput[index].value;
        }

        console.log("Submitting form %s (method = %s, action = %s)", formId, method, action);
        console.log("Form data: %o", formData);

        $.ajax({
            type: method,
            url: action,
            data: formData,
            dataType: "json",
            encode: true
        }).done(function(data) {
            if(data.ok) {
                toastr.options = {
                    closeButton: true,
                    progressBar: true,
                    showMethod: 'slideDown',
                    timeout: 2000
                };

                toastr.success(data.message);

                if(onSuccess) {
                    onSuccess(data);
                }

                //console.log(data);
            }
            else {
                //console.log(data);
                if(data.error) {
                    console.log("Error detail: %o", data.error);
                }

                toastr.options = {
                    closeButton: true,
                    progressBar: true,
                    showMethod: 'slideDown',
                    timeout: 2000
                };
                
                
                toastr.error(data.message);
            }
        });
    },

    searchPeople: function() {
        let searchTerms = $("#search-people").val().toLowerCase();

        $(".person-row").each(function(index) {
            let name = $(this).attr("data-person-full-name").toLowerCase();

            if(name.includes(searchTerms)) {
                $(this).show();
            }
            else {
                $(this).hide();
            }
        });
    },

    beginAcctLookup: function() {
        Prefiniti.dialog('/webware_admin/account_lookup.cfm');
    },

    locateAccount: function() {
        $.get("/api/account/" + $("#acct-lookup-email").val(), (data) => {
            console.log(data);
        });
    },

    renderMarkdown: function() {
        let converter = new showdown.Converter();

        $(".markdown").each(function(index) {
           var text = $(this).html();
           var html = converter.makeHtml(text);
           $(this).html(html);
        });
    }


};

function todo()
{
    Prefiniti.dialog('/framework/components/todo.cfm');
}