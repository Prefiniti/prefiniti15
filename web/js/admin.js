Prefiniti.extend("Admin", {
	
	beginAcctLookup: function() {
        Prefiniti.dialog('/webware_admin/account_lookup.cfm');
    },

    locateAccount: function() {
        $.get("/api/account/" + $("#acct-lookup-email").val(), (data) => {
            if(!data.success) {
            	alert("Error in account lookup.");
            }
            else {
            	if(data.matches != 1) {
            		alert("No account matches.");
            	}
            	else {
            		let url = "/webware_admin/edit_account.cfm?id=" + data.account.id;
            		Prefiniti.loadPage(url);
            	}
            }
        });
    },

    impersonate: function(assoc_id) {
        Prefiniti.loadPage("/webware_admin/impersonate.cfm?assoc_id=" + assoc_id);
    },

    setBooleanField: function(user_id, fieldName, fieldPrefix) {
        let fullField = "#" + fieldPrefix + "_" + fieldName;
        let fieldValue = $(fullField).val();
        let url = "/webware_admin/components/set_boolean_field.cfm?user_id=" + user_id;
        url += "&field_name=" + fieldName + "&field_value=" + fieldValue;
        
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
        });
    }

});