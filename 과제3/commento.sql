USE commento;

SELECT cust_id, pd_id, COUNT(1)
FROM `rec_pur`
GROUP BY cust_id, pd_id
;

/*이상 데이터 1 : 2회 이상 산 고객*/
--상품 산 횟수
SELECT cust_id, COUNT(1)
FROM `rec_pur`
GROUP BY cust_id
;

--상품을 2개 산 고객 검출
SELECT cust_id, COUNT(1)
FROM `rec_pur`
GROUP BY cust_id
HAVING COUNT(1) > 1
;

--이상 고객 log에 넣기
INSERT INTO all_logs.pur_num_log(`cust_id`,`data_input_time`,`pur_num`, `data_input_nm`)
SELECT cust_id, data_input_time,COUNT(1),data_input_nm
FROM `rec_pur`
GROUP BY cust_id
HAVING COUNT(1) > 1
;

--이상 고객 생성 위한 insert문
INSERT INTO `rec_pur`(`cust_id`, `pd_id`, `data_input_time`, `data_input_nm`)
VALUES ('ID01', 'PD02', NOW(), 'system'),
('ID03', 'PD02', NOW(), 'system')
;

/*이상 데이터 2 : insert 형식에서 생긴 문제*/
--이상 데이터 insert
INSERT INTO `rec_cust`(`cust_id`, `cust_nm`, `gender`, `birth`, `cell_no`, `ap_path_cd`, `data_input_time`, `data_input_nm`, `data_mod_time`, `data_mod_nm`)
VALUES ('ID04', 'OPPS', '1', '19800104','몰라 비밀이거든', 'P01', NOW(), 'system', NOW(), 'system')
;

INSERT INTO `rec_cust`(`cust_id`, `cust_nm`, `gender`, `birth`, `cell_no`, `ap_path_cd`, `data_input_time`, `data_input_nm`, `data_mod_time`, `data_mod_nm`)
VALUES ('ID05', 'YUJIN', '3', '19800104','010-2222-1111', 'P02', NOW(), 'system', NOW(), 'system'),
('ID06', 'GANG', '1', '000920','010-3212', 'P01', NOW(), 'system', NOW(), 'system')
;

--이상데이터 검출1 : cell_num이 이상할 때
SELECT cust_id, cust_nm, cell_no
FROM `rec_cust`
WHERE cell_no NOT REGEXP '[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}' OR LENGTH(`cell_no`) > 14
;

--이상데이터 검출2 : gender이상할 때
SELECT cust_id, cust_nm, gender
FROM `rec_cust`
WHERE gender!=1 AND gender!=2;

--이상데이터 검출3 : birth이상할 때
SELECT cust_id, cust_nm, birth
FROM `rec_cust`
WHERE LENGTH(birth) != 8 or birth NOT REGEXP  '^(19|20)[0-9][0-9](0[1-9]|1[012])(0[1-9]|[12][0-9]|3[0-1])$'
;

--이상 고객 log에 넣기
INSERT INTO all_logs.cust_log(`cust_id`,`log_col`,`log_content`, `data_input_time`,`data_input_nm`,`data_mod_time`,`data_mod_nm`)
SELECT cust_id, 'cell_no', cell_no,data_input_time,data_input_nm,data_mod_time,data_mod_nm
FROM `rec_cust`
WHERE cell_no NOT REGEXP '[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}' OR LENGTH(`cell_no`) > 14
;
