var Prefiniti = {
    
    onLoad: function() {
        loadHomeView();
    },

    setAssociation: function(assocId) {
        console.log(assocId);

        $("#ss-assoc").val(assocId);
        $("#ss-form").submit();
    },

    submitUpload: function() {
        $("#cms-upload-button").hide();
        $("#cms-upload-status").show();
        $("#cms-upload-frame").on("load", Prefiniti.uploadDone);
        $("#cms-upload-form").submit();
    },

    uploadDone: function(tgt) {
        toastr.options = {
            closeButton: true,
            positionClass: "toast-bottom-right"
        };
        
        toastr.info('Upload complete');
        AjaxLoadPageToDiv('tcTarget', '/contentManager/components/cms_browse.cfm');
    },

    showEditIcon: function(baseId) {
        let el = "#" + baseId + "-editicon";

        $(el).show();
    },

    hideEditIcon: function(baseId) {
        let el = "#" + baseId + "-editicon";

        $(el).hide();
    },

    beginEditingField: function(baseId) {

        let viewEl = "#" + baseId + "-view";
        let editEl = "#" + baseId + "-edit";
        let contentEl = "#" + baseId + "-content";

        let editUrl = "/field_editors/" + baseId + ".cfm";


        $(editEl).blur(function () {            

            $.post(editUrl, {
                newValue: $(editEl).val()
            }).done(function(data) {                
                $(editEl).hide();
                $(contentEl).html(data);
                $(viewEl).show();
            });
        });

        $(editEl).val($(contentEl).html());

        $(viewEl).hide();
        $(editEl).show();
        $(editEl).select();
    }


};