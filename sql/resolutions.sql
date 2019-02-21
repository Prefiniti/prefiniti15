--
-- Prefiniti 1.5.2
-- Support resolutions/voting
--
-- Author: John P. Willis <jpw@coherent-logic.com>
-- Copyright (C) 2019 Coherent Logic Development LLC
--


USE sites;

DELETE FROM permissions WHERE perm_key="RES_VIEW";
DELETE FROM permissions WHERE perm_key="RES_CREATE";
DELETE FROM permissions WHERE perm_key="RES_EDIT";
DELETE FROM permissions WHERE perm_key="RES_VOTE";

INSERT INTO permissions (name, perm_key) VALUES ("View Resolutions", "RES_VIEW");
INSERT INTO permissions (name, perm_key) VALUES ("Create Resolutions", "RES_CREATE");
INSERT INTO permissions (name, perm_key) VALUES ("Edit Resolutions", "RES_EDIT");
INSERT INTO permissions (name, perm_key) VALUES ("Vote on Resolutions", "RES_VOTE");

DROP TABLE IF EXISTS res_resolutions;
DROP TABLE IF EXISTS res_amendments;
DROP TABLE IF EXISTS res_votes;

CREATE TABLE res_resolutions
    (id BIGINT(20) NOT NULL AUTO_INCREMENT,
    site_id BIGINT(20) NOT NULL,
    sponsor_assoc_id BIGINT(20) NOT NULL,
    res_carry_threshold TINYINT NOT NULL DEFAULT 100,
    res_tabled TINYINT NOT NULL DEFAULT 0,
    res_title VARCHAR(255) NOT NULL,
    res_text TEXT NOT NULL,
        )