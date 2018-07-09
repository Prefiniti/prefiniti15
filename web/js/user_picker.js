Prefiniti.extend("UserPicker", {

    choose: function(elementName, longName, assocId) {

        /*
         * We want to:
         *  1) Hide the table (user-picker-{elementName}-choices)
         *  2) Copy the assocId to user-picker-{elementName}-selection
         *  3) Copy the longName to user-picker-{elementName}-display
         *  4) Show the display box (user-picker-{elementName}-display-container)
         */

        let table = $("#user-picker-" + elementName + "-choices");
        let selection = $("#user-picker-" + elementName + "-selection");
        let display = $("#user-picker-" + elementName + "-display");
        let displayContainer = $("#user-picker-" + elementName + "-display-container");

        table.hide();
        selection.val(assocId);
        display.val(longName);
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

        let table = $("#user-picker-" + elementName + "-choices");
        let selection = $("#user-picker-" + elementName + "-selection");
        let display = $("#user-picker-" + elementName + "-display");
        let displayContainer = $("#user-picker-" + elementName + "-display-container");

        displayContainer.hide();
        selection.val("");
        display.val("");
        table.show();
        
    }

});


