DELIMITER $$

CREATE
    TRIGGER `commento`.`cust_insert` AFTER INSERT
    ON `commento`.`rec_cust`
    FOR EACH ROW BEGIN
	DECLARE cell_issue INT;
	DECLARE birth_issue INT;
	DECLARE gender_issue INT;

	SET cell_issue = 0;
	SET birth_issue = 0;
	SET gender_issue = 0;

	SELECT COUNT(1) INTO cell_issue
	FROM `rec_cust`
	WHERE new.cell_no NOT REGEXP '[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}' OR LENGTH(new.cell_no) > 14
	;

	SELECT COUNT(1) INTO gender_issue
	FROM `rec_cust`
	WHERE new.gender!=1 AND new.gender!=2
	;

	SELECT COUNT(1) INTO birth_issue
	FROM `rec_cust`
	WHERE LENGTH(new.birth) != 8 OR new.birth NOT REGEXP  '^(19|20)[0-9][0-9](0[1-9]|1[012])(0[1-9]|[12][0-9]|3[0-1])$'
	;

	IF cell_issue > 0 THEN
		INSERT INTO all_logs.cust_log(`cust_id`,`log_col`,`log_content`, `data_input_time`,`data_input_nm`,`data_mod_time`,`data_mod_nm`)
		VALUES (new.cust_id, 'cell_no', new.cell_no,new.data_input_time,new.data_input_nm,new.data_mod_time,new.data_mod_nm)
		ON DUPLICATE KEY UPDATE
		cust_id = new.cust_id,
		log_col = 'cell_no',
		log_content = new.cell_no,
		data_input_time = new.data_input_time,
		data_input_nm = new.data_input_nm,
		data_mod_time = new.data_mod_time,
		data_mod_nm = new.data_mod_nm;
	END IF;

	IF gender_issue > 0 THEN
		INSERT INTO all_logs.cust_log(`cust_id`,`log_col`,`log_content`, `data_input_time`,`data_input_nm`,`data_mod_time`,`data_mod_nm`)
		VALUES (new.cust_id, 'gender', new.gender,new.data_input_time,new.data_input_nm,new.data_mod_time,new.data_mod_nm)
		ON DUPLICATE KEY UPDATE
		cust_id = new.cust_id,
		log_col = 'gender',
		log_content = new.gender,
		data_input_time = new.data_input_time,
		data_input_nm = new.data_input_nm,
		data_mod_time = new.data_mod_time,
		data_mod_nm = new.data_mod_nm;
	END IF;

	IF birth_issue > 0 THEN
		INSERT INTO all_logs.cust_log(`cust_id`,`log_col`,`log_content`, `data_input_time`,`data_input_nm`,`data_mod_time`,`data_mod_nm`)
		VALUES (new.cust_id, 'birth', new.birth,new.data_input_time,new.data_input_nm,new.data_mod_time,new.data_mod_nm)
		ON DUPLICATE KEY UPDATE
		cust_id = new.cust_id,
		log_col = 'birth',
		log_content = new.birth,
		data_input_time = new.data_input_time,
		data_input_nm = new.data_input_nm,
		data_mod_time = new.data_mod_time,
		data_mod_nm = new.data_mod_nm;
	END IF;

    END$$

DELIMITER ;
