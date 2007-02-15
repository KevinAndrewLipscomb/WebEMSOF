ALTER TABLE emsof_request_master
  ADD COLUMN be_deadline_exempt boolean NOT NULL DEFAULT '0' AFTER `actual_value`;
