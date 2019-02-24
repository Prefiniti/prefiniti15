/*
* @Author: John P. Willis
* @Date:   2019-02-20 15:02:57
* @Last Modified by:   John P. Willis
* @Last Modified time: 2019-02-22 10:41:03
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

        Prefiniti.loadPage(url, Prefiniti.Resolutions.render);        
    },

    render: function() {
        console.log("Prefiniti.Resolutions.render() called");

        var doughnutData = {
            labels: $("#vote-tally").attr("data-labels").split(","),
            datasets: [{
                data: $("#vote-tally").attr("data-data").split(","),
                backgroundColor: $("#vote-tally").attr("data-colors").split(",")
            }]
        } ;            

        var doughnutOptions = {
            responsive: true,
            legend: {
                display: true,
                position: "right"
            }
        };


        var ctx4 = document.getElementById("vote-tally").getContext("2d");
        new Chart(ctx4, {type: 'doughnut', data: doughnutData, options:doughnutOptions});
    },

    itemCreated: function() {
        $("#generic-window").modal('hide');
        Prefiniti.reload();
    },

    castVote: function(res_id, vote_type) {
        let url = "/resolutions/components/cast_vote.cfm?res_id=" + res_id;
        url += "&vote_type=" + vote_type;

        Prefiniti.dialog(url);
    }

});