--
-- Prefiniti 1.5.2
-- Permissions Management Toolkit
--
-- Author: John P. Willis <jpw@coherent-logic.com>
-- Copyright (C) 2018 Coherent Logic Development LLC
--
use sites;

drop procedure if exists listPermissionTypes;
drop procedure if exists getUserAssociations;
drop procedure if exists getPermissions;
drop procedure if exists grantPermission;
drop procedure if exists revokePermission;

delimiter $$

create procedure listPermissionTypes()
begin
    select perm_key, name from permissions order by perm_key;
end $$


create procedure getUserAssociations(in loginName varchar(45))
begin
    declare userId int;

    select id into userId from webwarecl.users where username=loginName;

    select sites.SiteName, site_associations.assoc_type, site_associations.id
    from sites
    inner join site_associations
    on site_associations.site_id=sites.SiteID
    where site_associations.user_id=userId
    order by sites.SiteName, site_associations.assoc_type;

end $$

create procedure getPermissions(in assocId bigint(20))
begin
    select permissions.perm_key, permissions.name
    from permissions
    inner join permission_entries
    on permission_entries.perm_id=permissions.id
    where permission_entries.assoc_id=assocId
    order by permissions.perm_key;
end $$

create procedure grantPermission(in assocId bigint(20),
                                 in permKey varchar(45))
begin
    declare permId int;

    call revokePermission(assocId, permKey);

    select id into permId from permissions where perm_key=permKey;

    insert into permission_entries (assoc_id, perm_id) values (assocId, permId);

end $$

create procedure revokePermission(in assocId bigint(20),
                                 in permKey varchar(45))
begin
    declare permId int;

    select id into permId from permissions where perm_key=permKey;

    delete from permission_entries where perm_id=permId and assoc_id=assocId;

end $$

show procedure status where db='sites';
