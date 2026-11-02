
/*
 * SELECT
 *       조회하고자 하는 컬럼
 *  FROM
 *       테이블명;
 * 
 */

-- PATIENT 테이블에서 모든 컬럼을 전부 다 조회
SELECT * FROM PATIENT; -- 성능에 영향을 끼치므로 실무에서는 사용할 수 없음

SELECT  
       PATIENT_ID
     , PATIENT_NAME
     , DEPT_ID
     , WARD_ID
     , DOCTOR_ID
  FROM
       PATIENT; -- 항상 필요한 컬럼만 명시해서 조회
       
SELECT 
       DEPT_ID
     , DEPT_NAME
  FROM 
       DEPT;

SELECT 
       WARD_NAME
  FROM  
       WARD;
 
SELECT 
       DOCTOR_NAME
     , HIRE_DATE
  FROM 
       DOCTOR;

SELECT 
       PATIENT_NAME
     , GENDER
  FROM 
       PATIENT;

SELECT 
       BIRTH_DATE
     , PATIENT_NAME
  FROM 
       PATIENT;

SELECT 
       PATIENT_NAME
     , HEIGHT_CM
     , HEIGHT_CM /100
  FROM 
       PATIENT;

-- PATIENT 테이블로부터 환자명, 몸무게, BMI
SELECT  
        PATIENT_NAME
      , WEIGHT_KG / 
      , WHEGHT_KG /((HEIGHT_CM / 100) * (HEIGHT_CM / 100))
   FROM 
        PATIENT;

SELECT 
        PATIENT_NAME
      , ADMISSION_DATE
      , DISCHARGE_DATE
      , DISCHARGE_DATE - ADMISSION_DATE
  FROM 
        PATIENT;

-- 오늘까지 입원한 일수(오늘날짜 - 입원일)
SELECT 
       PATIENT_NAME
     , ADMISSION_DATE
     , SYSDATE - ADMISSION_DATE
   FROM
       PATIENT;

------------------------------------------------------------
/* -- ResultSet : SELECT문을 통해 조회된 데이터의 결과물 (행들의 집합)
 * 컬럼명이 너무 복잡할 떄 -> 별칭을 부여하기
 * 
 * 컬럼명 별칭, 컬럼명 AS 별칭, 컬럼명 "별칭", 컬럼명 AS "별칭"
 * 
 * < 리터럴 >
 * 오라클에서 문자열을 다룰 땐 ''을 사용
 * 문자열을 SELECT절에 기술해서 ResultSet에 조회할 수 있음
 */

SELECT  
       HEIGHT_CM AS "키(CM)"
      , 'cm'
   FROM
       PATIENT;
------------------------------------------------------------
SELECT   
       DISTINCT  BLOOD_TYPE
  FROM 
       PATIENT;

-- DISTINCT 조회시 중복제거 SELECT할 땐 한개만 사용가능

/*
 * < WHERE 절 >
 * 조건을 제시해서 조건에 만족하는 행만 조회
 * 
 * < 비교연산자 >
 * 동등비교 : =, !=
 * 대소비교 :<, >, <=, >=
 */

-- PATIENT 테이블에서 환자들의 이름, 몸무게 조회 --> 80KG이상인 사람들만 조회
SELECT 
       PATIENT_NAME
     , WEIGHT_KG
  FROM 
       PATIENT
 WHERE
       WEIGHT_KG >= 80;

-- PATIENT 테이블에서 환자들의 이름, 성별 조회
SELECT 
       PATIENT_NAME
     , GENDER
  FROM 
       PATIENT
 WHERE
       GENDER != 'F';

----------------------------------------------------------------
-- 순서 1. FROM -> 2. WHERE -> 3. SELECT
/*
 * < 논리 연산자 >
 * AND / OR
 */
-- 병동코드 W3(중환자실)이면서 키가 160cm 이상인 환자들 이름, 병동코드, 키 조회
SELECT 
       PATIENT_NAME
     , WARD_ID
     , HEIGHT_CM
   FROM 
       PATIENT;

SELECT 
       PATIENT_NAME
     , WARD_ID
     , HEIGHT_CM
   FROM
       PATIENT
  WHERE
       WARD_ID = 'W3'
   OR 
       HEIGHT_CM >= 170;

-- 실습 : 키가 160이상 170이하인 환자들의 이름 키를 조회하시오.
SELECT 
       PATIENT_NAME
     , HEIGHT_CM
  FROM
       PATIENT
  WHERE 
       HEIGHT_CM >= 160
    AND 
       HEIGHT_CM <= 170;
