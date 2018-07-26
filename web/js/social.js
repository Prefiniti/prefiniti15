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

    friendSearchSuccess: function(data) {
        $("#generic-window").modal('hide');

        $("#tcTarget").html(data);
    }

});