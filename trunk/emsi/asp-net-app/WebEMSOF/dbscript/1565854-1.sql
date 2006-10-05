start transaction;

alter table emsof_request_master add
  (
  actual_value decimal(10,2) unsigned not null default 0
  );

alter table emsof_request_detail add
  (
  invoice_designator varchar(255) not null default "",
  actual_quantity smallint(5) unsigned not null default 0,
  actual_subtotal_cost decimal(10,2) unsigned not null default 0
  );

create table emsof_purchase_payment
  (
  id bigint(20) unsigned not null auto_increment,
  master_id bigint(20) unsigned not null,
  method tinyint(3) unsigned not null,
  amount decimal(10,2) unsigned not null,
  note varchar(255) not null,
  primary key (id),
  key (master_id)
  )
  ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE emsof_purchase_payment
  ADD CONSTRAINT FOREIGN KEY (master_id) REFERENCES emsof_request_master (id);

commit;