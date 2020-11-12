DELIMITER $$

CREATE
    TRIGGER `commento`.`pur_num_insert` AFTER INSERT
    ON `commento`.`rec_pur`
    FOR EACH ROW BEGIN
	DECLARE pur_num_ INT;

	SELECT COUNT(1) INTO pur_num_
	FROM `rec_pur`
	GROUP BY cust_id
	HAVING cust_id = new.cust_id;

	IF pur_num_ > 1 THEN
		INSERT INTO all_logs.pur_num_log(`cust_id`,`data_input_time`,`pur_num`, `data_input_nm`)
		VALUES (new.cust_id,new.data_input_time,pur_num_,new.data_input_nm)
		ON DUPLICATE KEY UPDATE
		cust_id=new.cust_id,
		data_input_time=new.data_input_time,
		pur_num=pur_num_,
		data_input_nm=new.data_input_nm
		;
	END IF;

    END$$

DELIMITER ;
