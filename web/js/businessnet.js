Prefiniti.extend("Business", {

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

		updateEmployeeForm();
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
