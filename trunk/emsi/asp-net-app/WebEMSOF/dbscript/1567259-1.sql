start transaction;
ALTER TABLE emsof_request_detail
  DROP FOREIGN KEY emsof_request_detail_ibfk_1;
ALTER TABLE emsof_request_detail
  ADD CONSTRAINT
    FOREIGN KEY (master_id) REFERENCES emsof_request_master (id)
    ON DELETE CASCADE;
commit;