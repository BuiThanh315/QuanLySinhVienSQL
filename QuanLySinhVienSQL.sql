create database `QuanLySinhVien`;

use QuanLySinhVien;

create table Class(
ClassID int not null auto_increment primary key,
ClassName varchar(60) not null,
StartDate datetime not null,
Status bit
);

create table Student(
StudentID int not null auto_increment primary key,
StudentName varchar(30) not null,
Address varchar(50),
Phone varchar(20),
Status bit,
ClassID int not null,
foreign key (ClassID) references Class(ClassID)
);

create table Subject(
SubID int not null auto_increment primary key,
SubName varchar(30) not null,
Credit tinyint not null default 1 check(Credit >= 1),
Status bit default 1
);

create table Mark(
MarkID int not null auto_increment primary key,
SubID int not null ,
StudentID int not null ,
Mark float default 0 check(Mark between 0 and 100),
ExamTimes tinyint default 1,
unique (SubID, StudentID),
foreign key (SubID) references Subject(SubID),
foreign key (StudentID) references Student(StudentID)
);

insert into Class(ClassName, StartDate, Status)
values
    ('A1', '2008-12-20', 1),
    ('A2', '2008-12-22', 1),
    ('B3', now(), 0);

insert into Student (StudentName, Address, Phone, Status, ClassID)
values
	('Hung', 'HaNoi', '0912113113', 1, 1),
    ('Hoa', 'HaiPhong', null, 1, 1),
    ('Manh', 'HCM', '0123123123', 1, 1);
    
insert into Subject(SubName, Credit, Status)
values
	('CF', 5, 1),
    ('C', 6, 1),
    ('HDJ', 5, 1),
    ('RDBMS', 10, 1);
    
insert into Mark(SubID, StudentID, Mark, ExamTimes)
values
	(1, 1, 8, 1),
    (1, 2, 10, 2),
    (2, 1, 12, 1);
    
select * from Student;

select * from Student where Status = true;

select * from Subject where Credit < 10;

select S.*, C.ClassName from 
Student S inner join Class C on S.ClassID = C.ClassID
where C.ClassName = 'A1';

select S.StudentID, S.StudentName, Sj.SubName, M.Mark
from Mark M inner join Student S on M.StudentID = S.StudentID
			inner join Subject Sj on M.SubID = Sj.SubID
where Sj.SubName = 'CF';

select * from Student
where StudentName like 'h%';

select * from Class
where month(StartDate) = 12;

select * from Subject
where Credit between 3 and 5;

update Student
set ClassID = 2
where StudentName = 'Hung';

select S.StudentName, Sj.SubName, M.Mark
from Mark M inner join Student S on M.StudentID = S.StudentID
			inner join Subject Sj on M.SubID = Sj.SubID
order by M.Mark desc, S.StudentName asc;

-- bài 4: Các hàm thông dụng trong SQL
select	Address, count(StudentID) as Student_count from Student
group by Address;

select S.StudentID, S.StudentName, avg(Mark) as average_score
from Student S inner join Mark M on S.StudentID = M.StudentID
group by S.StudentID, S.StudentName;

select S.StudentID, S.StudentName, avg(Mark) as average_score
from Student S inner join Mark M on S.StudentID = M.StudentID
group by S.StudentID, S.StudentName
having avg(Mark) > 15;

select S.StudentID, S.StudentName, avg(Mark) as average_score
from Student S inner join Mark M on S.StudentID = M.StudentID
group by S.StudentID, S.StudentName
having avg(Mark) >= all (select avg(Mark) from Mark group by Mark.StudentID);