USE all_logs;

--log table1 : 고객이 상품을 산 횟수 2회 이상이면 이 로그 테이블에 남김
CREATE TABLE `pur_num_log`
(
 `cust_id` VARCHAR(30) NOT NULL
COMMENT '고객아이디',
 `data_input_time` DATE NOT NULL
COMMENT '데이터입력일시',
 `pur_num` VARCHAR(30) NOT NULL
COMMENT '상품구매횟수',
 `data_input_nm` VARCHAR(30) NOT NULL
COMMENT '데이터입력자'
)
COMMENT = '로그테이블';

ALTER TABLE `pur_num_log`
ADD CONSTRAINT `엔터티2_PK` PRIMARY KEY (
`cust_id`);

--log table2 : 고객정보insert문제
CREATE TABLE `cust_log`
(
`cust_id` VARCHAR(30) NOT NULL
COMMENT '고객아이디',
`log_col` varchar(30) not NULL
comment '이상column',
`log_content` VARCHAR(30)
COMMENT '이상데이터내용',
`data_input_time` DATE NOT NULL
COMMENT '데이터입력일시',
`data_input_nm` VARCHAR(30) NOT NULL
COMMENT '데이터입력자',
`data_mod_time` DATE NOT NULL
COMMENT '데이터수정일시',
`data_mod_nm` VARCHAR(30) NOT NULL
COMMENT '데이터수정자'
)
COMMENT = '고객로그테이블';

ALTER TABLE `cust_log`
ADD CONSTRAINT `엔터티2_PK1` PRIMARY KEY (
`cust_id`,`log_col`);
