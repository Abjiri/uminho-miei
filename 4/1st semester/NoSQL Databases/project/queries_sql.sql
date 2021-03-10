/* (ID=101) todos os empregados com quem um certo empregado ja trabalhou */ EXEC TIME = 288ms
with depAtual AS (SELECT department_id, hire_date from Employees where employee_id=101),
    depsAntigos AS (SELECT department_id, start_date, end_date from Job_history where employee_id=101)
select distinct(e.employee_id), concat(concat(e.first_name,' '), e.last_name) as Nome
from depAtual dAt, depsAntigos dAnt, Employees e, Job_history jh
where e.employee_id != 101 and e.department_id = dAt.department_id /* empregados no mesmo departamento atual do empregado 101 */
or (jh.department_id = dAt.department_id and jh.end_date > dAt.hire_date and jh.employee_id = e.employee_id) /* empregados que trabalharam no departamento atual com o empregado 101 mas já saíram */
or (e.department_id = dAnt.department_id and e.hire_date < dAnt.end_date) /* empregados que trabalham atualmente num dos departamentos antigos do empregado 101 e ja estavam lá antes de ele sair */
or (jh.employee_id = e.employee_id and jh.department_id = dAnt.department_id and ( /* empregados que num emprego antigo trabalharam com o empregado 101 num dos seus empregos antigos */
    (jh.start_date > dAnt.start_date and jh.start_date < dAnt.end_date) or 
    (jh.end_date > dAnt.start_date and jh.end_date < dAnt.end_date) or
    (jh.start_date < dAnt.start_date and jh.end_date > dAnt.end_date)))
order by employee_id;

/* top 5 empregados mais antigos em cada regiao */ EXEC TIME = 76ms
select Regiao, Nome, Data_Inicio
from (select r.region_name as Regiao, concat(concat(e.first_name,' '), e.last_name) as Nome, e.hire_date as Data_Inicio,
      rank() over (partition by r.region_name order by e.hire_date asc, concat(concat(e.first_name,' '), e.last_name) asc) rank
      from employees e 
        inner join departments d on e.department_id=d.department_id
        inner join locations l on l.location_id=d.location_id
        inner join countries c on c.country_id=l.country_id
        inner join regions r on r.region_id=c.region_id
     )
where rank <= 5;

/* (ID = 176) trabalho em que um user (com varios trabalhos no historico) faturou mais */ EXEC TIME = 12ms
select j.JOB_TITLE as Emprego, jh.start_date as DataInicial, jh.END_DATE  as DataFinal, Round((MONTHS_BETWEEN (jh.end_date,jh.start_date))*j.MAX_SALARY,2) as Faturado from EMPLOYEES e
inner join JOB_HISTORY jh on e.EMPLOYEE_ID = jh.EMPLOYEE_ID 
inner join JOBS j on jh.JOB_ID = j.JOB_ID
inner join Departments d on d.department_id = jh.department_id
where e.EMPLOYEE_ID = 176
order by (MONTHS_BETWEEN (jh.end_date,jh.start_date))*j.MAX_SALARY desc
fetch first 1 rows only;

/* Media de salarios por departamento */ EXEC TIME = 35ms
select d.department_name as Departamento, round(avg(e.salary),2) as Media_Salario from employees e
inner join departments d on e.department_id=d.department_id
group by d.department_name
order by Media_Salario desc;

/* Total de empregadaos que trabalharam em cada departamento */ EXEC TIME = 27ms
with employees_by_dep as (
    select d.department_id, jh.employee_id from Departments d, Job_history jh where jh.department_id = d.department_id
    union all
    select d.department_id, e.employee_id from Departments d, Employees e where e.department_id = d.department_id)
select department_id as Departamento, count(distinct(employee_id)) as Total
from employees_by_dep 
group by department_id 
order by Total desc, department_id;
