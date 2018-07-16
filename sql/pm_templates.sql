--
-- Prefiniti 1.5.2
-- Project management template tables
--
-- Author: John P. Willis <jpw@coherent-logic.com>
-- Copyright (C) 2018 Coherent Logic Development LLC
--

USE webwarecl;

DROP TABLE IF EXISTS pm_templates;
DROP TABLE IF EXISTS pm_template_tasks;
DROP TABLE IF EXISTS pm_template_deliverables;

-- project templates
CREATE TABLE pm_templates
    (id BIGINT(20) NOT NULL AUTO_INCREMENT,
    template_site BIGINT(20) NOT NULL DEFAULT 0,    
    template_name VARCHAR(45) NOT NULL,
    create_id VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)) 
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- template tasks
CREATE TABLE pm_template_tasks
    (id BIGINT(20) NOT NULL AUTO_INCREMENT,
    template_id BIGINT(20) NOT NULL,
    task_name VARCHAR(255) NOT NULL,
    task_priority VARCHAR(45) NOT NULL,
    create_id VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id`))
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- template deliverables
CREATE TABLE pm_template_deliverables
    (id BIGINT(20) NOT NULL AUTO_INCREMENT,
    template_id BIGINT(20) NOT NULL,
    deliverable_name VARCHAR(45) NOT NULL,
    create_id VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id`))
    ENGINE=InnoDB DEFAULT CHARSET=utf8;
