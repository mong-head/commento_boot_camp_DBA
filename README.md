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
  * 프로그램 : DA#5이용
  * 결과 : 
  
    |논리 설계|물리 설계|
    |:------:|:------:|
    |<p align="center"><img src = "https://user-images.githubusercontent.com/52481037/98973525-34041f80-2557-11eb-9e65-1b69281b9099.png" align="center" width="400px" ></p>|<p align="center"><img src = "https://user-images.githubusercontent.com/52481037/98974284-15eaef00-2558-11eb-9440-f19cbe3ed129.png" align="center" width="400px" ></p>|




## 3. 이상데이터 검출 및 품질검증 시스템 생성

detail : [과제 3](https://github.com/mong-head/commento_boot_camp_DBA/blob/master/%EA%B3%BC%EC%A0%9C3/%EA%B3%BC%EC%A0%9C3_%EB%B0%B0%EC%9C%A0%EC%A7%84.pdf)
  * 해당 pdf에 어떤 것을 이상 데이터로 정하였는지 있음

품질검증을 위하여...
  1. log DB를 만들고, log table을 만듦 - 정의한 이상데이터의 로그를 남기기 위함
  2. Trigger을 이용하여, 데이터를 insert할 때마다 이상데이터인지 확인하여 로그 남김
  3. procedure을 이용하여, 품질검증 프로세스를 하나로 담아서 점검시 편함을 추구함.
  * log DB, Trigger, Procedure등을 담은 DB이미지 : 
<p align="center"><img src = "https://user-images.githubusercontent.com/52481037/98972229-82182380-2555-11eb-9af8-9b7ce43447f9.png" align="center" width="150px" ></p>
