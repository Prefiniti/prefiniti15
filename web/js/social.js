Prefiniti.extend("Social", {

    loadProfile: function(userId) {
        Prefiniti.loadPage("/socialnet/components/view_profile.cfm?userid=" + userId);
    },

    loadProfileByUsername: function(username) {        

    },

    friendSearch: function() {
        Prefiniti.dialog('/socialnet/components/search_users.cfm');
    },

    searchFriends: function() {
        
        let searchField = $("#search-field").val();
        let searchValue = $("#search-value").val();

        let url = "/socialnet/components/search_users_sub.cfm?search_field=" + searchField + "&search_value=" + searchValue;

        $("#generic-window").modal('hide');
        
        Prefiniti.loadPage(url);

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
            Prefiniti.getNotifications();
            Prefiniti.reload();
        });

    },

    cancelRequest(source_id, target_id) {

        $.ajax({
            type: "POST",
            url: "/socialnet/components/cancel_request.cfm",
            data: {
                source_id: source_id,
                target_id: target_id
            },
            encode: true
        }).done(function(data) {
            Prefiniti.getNotifications();
            Prefiniti.reload();
        });

    },

    acceptFriend: function(source_id, target_id) {

        $.ajax({
            type: "POST",
            url: "/socialnet/components/accept_friend.cfm",
            data: {
                source_id: source_id,
                target_id: target_id
            },
            encode: true
        }).done(function(data) {
            Prefiniti.getNotifications();
            Prefiniti.reload();
        });

    },

    rejectFriend: function(source_id, target_id) {

        $.ajax({
            type: "POST",
            url: "/socialnet/components/reject_friend.cfm",
            data: {
                source_id: source_id,
                target_id: target_id
            },
            encode: true
        }).done(function(data) {
            Prefiniti.getNotifications();
            Prefiniti.reload();
        });

    },

    deleteFriend: function(friend_id) {

        $.ajax({
            type: "POST",
            url: "/socialnet/components/delete_friend.cfm",
            data: {
                friend_id: friend_id
            },
            encode: true
        }).done(function(data) {
            Prefiniti.getNotifications();
            Prefiniti.reload();
        });
    },

    friendSearchSuccess: function(data) {
        $("#generic-window").modal('hide');

        $("#tcTarget").html(data);
    }

});