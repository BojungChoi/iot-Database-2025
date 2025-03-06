-- WorkBook SQL Practice
/* 샘플 - Employee에서 사원번호, 이름, 급여, 업무, 입사일, 상사의 사원번호를 출력하시오. 
이때 이름은 Full Name 이라는 별칭으로 출력하시오.(107행)
*/
SELECT employee_id
		, concat(first_name,' ', last_name) as 'fullname'
		, salary
		, job_id
		, hire_date
		, manager_id
  FROM employees;

/* 문제 1 : employee 에서 사원의 성과 이름을 Name, 업무는 Job, 급여는 Salary, 연봉에 $100 보너스를 추가해서 계산한 Increased Ann_Salary
			급여에 $100 보너스를 추가해서 Increased Salary 별칭으로 출력하시오.(107행)
*/
SELECT  concat(first_name,' ', last_name) as 'name'
		, job_id as 'Job'
        , salary as 'Salary'
        , (salary * 12) + 100 as 'Increased Ann_Salary'
		, (salary + 100) * 12 as 'Increased Salary'
  FROM employees;
  
  /* 문제 2 : employee 에서 모든 사원의 last_name 과 연봉을 '이름: 1 year Salary = $연봉' 형식으로 출력하고, 1 Year Salary 라는 별칭으로 붙이세요.(107행)
*/
SELECT concat(first_name,': 1Year Salary = $', (salary * 12)) as '1 Year Salary'
  FROM employees;


/* 문제 3 : 부서에 담당하는 업무를 한번씩만 출력하시오,(20행)

*/
SELECT DISTINCT department_id, job_id
	FROM employees;

  
-- WHERE, ORDER BY
/* 샘플 - HR부서 예산 편성 문제로 급여 정보 보고서를 작성한다. employees 에서 Salary가 7000~10000 달러 범위 이이의 사람의
			성과 이름을 Name 해서 급여를 작은 순서로 출력하시오(75행)
*/
SELECT concat(first_name,' ',last_name) as 'Name'
	 , salary
 FROM employees
WHERE salary not between 7000 and 10000
order by salary;

/* 문제1 : 사원의 last_name 중에서 'e' 및 'o' 라는 글자가 포함된 사원을 출력하시오 이때, 머리글은 e AND o Name 이라고 출력하시오
*/
SELECT concat(first_name,' ',last_name) as 'e AND o Name'
 FROM employees
WHERE last_name LIKE '%e%' and last_name LIKE '%o%';

/* 문제 2 : 현재 타입을 날짜 함수를 통해 확인하고, 1995년 5월20일부터 1996년 5월 20일 사이에 고용된 사원들의 이름(Name으로 별칭)
			, 사원번호, 고용 일자를 출력하시오. 단, 입사일이 빠른 순으로 정렬하시오(8행)
*/
SELECT date_add(sysdate(), interval 9 hour) as 'sysdate()';

desc employees;

SELECT last_name as 'Name'
	 , employee_id
     , hire_date
 FROM employees
WHERE hire_date BETWEEN '1995-05-20' and '1996-05-20' -- data타입은 문자열처럼 조건연산을 해도됨
order by hire_date ASC;

-- 단일행 함수 및 변환 함수
/* 문제 1 - 이름이 's'로 끝나는 각 사원의 이름과 업무를 아래의 예와 같이 출력하고자 한다.
			출력 시 성과 이름 첫글자는 대문자로, 업무는 대문자로 출력하고 머리글은 Employee JOBs. 로 표현하시오(18행)
*/

SELECT concat(first_name,' ', last_name, ' is a ', upper(job_id)) as 'Employee JOBs.'
  FROM employees
 WHERE last_name LIKE '%s';
 
/* 문제 3 : 사원의 성과 이름을 Name으로 별칭, 입사일, 입사한 요일을 출력하시오. 이때 주(week) 시작인 일요일부터 출력되도록 정렬(107행)
*/
SELECT concat(first_name,' ',last_name) as 'name'
	 , hire_date
     , date_format(hire_date, '%W') as 'Day of the week'
  FROM employees
 ORDER BY date_format(hire_date, 'w') asc;
 
 -- 집계함수
 /* 문제 1 : 사원이 소속된 부서별 급여 합계, 급여 평균, 급여 최대값, 급여 최소값을 집계.
			출력값은 여섯자리와 세자리 구분기호, $ 표시 포함, 부서번호를 오름차순
            단, 부서에 소속되지 않는 사원은 정보에서 제외, 출력시 머리글은 아래처럼 별칭으로 처리(11개행)
 */
 
SELECT * FROM employees;


SELECT department_id
	 , concat('$', format(round(sum(salary), 0),0)) as 'Sum salary'
     , concat('$', format(round(avg(salary), 1),1)) as 'Avg salary' -- round(값, 1), 소수점 1자리에서 반올림, format(값, 1) 소수점표현 및 1000단위 , 표시
     , concat('$', format(round(max(salary), 0),0)) as 'Max salary'
     , concat('$', format(round(min(salary), 0),0)) as 'Min salary'
  FROM employees
 WHERE department_id is not null -- department_i 그룹에 null 값이들어간컬럼은 포함시키지 않는다.
 GROUP BY department_id; -- 그룹바이에 속한 컬럼만 select 절에 사용할 수 있음!!!
 
 -- 조인
 /* 문제 2 - job_grades 테이블을 사용, 각 사원의 급여에 따른 급여등급을 보고한다. 이름과 성을 name으로, 업무, 부서명, 입사일, 급여, 급여등급을 출력(106행)
 */

DESC job_grades;
DESC employees;

select *
  from jobs;

select *
  from job_grades;
  
select *
  from employees;
 
select *
  from departments as d inner join employees as e
 where d.department_id = e.department_id;  -- ANSI Standard SQL 쿼리
 
select concat(e.first_name,' ',e.last_name) as 'name'
	 , e.job_id
     , d.department_name
     , e.hire_date
     , e.salary
     , (select grade_level from job_grades 
		where e.salary BETWEEN lowest_sal and highest_sal) as 'grade_level'
  from departments as d, employees as e
 where d.department_id = e.department_id
 order by e.salary desc;

