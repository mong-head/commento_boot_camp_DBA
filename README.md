# commento boot camp : DBA
desc : DBA에 대한 직무 체험 부트 캠프 (2020.10.17 ~ 2020.11.14)

* 사용 기술 및 프로그램
  1. AWS RDS MySQL 서비스
  2. MySQL(8.0)
  3. SQLyog
  4. DA#5
  5. trigger, procedure

## 1. AWS 서버 이용
![K-007](https://user-images.githubusercontent.com/52481037/98964044-aff86a80-254b-11eb-95c0-41b73068e981.jpg)
* AWS RDS MySQL이용
* MySQL(8.0)설치 후 SQLyog사용 
  * MySQL Workbench는 치명적인 문제가 있어서 SQLyog사용
* DB instance parameters
  * log_bin_trust_function_creators : 1 //trigger사용 위함
  * general_log : 1 //query log보기 위함

### 1-1. DBMS 선택한 과정 : [과제 1](https://github.com/mong-head/commento_boot_camp_DBA/blob/master/%EA%B3%BC%EC%A0%9C1/%EB%B0%B0%EC%9C%A0%EC%A7%84_%EA%B3%BC%EC%A0%9C1.pdf)

<p align="center"><img src = "https://user-images.githubusercontent.com/52481037/98965848-de774500-254d-11eb-822d-ec5315387476.jpg" align="center" width="700px" ></p>

* 서버를 컴퓨터에 직접 설치하는 것과 AWS 서비스들을 비교하고, AWS 서비스 중에서도 AWS RDS, Aurora 서비스를 비교함.

* 비용도 적절하고, 24시간 서비스를 제공하는 AWS RDS MySQL을 최종적으로 선택함.   
* 어려웠던 점 : 서버를 컴퓨터에 직접 설치하는 것과 oracle의 비용을 알아보고 싶었지만, 실제로 알 수 있는 방법은 직접 전화를 하거나 주변에 설치한 사람에게 물어보는 방법 뿐이었다. 그래서 그 부분의 경우는 확실하지 않아, 공란으로 두었다.

## 2. 데이터 이관

detail : [과제 2](https://github.com/mong-head/commento_boot_camp_DBA/blob/master/%EA%B3%BC%EC%A0%9C2/%EA%B3%BC%EC%A0%9C2_%EB%B0%B0%EC%9C%A0%EC%A7%84_1%EC%B0%A8.pdf)
* 시스템 : 고객 추천 시스템
* tables : 
<p align="center"><img src = "https://user-images.githubusercontent.com/52481037/98969712-7a0ab480-2552-11eb-928c-1d2b6bbc039c.jpg" align="center" width="700px" ></p>

* 추가 과제 : DB설계 해보기 - 사내도서관 시스템 DB설계(논리,물리)
  * detail : [추가 과제](https://github.com/mong-head/commento_boot_camp_DBA/blob/master/%EA%B3%BC%EC%A0%9C3-4%EC%82%AC%EC%9D%B4%20%EC%B6%94%EA%B0%80%EA%B3%BC%EC%A0%9C/%EC%B6%94%EA%B0%80%20%EA%B3%BC%EC%A0%9C.pdf)
  * 피드백 정리 : [추가 과제 피드백 정리](https://github.com/mong-head/commento_boot_camp_DBA/blob/master/%EA%B3%BC%EC%A0%9C3-4%EC%82%AC%EC%9D%B4%20%EC%B6%94%EA%B0%80%EA%B3%BC%EC%A0%9C/%EC%B6%94%EA%B0%80%20%EA%B3%BC%EC%A0%9C%20%ED%94%BC%EB%93%9C%EB%B0%B1.pdf)
  * 프로그램 : DA#5이용
  * 결과 : 
  
    |논리 설계|물리 설계|
    |:------:|:------:|
    |<p align="center"><img src = "https://user-images.githubusercontent.com/52481037/98973525-34041f80-2557-11eb-9e65-1b69281b9099.png" align="center" width="400px" ></p>|<p align="center"><img src = "https://user-images.githubusercontent.com/52481037/98974284-15eaef00-2558-11eb-9440-f19cbe3ed129.png" align="center" width="400px" ></p>|
  * 피드백 적용 결과 :
    |논리 설계|물리 설계|
    |:------:|:------:|
    |<p align="center"><img src = "https://user-images.githubusercontent.com/52481037/99141705-5437f980-2691-11eb-8676-51acbcd9f15a.png" align="center" width="400px" ></p>|<p align="center"><img src = "https://user-images.githubusercontent.com/52481037/99141710-57cb8080-2691-11eb-8992-a3fbfc23c6bb.png" align="center" width="400px" ></p>|
    * 변경 : trigger사용X-사용자 table column 2개 삭제 / 제 2정규화까지 적용(제 3정규화는 적용시키지 않음 - 이유 : 피드백 pdf에 존재)


## 3. 이상데이터 검출 및 품질검증 시스템 생성

detail : [과제 3](https://github.com/mong-head/commento_boot_camp_DBA/blob/master/%EA%B3%BC%EC%A0%9C3/%EA%B3%BC%EC%A0%9C3_%EB%B0%B0%EC%9C%A0%EC%A7%84.pdf)
  * 해당 pdf에 어떤 것을 이상 데이터로 정하였는지 있음

품질검증을 위하여...
  1. log DB를 만들고, log table을 만듦 - 정의한 이상데이터의 로그를 남기기 위함
  2. Trigger을 이용하여, 데이터를 insert할 때마다 이상데이터인지 확인하여 로그 남김
  3. procedure을 이용하여, 품질검증 프로세스를 하나로 담아서 점검시 편함을 추구함.
  * [trigger,procedure,query code](https://github.com/mong-head/commento_boot_camp_DBA/tree/master/%EA%B3%BC%EC%A0%9C3)
  * log DB, Trigger, Procedure등을 담은 DB이미지 : 
<p align="center"><img src = "https://user-images.githubusercontent.com/52481037/98972229-82182380-2555-11eb-9af8-9b7ce43447f9.png" align="center" width="150px" ></p>

## 4. 트러블 슈팅

detail : [과제 4](https://github.com/mong-head/commento_boot_camp_DBA/blob/master/%EA%B3%BC%EC%A0%9C4/%EA%B3%BC%EC%A0%9C%204.pdf)

과제 피드백 정리 : [과제 4 피드백](https://github.com/mong-head/commento_boot_camp_DBA/blob/master/%EA%B3%BC%EC%A0%9C4/%EA%B3%BC%EC%A0%9C4%20%ED%94%BC%EB%93%9C%EB%B0%B1%20%EC%A0%95%EB%A6%AC.pdf)

트러블슈팅
  * 상황 가정 : 파트너사에서 임의로 스키마 변경(테이블의 column하나를 drop)
  * 문제 정의 : 그로 인해 발생했던 문제에 대한 설명 및 문제 정의
  * 원인 분석 : 문제에 대해 여러 로그를 보여줌
  * 원인 추론 : 파트너사에서 임의로 스키마 변경했을 것
  * 문제 해결 : bin file이 그 당시 없었어서 시간을 유추하며 AWS RDS backtrack서비스 이용
  
    |backtrack위해 여러 instance만들고 지움|복구 instance : commento-11-10-11-utc-public|
    |:------:|:------:|
    |<p align="center"><img src = "https://user-images.githubusercontent.com/52481037/99141877-ce1cb280-2692-11eb-9d92-2e2b53b354f4.jpg" align="center" width="400px" ></p>|<p align="center"><img src = "https://user-images.githubusercontent.com/52481037/99141895-015f4180-2693-11eb-9734-d17b1e84d0e1.png" align="center" width="400px" ></p>|
  
파트너사와 충돌
  * 파트너사에 손해배상청구하는 문서 만들어 보고, 실제 멘토님과 롤플레이 해봄
