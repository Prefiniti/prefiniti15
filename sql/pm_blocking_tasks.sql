--
-- Prefiniti 1.5.2
-- Project management support for blocking tasks
--
-- Author: John P. Willis <jpw@coherent-logic.com>
-- Copyright (C) 2019 Coherent Logic Development LLC
--

USE webwarecl;

DROP TABLE IF EXISTS pm_blocking_tasks;

CREATE TABLE pm_blocking_tasks
    (id BIGINT(20) NOT NULL AUTO_INCREMENT,
    blocked_task_id BIGINT(20) NOT NULL,
    blocking_task_id BIGINT(20) NOT NULL,
    PRIMARY KEY(`id`))
    ENGINE=InnoDB DEFAULT CHARSET=utf8;