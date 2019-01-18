component extends="Prefiniti.Base" {

    remote struct function get(numeric id) returnformat="JSON" {

        if(!this.loggedIn()) {
            return {
                success: false,
                message: "You are not logged in."
            };
        }
        else {

            var project = new Prefiniti.ProjectManagement.Project(arguments.id);

            var method = getHTTPRequestData().method;

            switch(method) {
                case "GET":
                if(!project.checkPermission(session.user.id, "PRJ_VIEW")) {
                    return {
                        success: false,
                        message: "You do not have PRJ_VIEW permissions for this project."
                    };
                }
                else {
                    return {
                        id: project.id,
                        templateId: project.template_id,
                        name: project.project_name,
                        description: project.project_description,
                        priority: project.getPriority(),
                        status: project.getStatus(),
                        creationDate: project.project_created,
                        startDate: project.project_start_date,
                        dueDate: project.project_due_date,
                        employee: {
                            userId: project.project_employee.id,
                            associationId: project.employee_assoc
                        },
                        client: {
                            userId: project.project_client.id,
                            associationId: project.client_assoc
                        },
                        percentComplete: project.getPercentComplete(),
                        value: project.getValue()
                    };
                }

                break;
            }

            return {
                success: false,
                message: "Invalid HTTP method " & method & "."
            };

        }
    }
}