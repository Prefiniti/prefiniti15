/*
* @Author: John P. Willis
* @Date:   2019-02-20 15:02:57
* @Last Modified by:   John P. Willis
* @Last Modified time: 2019-02-27 16:54:15
*/

Prefiniti.extend("Resolutions", {

    create: function() {
        Prefiniti.dialog('/resolutions/components/new_resolution.cfm');
    },

    viewAll: function() {
        let url = "/resolutions/components/all_resolutions.cfm";

        Prefiniti.loadPage(url);
    },

    view: function(id) {
        let url = "/resolutions/components/view_resolution.cfm?id=" + id;

        Prefiniti.loadPage(url, Prefiniti.Resolutions.render);        
    },

    search: function() {

        let searchTerms = $("#search-resolutions").val().toLowerCase();

        $(".resolution-row").each(function(index) {

            let name = $(this).attr("data-resolution-title").toLowerCase();
          
            if(name.includes(searchTerms)) {
                $(this).show("slow");
            }
            else {
                $(this).hide("slow");
            }
        });
    },

    render: function() {
        console.log("Prefiniti.Resolutions.render() called");

        var doughnutData = {
            labels: $("#vote-tally").attr("data-labels").split(","),
            datasets: [{
                data: $("#vote-tally").attr("data-data").split(","),
                backgroundColor: $("#vote-tally").attr("data-colors").split(",")
            }]
        };            

        var doughnutOptions = {
            responsive: true,
            legend: {
                display: true,
                position: "right"
            }
        };

        var ctx4 = document.getElementById("vote-tally").getContext("2d");
        new Chart(ctx4, {type: 'doughnut', data: doughnutData, options:doughnutOptions});

        Prefiniti.renderMarkdown();
    },

    itemCreated: function() {
        $("#generic-window").modal('hide');
        Prefiniti.reload();
    },

    castVote: function(res_id, vote_type) {
        let url = "/resolutions/components/cast_vote.cfm?res_id=" + res_id;
        url += "&vote_type=" + vote_type;

        Prefiniti.dialog(url);
    },

    proposeAmendment: function(res_id) {
        let url = "/resolutions/components/propose_amendment.cfm?id=" + res_id;

        Prefiniti.dialog(url, () => {            

        });
    },

    adoptAmendment: function(res_id, amendment_id) {
        let url = "/resolutions/components/adopt_amendment.cfm?amendment_id=" + amendment_id + "&res_id=" + res_id;  
        
        $.get(url, (data) => {
            if(data.ok) {
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

            Prefiniti.reload();
        });

    },

    table: function(id) {
        let url = "/resolutions/components/table_resolution.cfm?id=" + id;

        $.get(url, (data) => {
            if(data.ok) {
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

            Prefiniti.reload();
        });
    },

    reopen: function(id) {
        let url = "/resolutions/components/reopen_resolution.cfm?id=" + id;

        $.get(url, (data) => {
            if(data.ok) {
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

            Prefiniti.reload();
        });
    },

    withdraw: function(id) {
        let url = "/resolutions/components/withdraw_resolution.cfm?id=" + id;

        Prefiniti.dialog(url);
    },

    withdrawn: function() {
        $("#generic-window").modal('hide');
        Prefiniti.Dashboard.load();
    },

    quorumChanged: function() {
        let quorumVal = parseInt($("#res-quorum").val());
        let max = parseInt($("#res-quorum").attr("max"));

        if(quorumVal > 0) {
            $("#quorum-value").val(quorumVal);       
        }
        else {
            $("#quorum-value").val("Quorum Disabled");
        }

        if(quorumVal === max) {
            $("#quorum-value").val("Full Participation");
        }


    },

    voterPoolChanged: function() {
        
        $.get("/resolutions/components/voter_pool.cfm", (data) => {
            let max = 0;
            let voterPoolVal = parseInt($("#res-eligibility").val());

            switch(voterPoolVal) {
                case 0: // employees only                    
                    max = data.employees;                    
                    break;
                case 1: // clients only                   
                    max = data.clients;                    
                    break;
                case 2: // everyone                    
                    max = data.everyone;                   
                    break;
            }

            $("#res-quorum").attr("max", max);
            let quorumVal = parseInt($("#res-quorum").val());

            if(quorumVal > max) {
                $("#res-quorum").val(max);
                $("#quorum-value").val(max);
            }
        });

    },

    toggleAmendment: function(id) {
        let amendment = "#amendment_" + id;
        let toggle = "#am_toggle_" + id;

        $(amendment).toggle();

        if($(amendment).is(":visible")) {
            $(toggle).attr("class", "fa fa-minus mr-3");
        }
        else {
            $(toggle).attr("class", "fa fa-plus mr-3");
        }
    }

});