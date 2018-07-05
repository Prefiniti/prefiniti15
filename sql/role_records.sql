--
-- Prefiniti 1.5.2
-- Employee and Client Records Tables
--
-- Author: John P. Willis <jpw@coherent-logic.com>
-- Copyright (C) 2018 Coherent Logic Development LLC
--

USE sites;

DROP TABLE IF EXISTS employee_records;
DROP TABLE IF EXISTS client_records;

DROP TABLE IF EXISTS employees;
CREATE TABLE employees
    (assoc_id BIGINT(20) NOT NULL,
    application_date DATETIME NULL,
    hire_date DATETIME NULL,
    termination_date DATETIME NULL,
    title VARCHAR(45) NULL,
    application TEXT NULL,
    resume TEXT NULL,
    notes TEXT NULL,
    employment_status VARCHAR(45) NOT NULL DEFAULT "Active",
    wage_basis VARCHAR(20) NULL,
    wage DOUBLE NOT NULL DEFAULT 0,
    payroll_frequency VARCHAR(20) NULL,
    PRIMARY KEY(`assoc_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS clients;
CREATE TABLE clients
    (assoc_id BIGINT(20) NOT NULL,
    company_name VARCHAR(45) NOT NULL,
    notes TEXT NULL,
    PRIMARY KEY(`assoc_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;  

DROP TABLE IF EXISTS role_events;
CREATE TABLE role_events
    (id BIGINT(20) NOT NULL AUTO_INCREMENT,
    assoc_id BIGINT(20) NOT NULL,
    event_author BIGINT(20) NOT NULL,
    event_date DATETIME NOT NULL,
    event_type VARCHAR(45) NOT NULL,
    event_description TEXT,
    PRIMARY KEY(`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;


