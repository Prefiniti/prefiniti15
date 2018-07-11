Prefiniti.extend("Social", {

    loadProfile: function(userId) {
        Prefiniti.loadPage("/socialnet/components/view_profile.cfm?userid=" + userId);
    },

    friendSearch: function() {
        Prefiniti.dialog('/socialnet/components/search_users.cfm');
    },

    friendSearchSuccess: function(data) {
        $("#generic-window").modal('hide');

        $("#tcTarget").html(data);
    }

});