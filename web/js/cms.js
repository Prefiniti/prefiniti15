Prefiniti.extend("CMS", {

	choose: function(elementName, fileId, fileName) {
		
		/*
         * We want to:
         *  1) Hide the table (cms-picker-{elementName}-choices)
         *  2) Copy the fileId to cms-picker-{elementName}-selection
         *  3) Copy the fileName to cms-picker-{elementName}-display
         *  4) Show the display box (cms-picker-{elementName}-display-container)
         */

        let table = $("#cms-picker-" + elementName + "-table");
        let selection = $("#cms-picker-" + elementName + "-selection");
        let display = $("#cms-picker-" + elementName + "-display");
        let displayContainer = $("#cms-picker-" + elementName + "-display-container");

        table.hide();
        selection.val(fileId);
        display.val(fileName);
        displayContainer.show();

	},

	undo: function(elementName) {
		
		/*
         * We want to:
         *  1) Hide the display box
         *  2) Clear out the selection
         *  3) Clear out the display
         *  4) Show the table
         */

        let table = $("#cms-picker-" + elementName + "-table");
        let selection = $("#cms-picker-" + elementName + "-selection");
        let display = $("#cms-picker-" + elementName + "-display");
        let displayContainer = $("#cms-picker-" + elementName + "-display-container");

        displayContainer.hide();
        selection.val("");
        display.val("");
        table.show();
	},

	refreshPicker: function(elementName, height) {
		let container = $("#cms-picker-" + elementName + "-container");
		let url = "/contentManager/components/cms_picker_inner.cfm?element_name=" + elementName;
        url += "&height=" + height;

		$.get(url, function(data) {
			container.html(data);
		});
	},

    enableUpload: function(elementName) {
        $("#cms-picker-" + elementName + "-uploader").show();
    },

	pickerUpload: function(elementName, height) {

		let fileControl = $("#cms-picker-" + elementName + "-file");

		var file = fileControl[0].files[0];
	    var fh = new FileHandler(file, {
	        uploadHandler: "/contentManager/components/picker_file_upload.cfm",
	        progressBarId: "picker-upload-progress-" + elementName,
	        timeout: 999999,
	        formFields: ["cms-picker-element-name", "cms-picker-" + elementName + "-file-type"],
	        success: function(data) {
	            Prefiniti.CMS.refreshPicker(elementName, height);
	        },
	        error: function(error) {
	            console.log("error = %o", error);
	            alert("error");
	            
	        }
	    });

	    fh.upload();

	}

});