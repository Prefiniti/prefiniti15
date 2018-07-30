Prefiniti.extend("Tour", {

    begin: function() {

        var tour = new Tour({
            steps: [
                {
                    element: "#user-menu",
                    title: "Welcome to Geodigraph PM",
                    content: "The user menu is the heart of Geodigraph PM navigation. You can switch sites, access account settings, view your profile and personal files, and much more.",
                    placement: "right"
                },
                {   
                    element: "#dashboard-shortcut",
                    title: "Dashboard",
                    content: "Clicking here will return you to the dashboard, where you can view pertinent information about your company and projects.",
                    placement: "right"
                },
                {
                    element: "#mailbox-shortcut",
                    title: "Messaging",
                    content: "This menu gives you the ability to send private mail to and receive private mail from other Geodigraph PM users.",
                    placement: "right"
                },
                {
                    element: "#company-shortcut",
                    title: "Company",
                    content: "The Company menu gives you the ability to view your employees and clients and manage your company settings, as well as allowing you to create and manage projects.",
                    placement: "right"
                },
                { 
                    element: "#alerts-shortcut",
                    title: "Alerts",
                    content: "Alerts about your projects and social networking activity will be displayed in this menu.",
                    placement: "left"
                },
                {
                    element: "#mail-preview-shortcut",
                    title: "Unread Mail",
                    content: "New and unread mail will appear in this menu.",
                    placement: "left"
                },
                {
                    element: "#friend-requests-shortcut",
                    title: "Friend Requests",
                    content: "New friend requests will appear in this menu, where you may directly accept or reject them.",
                    placement: "left"
                },
                {
                    element: "#prefiniti-home",
                    title: "Home Button",
                    content: "This button will return you to your configured home screen (which can be set with the Settings menu item in your user menu).",
                    placement: "bottom"
                },
                {
                    element: "#prefiniti-reload",
                    title: "Reload Button",
                    content: "The reload button will refresh your current view.",
                    placement: "bottom"
                }
            ]
        });

        $("#generic-window").modal('hide');

        tour.init();
        tour.restart();

    }

});