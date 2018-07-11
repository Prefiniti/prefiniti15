--
-- Prefiniti 1.5.2
-- Project management tables
--
-- Author: John P. Willis <jpw@coherent-logic.com>
-- Copyright (C) 2018 Coherent Logic Development LLC
--

USE webwarecl;

DROP TABLE IF EXISTS pm_projects;
DROP TABLE IF EXISTS pm_project_tags;
DROP TABLE IF EXISTS pm_tasks;
DROP TABLE IF EXISTS pm_deliverables;
DROP TABLE IF EXISTS pm_locations;
DROP TABLE IF EXISTS pm_stakeholders;
DROP TABLE IF EXISTS pm_dispatches;
DROP TABLE IF EXISTS pm_time_entries;
DROP TABLE IF EXISTS pm_travel_entries;
DROP TABLE IF EXISTS pm_filed_documents;

-- main projects table
CREATE TABLE pm_projects
    (id BIGINT(20) NOT NULL AUTO_INCREMENT,
    employee_assoc BIGINT(20) NOT NULL,
    client_assoc BIGINT(20) NOT NULL,
    template_id BIGINT(20) NOT NULL DEFAULT 0,
    project_priority TINYINT NOT NULL DEFAULT 0,
    project_name VARCHAR(45) NOT NULL,
    project_status VARCHAR(45) NOT NULL,
    project_start_date DATETIME NULL,
    project_due_date DATETIME NULL,
    project_description TEXT,
    project_created DATETIME NOT NULL,
    create_id VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`))
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- project tags table
CREATE TABLE pm_project_tags
    (id BIGINT(20) NOT NULL AUTO_INCREMENT,
    project_id BIGINT(20) NOT NULL,
    tag_text VARCHAR(45) NOT NULL,
    PRIMARY KEY(`id`))
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- tasks table
CREATE TABLE pm_tasks
    (id BIGINT(20) NOT NULL AUTO_INCREMENT,
    project_id BIGINT(20) NOT NULL,
    assignee_assoc_id BIGINT(20) NULL,
    task_name VARCHAR(45) NOT NULL,
    task_complete TINYINT NOT NULL DEFAULT 0,
    task_description TEXT NULL,
    task_resolution VARCHAR(45) NOT NULL DEFAULT "",
    task_priority VARCHAR(45) NOT NULL DEFAULT "Normal",
    create_id VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`))
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- deliverables table
CREATE TABLE pm_deliverables
    (id BIGINT(20) NOT NULL AUTO_INCREMENT,
    project_id BIGINT(20) NOT NULL,
    deliverable_name VARCHAR(45) NOT NULL,
    deliverable_uploaded TINYINT NOT NULL DEFAULT 0,
    deliverable_file_id BIGINT(20) NULL,
    create_id VARCHAR(255) NOT NULL,
    PRIMARY KEY(`id`))
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- locations table
CREATE TABLE pm_locations
    (id BIGINT(20) NOT NULL AUTO_INCREMENT,
    project_id BIGINT(20) NOT NULL,
    location_name VARCHAR(45) NOT NULL,
    address VARCHAR(100) NULL,
    city VARCHAR(100) NULL,
    state VARCHAR(100) NULL,
    zip VARCHAR(10) NULL,
    subdivision VARCHAR(100) NULL,
    lot VARCHAR(45) NULL,
    block VARCHAR(45) NULL,
    trs_section VARCHAR(45) NULL,
    trs_township VARCHAR(45) NULL,
    trs_range VARCHAR(45) NULL,
    trs_meridian VARCHAR(45) NULL,
    latitude VARCHAR(45) NULL,
    longitude VARCHAR(45) NULL,
    elevation VARCHAR(45) NULL,
    create_id VARCHAR(255) NOT NULL,
    PRIMARY KEY(`id`))
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- stakeholders table
CREATE TABLE pm_stakeholders
    (id BIGINT(20) NOT NULL AUTO_INCREMENT,
    project_id BIGINT(20) NOT NULL,
    assoc_id BIGINT(20) NOT NULL,
    stakeholder_type VARCHAR(45) NOT NULL DEFAULT "Client",
    create_id VARCHAR(255) NOT NULL,
    PRIMARY KEY(`id`))
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- dispatches table
CREATE TABLE pm_dispatches
    (id BIGINT(20) NOT NULL AUTO_INCREMENT,
    task_id BIGINT(20) NOT NULL,
    dispatcher_assoc_id BIGINT(20) NOT NULL,
    dispatchee_assoc_id BIGINT(20) NOT NULL,
    dispatch_date DATETIME NOT NULL,
    dispatch_description TEXT,
    create_id VARCHAR(255) NOT NULL,
    PRIMARY KEY(`id`))
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- time entries table
CREATE TABLE pm_time_entries
    (id BIGINT(20) NOT NULL AUTO_INCREMENT,
    project_id BIGINT(20) NOT NULL,
    task_id BIGINT(20) NOT NULL DEFAULT 0,
    assoc_id BIGINT(20) NOT NULL,
    task_code_id BIGINT(20) NOT NULL,
    work_performed VARCHAR(255) NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    closed TINYINT NOT NULL DEFAULT 0,
    create_id VARCHAR(255) NOT NULL,
    PRIMARY KEY(`id`))
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- travel table
CREATE TABLE pm_travel_entries
    (id BIGINT(20) NOT NULL AUTO_INCREMENT,
    project_id BIGINT(20) NOT NULL,
    assoc_id BIGINT(20) NOT NULL,
    travel_date DATETIME NOT NULL,
    odometer_start DOUBLE NOT NULL DEFAULT 0,
    odometer_end DOUBLE NOT NULL DEFAULT 0,
    closed TINYINT NOT NULL DEFAULT 0,
    create_id VARCHAR(255) NOT NULL,
    PRIMARY KEY(`id`))
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- filed documents table
CREATE TABLE pm_filed_documents
    (id BIGINT(20) NOT NULL AUTO_INCREMENT,
    project_id BIGINT(20) NOT NULL,
    location_id BIGINT(20) NOT NULL DEFAULT 0,
    document_name VARCHAR(45) NOT NULL,
    document_number VARCHAR(45) NULL,
    filing_authority VARCHAR(45) NOT NULL DEFAULT '',
    filing_category VARCHAR(15) NOT NULL DEFAULT 'FILE',
    filing_container VARCHAR(15) NOT NULL DEFAULT 'CABINET',
    filing_division VARCHAR(50) NOT NULL DEFAULT ' ',
    filing_material_type VARCHAR(10) NOT NULL DEFAULT 'PAGE',
    filing_number VARCHAR(20) NOT NULL DEFAULT ' ',
    filing_date DATETIME NOT NULL,
    create_id VARCHAR(255) NOT NULL,
    PRIMARY KEY(`id`))
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pm_templates;
DROP TABLE IF EXISTS pm_template_tasks;
DROP TABLE IF EXISTS pm_template_deliverables;
DROP TABLE IF EXISTS pm_template_locations;

-- project templates
CREATE TABLE pm_templates
    (id BIGINT(20) NOT NULL AUTO_INCREMENT,
    template_site BIGINT(20) NOT NULL DEFAULT 0,    
    template_name VARCHAR(45) NOT NULL,
    create_id VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)) 
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO pm_templates (template_name)
VALUES ("Blank Project");    