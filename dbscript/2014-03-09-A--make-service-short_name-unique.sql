START TRANSACTION
;
ALTER TABLE `service`
  ADD UNIQUE INDEX `short_name` (`short_name` ASC)
;
COMMIT