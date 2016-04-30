/*data type*/
/*
%%%%%%%%%number
-------------------------------------------------
type          |  range 1       |   range 2
-------------------------------------------------
tinyint       | (-128, 127)    | (0, 255)
smallint      | (-32768,32767) | (0, 65535)
mediumint     |-8388608,8388607| 0, 16777215
int or integer|                |
bigint        |                |
float         |                |
double        |                |
decimal       |                | 
-------------------------------------------------

%%%%%%%%date and time
-------------------------------------------------
type        | form              |usage
-------------------------------------------------
date        | yyyy-mm-dd        | date
time        | hh:mm:ss          | time
year        | yyyy              | yeat
datetime    | yyyy-mm-dd        | mixture of date
			  hh:mm:ss            and time
timestamp   | yyyymmdd          |
              hhmmss
-------------------------------------------------

%%%%%%%string
-------------------------------------------------
type          | usage
-------------------------------------------------
char          | length is fixed
varchar       | length is not fixed
tinyblob      | length <= 255
tinytext      | 
blob          | 
text          |
mediumblob    |
mediumtext    |
longblob      |
longtext      |
------------------------------------------------

*/

/*create table*/
create table department (
deptcode int primary key,
deptname varchar(15) unique,
deptcity varchar(15)
);

/*add values*/
insert into department
(deptcode, deptname, deptcity)
values (100004, 'iit', 'chicago');

insert into department
(deptcode, deptname, deptcity)
values (100005, 'uic', 'chicago');

insert into department
(deptcode, deptname, deptcity)
values (100006, 'ucsd', 'ca');

insert into department
(deptcode, deptname, deptcity)
values (100008, 'ucr', 'ca');

insert into department values (100009, '', '');
insert into department values (100010, '', '');
insert into department values (100011, null, null);

/* select */
select * from department; /*    * represents everything*/

desc department; /*show how this table looks like*/

select deptcity from department where deptcity = 'chicago';

select * from department where deptcity = 'chicago';

select * from department where deptname like 'uc%';
/* like is similar to = */
/* uc% means begins with uc
   %uc means ends with uc */

/* update the values in tables*/
update department set deptcity = 'riverside' 
where deptname = 'urc';

/* delete values*/
delete from department where deptcode = 100009;

/* sort */
select * from department order by deptcode desc;
/* increasing order by default*/

/* group */
select deptname, count(*) from department group by deptname;

select deptcity,
sum(deptcode) as codesum /* add the sum of deptcode as a new column named codesum*/
from department group by deptcity
with rollup;
/* in the output data, null the total*/
/* rename the null*/
select coalesce(deptcity, 'total'), /*rename the null as total*/
sum(deptcode) as codesum 
from department group by deptcity with rollup;

/* join */
/*
inner join: intersection
left join: all data from the left table, and the data in the right table
           which is the same with data in the left table
right join: similar to the left join. all data from the right table
*/

create table lecture
(leccode int primary key,
lecname varchar(15),
lecgrade int(1),
deptcode int);

insert into lecture values 
(433, 'math', 1, 100004),
(434, 'english', 1, 100004),
(455, 'math', 3, 100008),
(466, 'english', 2, 100008),
(477, 'math', 1, 100005);
insert into lecture values(467, 'math', 2, 100000);

select * from department;
select * from lecture;

select * from department inner join lecture
on department.deptcode = lecture.deptcode;/*tablename.columnname*/

select * from department a /*use a short for department*/
inner join lecture b /* use b short for lecture*/
on a.deptcode = b.deptcode; 

select * from department left join lecture
on department.deptcode = lecture.deptcode;
/*show all data in department even there is no matched value in lecture*/

select * from department right join lecture
on department.deptcode = lecture.deptcode;
/* show all data in lecture even there is no matched value in department*/

/* null value*/
select * from department where deptcity = null;
select * from department where deptcity is null;
/* =null does not work. 
   should use is null or is not null*/


/* regular expression*/
/*
------------------------------------------------
    ^   | the begining
    $   | the end
  [...] | any element. [abc] -> 'a' in 'plain'
  [^...]| not included in it.'[^abc] -> 'p' in 'plain'
  a|b   | a or b. (a|b)cd -> acd or bcd
  *     | zo* -> z or zoo
  +     | zo+ -> zo or zoo, but not z
  {n}   | n is 0 or a positive number. o{2}-> food; 
          e{3}-> feeed, but not feed, exactly 3 e.
{n, m}  | n<m. at leat n time, at most m times
          w{2, 4} -> ww, www, or wwww
------------------------------------------------
*/
select * from department 
where deptname regexp '^uc';
/*show the deptname begin with uc*/

select * from department
where deptname regexp 'i{2}';
/*show the deptname containing 'ii'  */

/* transaction */
/*
- atomicity
- consistency
- isolation
- durability
*/

/* alter */
alter table department add i int; /*add a integer column named i*/
show columns from department;

alter table department drop i;/* delete column named i*/
show columns from department;

alter table department add i int after deptname;
/* add new column right after deptname*/

alter table department modify i char(10);/*change data type*/
show columns from department;

alter table department change i i int; /* change data type*/
show columns from department;

alter table department change i j int; /* change name*/
show columns from department;

alter table department add m int;
alter table department modify m int default 10;
/* the value of m by default is 10*/
select * from department;

alter table department alter m set default 100;
/* change the default value*/
show columns from department;

alter table department alter m drop default;
/* delete the default value*/
show columns from department;

/* change the name of table*/
alter table department rename to deptinfo;
show table status like 'deptinfo';
show table status like 'department'; /*no information*/

alter table deptinfo rename to department;

/* change the type of table*/
/*
alter table department type= tabletype;
*/

/*  index   */
/* create index after the table is created */
create index indexcity on department(deptcity(10));

/* create index when the table is created */
create table evaluation (
deptcode int (6) primary key,
deptname char (15),
scores int(3),
index indexdeptname (deptname(15)));

/* delete index */
drop index indexcity on department;


/* unique index */
create unique index indexdname on department(deptname(11));

create table evaluation_lec
(leccode int (3),
lecname char(15),
scores int(1),
unique indexlecname (lecname(15)));

/* show the information of index*/
show index from department;

/* temporary table */
create temporary table temtable(
a varchar (20) not null,
b decimal (12, 2) not null default 0.00,
c decimal (10, 1) not null default 0.0,
d int unsigned not null default 0);

select * from temtable;

/*delete this temporary table */
drop table temtable;
select * from temtable;

/* copy table */

/*show the detials of the table*/
show create table evaluation_lec;

/*create a same new table, only change the table name*/
create table evaluation_lec_clone
(leccode int (3),
lecname char(15),
scores int(1),
unique indexlecname (lecname(15)));

/*insert the values from the original table into the new table*/
insert into evaluation_lec_clone 
select * from evaluation_lec;

/* AUTO_INCREMENT */
create table student (
id int unsigned not null auto_increment primary key,
courses int (2) not null
);

insert into student values
(null, 2),
(null, 5),
(null, 3);
select * from student;

/* repetitions */
select count(*) as repetitions, deptcity
from department
group by deptcity
having repetitions > 1;

/* read data which is not repeted*/
select distinct deptcity from department;
