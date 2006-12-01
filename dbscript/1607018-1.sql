insert into request_status_code_description_map
  set description = 'Failed deadline';
ALTER TABLE request_status_code_description_map
  ADD UNIQUE description(description);