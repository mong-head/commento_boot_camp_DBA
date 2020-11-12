DELIMITER $$

USE `all_logs`$$

DROP PROCEDURE IF EXISTS `log_maintainance`$$

CREATE DEFINER=`admin`@`%` PROCEDURE `log_maintainance`()
BEGIN
		SELECT * FROM cust_log;
		SELECT * FROM pur_num_log;

		SELECT * FROM commento.rec_cust
		WHERE rec_cust.cust_id = ANY(SELECT cust_id FROM cust_log);

		SELECT * FROM commento.rec_pur
		WHERE rec_pur.cust_id = ANY(SELECT cust_id FROM pur_num_log);

	END$$

DELIMITER ;
