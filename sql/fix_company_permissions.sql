--
-- Prefiniti 1.5.2
-- Align company permissions with stakeholder permissions
--
-- Author: John P. Willis <jpw@coherent-logic.com>
-- Copyright (C) 2019 Coherent Logic Development LLC
--


USE sites;

DELETE FROM permissions WHERE perm_key="TS_VIEW";
DELETE FROM permissions WHERE perm_key="TS_CREATE";
DELETE FROM permissions WHERE perm_key="TS_EDIT";
DELETE FROM permissions WHERE perm_key="TS_DELETE";
DELETE FROM permissions WHERE perm_key="TS_APPROVE";
DELETE FROM permissions WHERE perm_key="WF_VIEW";
DELETE FROM permissions WHERE perm_key="WF_CREATE";
DELETE FROM permissions WHERE perm_key="WF_EDIT";
DELETE FROM permissions WHERE perm_key="WF_DELETE";
DELETE FROM permissions WHERE perm_key="TS_REVERSE";
DELETE FROM permissions WHERE perm_key="TS_VIEWALL";
DELETE FROM permissions WHERE perm_key="TS_VIEW_TC";
DELETE FROM permissions WHERE perm_key="TS_EDIT_TC";
DELETE FROM permissions WHERE perm_key="TS_DELETE_TC";
DELETE FROM permissions WHERE perm_key="TS_CREATE_TC";
DELETE FROM permissions WHERE perm_key="WF_MANAGE_DELINQUENT";

INSERT INTO permissions (name, perm_key) VALUES ("View Project", "PRJ_VIEW");
INSERT INTO permissions (name, perm_key) VALUES ("Edit Project", "PRJ_EDIT");
INSERT INTO permissions (name, perm_key) VALUES ("Delete Project", "PRJ_DELETE");

INSERT INTO permissions (name, perm_key) VALUES ("Log Time", "TIME_LOG");
INSERT INTO permissions (name, perm_key) VALUES ("Edit Time Log (Self)", "TIME_EDIT");
INSERT INTO permissions (name, perm_key) VALUES ("Manage Travel Log", "TIME_APPROVE");
INSERT INTO permissions (name, perm_key) VALUES ("Delete Time Log", "TIME_DELETE");

INSERT INTO permissions (name, perm_key) VALUES ("Log Travel", "TRAVEL_LOG");
INSERT INTO permissions (name, perm_key) VALUES ("Edit Travel Log", "TRAVEL_EDIT");
INSERT INTO permissions (name, perm_key) VALUES ("Manage Travel Log", "TRAVEL_APPROVE");
INSERT INTO permissions (name, perm_key) VALUES ("Delete Travel Log", "TRAVEL_DELETE");

INSERT INTO permissions (name, perm_key) VALUES ("Create Task", "TASK_ADD");
INSERT INTO permissions (name, perm_key) VALUES ("Edit Task", "TASK_EDIT");
INSERT INTO permissions (name, perm_key) VALUES ("Delete Task", "TASK_DELETE");

INSERT INTO permissions (name, perm_key) VALUES ("Create Stakeholder", "SH_ADD");
INSERT INTO permissions (name, perm_key) VALUES ("Edit Stakeholder", "SH_EDIT");
INSERT INTO permissions (name, perm_key) VALUES ("Delete Stakeholder", "SH_DELETE");

INSERT INTO permissions (name, perm_key) VALUES ("Create Deliverable", "DEL_ADD");
INSERT INTO permissions (name, perm_key) VALUES ("Edit Deliverable", "DEL_EDIT");
INSERT INTO permissions (name, perm_key) VALUES ("Delete Deliverable", "DEL_DELETE");

INSERT INTO permissions (name, perm_key) VALUES ("Create Location", "LOC_ADD");
INSERT INTO permissions (name, perm_key) VALUES ("Edit Location", "LOC_EDIT");
INSERT INTO permissions (name, perm_key) VALUES ("Delete Location", "LOC_DELETE");

INSERT INTO permissions (name, perm_key) VALUES ("Create Document", "DOC_ADD");
INSERT INTO permissions (name, perm_key) VALUES ("Edit Document", "DOC_EDIT");
INSERT INTO permissions (name, perm_key) VALUES ("Delete Document", "DOC_DELETE");

INSERT INTO permissions (name, perm_key) VALUES ("Create Dispatch", "DISP_ADD");
INSERT INTO permissions (name, perm_key) VALUES ("Cancel Dispatch", "DISP_CANCEL");
