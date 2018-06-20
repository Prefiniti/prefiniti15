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
    }


};