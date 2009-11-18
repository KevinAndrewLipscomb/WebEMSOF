START TRANSACTION;

ALTER TABLE `emsof_request_return_comment`
   DROP FOREIGN KEY `emsof_request_return_comment_master_id`;
ALTER TABLE `emsof_request_return_comment`
  ADD CONSTRAINT `emsof_request_return_comment_master_id` FOREIGN KEY `emsof_request_return_comment_master_id` (`emsof_request_master_id`)
    REFERENCES `emsof_request_master` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT;

ALTER TABLE `emsof_purchase_payment`
  DROP FOREIGN KEY `emsof_purchase_payment_ibfk_1`,
  DROP FOREIGN KEY `emsof_purchase_payment_ibfk_3`;
ALTER TABLE `emsof_purchase_payment`
  ADD CONSTRAINT `emsof_purchase_payment_ibfk_1` FOREIGN KEY `emsof_purchase_payment_ibfk_1` (`master_id`)
    REFERENCES `emsof_request_master` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  ADD CONSTRAINT `emsof_purchase_payment_ibfk_3` FOREIGN KEY `emsof_purchase_payment_ibfk_3` (`master_id`)
    REFERENCES `emsof_request_master` (`id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT;

COMMIT