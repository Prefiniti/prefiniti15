Prefiniti.extend("Business", {

	addEmployee: function() {
		let url = "/businessnet/components/add_employee.cfm";

		Prefiniti.dialog(url);
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
	}

});