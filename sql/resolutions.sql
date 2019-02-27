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
DELETE FROM permissions WHERE perm_key="RES_AMEND";
DELETE FROM permissions WHERE perm_key="RES_VOTE";

INSERT INTO permissions (name, perm_key) VALUES ("View Resolutions", "RES_VIEW");
INSERT INTO permissions (name, perm_key) VALUES ("Create Resolutions", "RES_CREATE");
INSERT INTO permissions (name, perm_key) VALUES ("Propose Amendments", "RES_AMEND");
INSERT INTO permissions (name, perm_key) VALUES ("Vote on Resolutions", "RES_VOTE");

DROP TABLE IF EXISTS res_votes;
DROP TABLE IF EXISTS res_amendments;
DROP TABLE IF EXISTS res_resolutions;

-- 
-- res_resolutions
-- 
--  res_eligibility:
--      0 - employees
--      1 - customers
--      2 - both
--
CREATE TABLE res_resolutions
    (id BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    site_id BIGINT(20) UNSIGNED NOT NULL,
    sponsor_assoc_id BIGINT(20) UNSIGNED NOT NULL,
    res_carry_threshold TINYINT NOT NULL DEFAULT 100,
    res_quorum INTEGER NOT NULL DEFAULT 0,
    res_eligibility TINYINT NOT NULL DEFAULT 0,
    res_tabled TINYINT NOT NULL DEFAULT 0,
    res_voting_open DATETIME NOT NULL,
    res_voting_close DATETIME NOT NULL,
    res_create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    res_repeals BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
    res_title VARCHAR(255) NOT NULL,
    res_text TEXT NOT NULL,
    create_id VARCHAR(255) NOT NULL,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`site_id`) REFERENCES sites(`SiteID`) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(`sponsor_assoc_id`) REFERENCES site_associations(`id`) ON UPDATE CASCADE ON DELETE RESTRICT)
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE res_amendments
    (id BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    res_id BIGINT(20) UNSIGNED NOT NULL,
    author_assoc_id BIGINT(20) UNSIGNED NOT NULL,
    am_create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    am_accepted TINYINT NOT NULL DEFAULT 0,
    am_title VARCHAR(255) NOT NULL,
    am_text TEXT NOT NULL,
    create_id VARCHAR(255) NOT NULL,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`res_id`) REFERENCES res_resolutions(`id`) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(`author_assoc_id`) REFERENCES site_associations(`id`) ON UPDATE CASCADE ON DELETE RESTRICT) 
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- res_votes
--
-- vote_type:
--   0 = abstain
--   1 = yea
--   2 = nay
--
CREATE TABLE res_votes
    (id BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    res_id BIGINT(20) UNSIGNED NOT NULL,
    vote_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    voter_assoc_id BIGINT(20) UNSIGNED NOT NULL,
    vote_type TINYINT NOT NULL,
    create_id VARCHAR(255) NOT NULL,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`res_id`) REFERENCES res_resolutions(`id`) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(`voter_assoc_id`) REFERENCES site_associations(`id`) ON UPDATE CASCADE ON DELETE RESTRICT)
    ENGINE=InnoDB DEFAULT CHARSET=utf8;