----------------------------------------------------------------
SELECT 
       PATIENT_NAME
     , HEIGHT_CM
  FROM 
       PATIENT
  WHERE 
       -- HEIGHT_CM BETWEEN 160 AND 170;
       HEIGHT_CM NOT BETWEEN 160 AND 170;
-- 몇 이상 몇 이하인 범위에 대한 조건을 제시할 때 <BETWEEN AND >

-- 1990년대(1990 ~ 1999)에 태어난 환자들의 이름, 생년월일 조회
SELECT 
       PATIENT_NAME
     , BIRTH_DATE
  FROM
       PATIENT
  WHERE 
       BIRTH_DATE BETWEEN TO_DATE('1990-01=01', 'YYYY-MM-DD')
                      AND TO_DATE('1999-12-31', 'YYYY-MM-DD');
---------------------------------------------------------------------
/*
 * < LIKE '특정패턴' >
 * 컬럼의 값이 지정한 특정 패턴에 만족할 경우 조회
 * 
 * '%' : 0글자 이상
 * LIKE '김%' => '김'으로 시작하는 모든 글자
 * LIKE '%김' => '김'으로 끝나는 모든 글자
 * LIKE '%김%' => '김'이 포함되는 모든 글자
 * 
 * '_' : 1글자
 * LIKE '__' => 2글자
 */
-- 환자들의 이름, 진단명 조회
SELECT 
        PATIENT_NAME
      , DIAGNOSIS
   FROM 
        PATIENT
  WHERE 
        DIAGNOSIS LIKE '급성%';

-- 이름이 2글자인 의사들만 조회
SELECT 
       DOCTOR_NAME
   FROM 
       DOCTOR
  WHERE 
       DOCTOR_NAME LIKE '__';
/*
 *  < IS NULL >
 */
-- 현재 입원 중인 환자들 조회
SELECT   
       PATIENT_NAME
     , DISCHARGE_DATE
  FROM
       PATIENT
 WHERE
       DISCHARGE_DATE IS NOT NULL;
---------------------------------------------------------
SELECT  
       PATIENT_NAME || '의 담당의 코드는 ' || DOCTOR_ID || '입니다.' 별칭
     , DOCTOR_ID
  FROM 
       PATIENT;
----------------------------------------------------------
-- 혈액형이 A형이거나 B형이거나 O형인 환자들의 이름, 혈액형
SELECT 
       PATIENT_NAME
     , BLOOD_TYPE
   FROM
       PATIENT
  WHERE
       BLOOD_TYPE NOT IN ('A', 'B', 'O');
-- 비교대상 컬럼값이 제시한 목록중에 일치하는것이 존재하는지
-------------------------------------------------------------------
-- WARD_ID가 W3이면서 성별은 M이거나 몸무게는 85이상
SELECT 
       PATIENT_NAME
     , WARD_ID
     , GENDER
     , WEIGHT_KG
  FROM
       PATIENT
 WHERE 
       WARD_ID = 'W3'
   AND 
       GENDER = 'M'
    OR   
       WEIGHT_KG >= 85;
-- 연산자 우선순위를 고려하지 않은 예시
/*
 * < 연산자 우선순위 >
 *  
 * 1. ( )
 * 2. 산술연산자
 * 3. 연결연산자
 * 4. 비교연산자
 * 5. IS NULL, LIKE, IN, BETWEEN AND
 * 6. NOT
 * 7. AND
 * 8. OR
 * -> 아리까리하면 무조건 괄호를 치는것이 정답
 * -> AND가 OR보다 먼저 묶인다는 것은 꼭 기억!!!
 */
-----------------------------------------------

SELECT * FROM PATIENT;

-- ORDER BY
SELECT 
       PATIENT_NAME
     , HEIGHT_CM
  FROM 
       PATIENT
 ORDER
    BY 
       HEIGHT_CM DESC;

-- 최근 입원한 순으로 정렬
SELECT 
       PATIENT_NAME
     , ADMISSION_DATE
  FROM 
       PATIENT
 ORDER
    BY
       ADMISSION_DATE DESC;

SELECT 
       PATIENT_NAME
     , DISCHARGE_DATE
  FROM 
       PATIENT
  ORDER
     BY
       DISCHARGE_DATE DESC NULLS LAST;

SELECT  
       PATIENT_NAME
     , HEIGHT_CM / 100 키
   FROM
       PATIENT
  WHERE
       HEIGHT_CM / 100 >= 1.5
  ORDER 
     BY 
       2 DESC;	Z
 
 
     
    










