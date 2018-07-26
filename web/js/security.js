Prefiniti.extend("Security", {

    enableTfa: function() {
        let url = "/authentication/components/tfa_setup.cfm";

        Prefiniti.dialog(url);
    },

    disableTfa: function() {
        let url = "/authentication/components/disable_tfa.cfm";

        $.get(url, function(data) {
            $("#generic-window").modal("hide");
            Prefiniti.reload();
        });
    }

});