/*
* @Author: John P. Willis
* @Date:   2019-02-20 15:02:57
* @Last Modified by:   John P. Willis
* @Last Modified time: 2019-02-21 15:17:39
*/

Prefiniti.extend("Resolutions", {

    create: function() {
        Prefiniti.dialog('/resolutions/components/new_resolution.cfm');
    },

    viewAll: function() {
        todo();
    },

    view: function(id) {
        let url = "/resolutions/components/view_resolution.cfm?id=" + id;

        Prefiniti.loadPage(url);        
    },

    itemCreated: function() {
        $("#generic-window").modal('hide');
        Prefiniti.reload();
    }

});