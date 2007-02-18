ALTER TABLE emsof_request_master
  ADD COLUMN be_reopened_after_going_to_state BOOLEAN NOT NULL DEFAULT 0;