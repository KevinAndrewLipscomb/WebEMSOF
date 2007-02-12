DROP TABLE IF EXISTS emsof_purchase_payment;
CREATE TABLE IF NOT EXISTS emsof_purchase_payment (
  id bigint(20) unsigned NOT NULL auto_increment,
  master_id bigint(20) unsigned NOT NULL,
  `date` date NOT NULL,
  method_code tinyint(3) unsigned NOT NULL,
  amount decimal(10,2) unsigned NOT NULL,
  note varchar(255) NOT NULL,
  PRIMARY KEY  (id),
  KEY master_id (master_id),
  KEY method_code (method_code),
  KEY `date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

-- 
-- Table structure for table `payment_proof_method_code_description_map`
-- 

DROP TABLE IF EXISTS payment_proof_method_code_description_map;
CREATE TABLE IF NOT EXISTS payment_proof_method_code_description_map (
  `code` tinyint(3) unsigned NOT NULL auto_increment,
  description varchar(31) NOT NULL,
  PRIMARY KEY  (`code`),
  UNIQUE KEY description (description)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table `payment_proof_method_code_description_map`
-- 

INSERT INTO payment_proof_method_code_description_map (code, description) VALUES
(1, 'Cancelled check'),
(2, 'Bank draft'),
(3, 'Bank statement'),
(4, 'Wire transfer');

--
-- Constraints for table `emsof_purchase_payment`
--
ALTER TABLE emsof_purchase_payment
  ADD CONSTRAINT emsof_purchase_payment_ibfk_1 FOREIGN KEY (master_id) REFERENCES emsof_request_master (id),
  ADD CONSTRAINT emsof_purchase_payment_ibfk_2 FOREIGN KEY (method_code) REFERENCES payment_proof_method_code_description_map (`code`),
  ADD CONSTRAINT emsof_purchase_payment_ibfk_3 FOREIGN KEY (master_id) REFERENCES emsof_request_master (id);
