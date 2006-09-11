start transaction;

alter table emsof_request_master add shortage decimal(10,2) unsigned NOT NULL default '0.00' after num_items;

drop temporary table if exists shortage;
create temporary table shortage
  select master_id as id
    , sum(additional_service_ante) as `value`
    from emsof_request_detail
    group by master_id;

update emsof_request_master
  join shortage using (id)
  set emsof_request_master.shortage = shortage.`value`;

drop temporary table if exists shortage;

commit;