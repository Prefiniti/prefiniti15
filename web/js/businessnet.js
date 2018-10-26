Prefiniti.extend("Business", {

	timeEntries: function(criteria) {
		let url = "/businessnet/components/time_entries.cfm?criteria=" + criteria;

		Prefiniti.loadPage(url, function() {
            $(".i-checks").iCheck({
                checkboxClass: 'icheckbox_square-green'
            });
        });
	},

	toggleSelectAll: function() {
        if($("#time-toggle-all").is(":checked")) {
            $(".time-checkbox").prop("checked", true);
        }
        else {
            $(".time-checkbox").prop("checked", false);
        }
    },

    eachSelectedTime: function(cb) {
    	
    	$(".time-checkbox").each(function(index) {
    		let timeEntryId = $(this).attr("data-time-entry-id");
            
            if($(this).is(":checked")) {
                cb(timeEntryId);
            }
    	});

    },

    markSelectedTimeBilled: function() {

    	Prefiniti.Business.eachSelectedTime(function(id) {

    		let url = "/businessnet/components/mark_time_billed.cfm?id=" + id;

    		$.get(url, function(data) {
    			if(data.success) {
    				$("#time-entry-" + id).hide("slow");
    			}
    			else {
    				console.log("ERROR!");
    			}
    		});

    	});

    },

	markSelectedTimeUnbilled: function() {

    	Prefiniti.Business.eachSelectedTime(function(id) {

    		let url = "/businessnet/components/mark_time_unbilled.cfm?id=" + id;

    		$.get(url, function(data) {
    			if(data.success) {
    				$("#time-entry-" + id).hide("slow");
    			}
    			else {
    				console.log("ERROR!");
    			}
    		});

    	});

    },

	siteSettings: function() {
		let url = "/businessnet/components/site_manager/edit_site.cfm";

		Prefiniti.loadPage(url);
	},

	addTaskCode: function() {
		let url = "/businessnet/components/site_manager/add_task_code.cfm";

		Prefiniti.dialog(url);
	},

	editTaskCode: function(id) 
{		let url = "/businessnet/components/site_manager/edit_task_code.cfm?id=" + id;

		Prefiniti.dialog(url);
	},

	deleteTaskCode: function(id) {
		let url = "/businessnet/components/site_manager/delete_task_code_sub.cfm?id=" + id;

		$.get(url, function(data) {
			if(data.ok) {
				toastr.options = {
		            closeButton: true,
		            progressBar: true,
		            showMethod: 'slideDown',
		            timeout: 5000
		        };
		        
		        toastr.success(data.message);

		        Prefiniti.reload();
			}
			else {

				toastr.options = {
		            closeButton: true,
		            progressBar: true,
		            showMethod: 'slideDown',
		            timeout: 5000
		        };

		        toastr.error(data.message);
			}
		});
	},

	dismiss: function() {
		$("#generic-window").modal('hide');
		Prefiniti.reload();
	},

	addClient: function() {
		let url = "/businessnet/components/add_client.cfm";

		Prefiniti.dialog(url);
	},

	clientAdded: function() {
		$("#generic-window").modal('hide');
		Prefiniti.reload();
	},

	checkClient: function() {
		let email = $("#client-email").val();
		let url = "/api/account/" + email;

		$.get(url, function(data) {
			if(data.matches > 0) {
				$("#client-first-name").val(data.account.firstName).prop("disabled", true);
				$("#client-middle-initial").val(data.account.middleInitial).prop("disabled", true);
				$("#client-last-name").val(data.account.lastName).prop("disabled", true);
				$("#client-new-account").val(0);
				$("#client-title").focus();
			}
			else {
				$("#client-new-account").val(1);
				$("#client-first-name").val("").prop("disabled", false);
				$("#client-middle-initial").val("").prop("disabled", false);
				$("#client-last-name").val("").prop("disabled", false);
				$("#client-first-name").focus();
			}
		});
	},

	addEmployee: function() {
		let url = "/businessnet/components/add_employee.cfm";

		Prefiniti.dialog(url);
	},

	employeeAdded: function() {
		$("#generic-window").modal('hide');
		Prefiniti.reload();
	},

	checkEmployee: function() {
		let email = $("#employee-email").val();
		let url = "/api/account/" + email;

		$.get(url, function(data) {
			if(data.matches > 0) {
				$("#employee-first-name").val(data.account.firstName).prop("disabled", true);
				$("#employee-middle-initial").val(data.account.middleInitial).prop("disabled", true);
				$("#employee-last-name").val(data.account.lastName).prop("disabled", true);
				$("#employee-new-account").val(0);
				$("#employee-title").focus();
			}
			else {
				$("#employee-new-account").val(1);
				$("#employee-first-name").val("").prop("disabled", false);
				$("#employee-middle-initial").val("").prop("disabled", false);
				$("#employee-last-name").val("").prop("disabled", false);
				$("#employee-first-name").focus();
			}
		});

		Prefiniti.Business.updateEmployeeForm();
	},

	updateEmployeeForm: function() {
		let employment_status = $("#employment_status").val();

		console.log(employment_status);

		if(employment_status != "Terminated") {
			$("#termination-date-div").hide();
		}
		else {
			$("#termination-date-div").show();
		}

		let wage_basis = $("#wage_basis").val();
		let payroll_frequency = $("#payroll_frequency").val();

		if(wage_basis == "Contractor" && payroll_frequency != "Per Job") {
			toastr.options = {
	            closeButton: true,
	            progressBar: true,
	            showMethod: 'slideDown',
	            timeout: 5000
	        };
	        
	        toastr.warning("A contractor is typically paid per job. You're currently paying this contractor " + payroll_frequency + ".");
		}
		
		
		if(payroll_frequency == "Per Job" && wage_basis != "Contractor") {
			toastr.options = {
	            closeButton: true,
	            progressBar: true,
	            showMethod: 'slideDown',
	            timeout: 5000
	        };
	        
	        toastr.warning("Non-contract employees are not normally paid per job.");
		}
	}

});
