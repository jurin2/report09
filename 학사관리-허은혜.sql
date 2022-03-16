drop database if exists 학사관리;
drop user if exists admin_db@localhost;
create database 학사관리;
create user admin_db@localhost identified with mysql_native_password by 'admin_db';
grant all privileges on 학사관리.* to admin_db@localhost with grant option;
show databases;

use 학사관리;
show tables;

create table 학과(
	학과번호 varchar(10) not null unique,
    학과명 varchar(20) not null,
    학과전화번호 varchar(14) not null unique,
    primary key(학과번호)
);
desc 학과;

create table 학생(
	학생번호 varchar(10) not null unique,
	학생이름 varchar(10) not null,
    학생주민번호 varchar(14) not null unique,
    학생주소 varchar(100) not null,
    학생전화번호 varchar(14) not null unique,
    학생이메일 varchar(30) not null,
    학과번호 varchar(10) not null,
    primary key(학생번호),
    foreign key(학과번호) references 학과(학과번호)
);
desc 학생;

create table 교수(
	교수번호 varchar(10) not null unique,
    교수이름 varchar(10) not null,
    교수주민번호 varchar(14) not null unique,
    교수주소 varchar(100) not null,
    교수전화번호 varchar(14) not null unique,
    교수이메일 varchar(30) not null,
    학과번호 varchar(10) not null,
    primary key(교수번호),
    foreign key(학과번호) references 학과(학과번호)
);
desc 교수;

create table 강좌(
	강좌번호 varchar(10) not null unique,
    강좌명 varchar(45) not null,
    취득학점 int not null,
    강의시간 int not null,
    강의실정보 varchar(50) not null,
    교수번호 varchar(10) not null,
    primary key(강좌번호, 교수번호),
    foreign key(교수번호) references 교수(교수번호)
);
desc 강좌;

create table 수강내역(
    출석점수 int not null,
    중간고사점수 int not null,
    기말고사점수 int not null,
    기타점수 int not null,
    총점 int not null,
    평점 int not null,
    강좌번호 varchar(10) not null,
    학생번호 varchar(10) not null,
    primary key(출석점수,강좌번호,학생번호),
    foreign key(강좌번호) references 강좌(강좌번호),
	foreign key(학생번호) references 학생(학생번호)
);
desc 수강내역;

create table 담당(
    학년학기 varchar(10) not null,
    교수번호 varchar(10) not null,
    학생번호 varchar(10) not null,
    primary key(학년학기,학생번호),
    foreign key(교수번호) references 교수(교수번호),
	foreign key(학생번호) references 학생(학생번호)
);
desc 담당;


-- 자료 삽입
insert into 학과 values('1001','간호학과','010-111-2222');
insert into 학과 values('1002','건축학과','010-222-3333');
insert into 학과 values('1003','컴퓨터학과','010-333-4444');
insert into 학과 values('1004','경영학과','010-444-5555');
insert into 학과 values('1005','패션디자인학과','010-555-6666');
select * from 학과;

insert into 학생 values('22010101','홍길동','123456-1234567','인천시 서구','010-111-1111','pam7461@naver.com','1004');
insert into 학생 values('22010102','이몽룡','234561-2345678','인천시 남구','010-222-2222','pam7424@naver.com','1004');
insert into 학생 values('22010103','성춘향','345678-3456789','서울시 노원구','010-333-3333','pam7444@naver.com','1002');
insert into 학생 values('22010104','강감찬','456789-4567890','대구시 중구','010-444-4444','pam7498@naver.com','1005');
insert into 학생 values('22010105','장미희','567890-5678901','부산시 해운대구','010-555-5555','pam7154@naver.com','1005');
insert into 학생 values('22010106','유덕화','678901-6789012','부산시 사하구','010-666-6666','pam7871@naver.com','1001');
insert into 학생 values('22010107','이월매','789012-7890123','경기도 오산시','010-777-7777','pam7123@naver.com','1002');
insert into 학생 values('22010108','한나래','890123-8901234','서울시 성북구','010-888-8888','pam7971@naver.com','1001');
insert into 학생 values('22010109','유시원','901234-9012345','경기도 시흥시','010-999-9999','pam8042@naver.com','1003');
insert into 학생 values('22010110','최정원','901243-9012354','경기도 시흥시','010-123-1234','pam8011@naver.com','1003');
select * from 학생;

insert into 교수 values('201526','강교수','112345-1234567','인천시 서구','010-122-1222','kang111@naver.com','1004');
insert into 교수 values('201624','김교수','223456-2345671','경기도 시흥시','010-233-2333','kim111@naver.com','1005');
insert into 교수 values('201214','이교수','334567-3456789','서울시 노원구','010-344-3444','lee111@naver.com','1001');
insert into 교수 values('201415','박교수','445678-4567890','인천시 동구','010-455-4555','park111@naver.com','1002');
insert into 교수 values('201784','허교수','556789-5678901','경기도 오산시','010-566-5666','heo111@naver.com','1003');
insert into 교수 values('201845','서교수','667890-6789012','서울시 성북구','010-677-6777','seo111@naver.com','1005');
select * from 교수;

insert into 강좌 values('11111', '인체해부학', 3, 80, '2번 강의실', '201214');
insert into 강좌 values('22222', '건축재료 및 설계', 3, 60, '3번 강의실', '201415');
insert into 강좌 values('33333', 'JAVA SCRIPT', 3, 60, '4번 강의실', '201784');
insert into 강좌 values('44444', '글로벌 매너와 스피치', 3, 60, '1번 강의실', '201526');
insert into 강좌 values('55555', '기초봉제', 3, 90, '5번 강의실', '201624');
select * from 강좌;

insert into 수강내역 values(10, 40, 40, 5, 95, 95, '11111', '22010102');
insert into 수강내역 values(5, 30, 20, 5, 60, 60, '22222', '22010103');
insert into 수강내역 values(5, 35, 40, 10, 90, 90, '11111', '22010104');
insert into 수강내역 values(10, 20, 20, 5, 55, 55, '33333', '22010105');
insert into 수강내역 values(5, 25, 25, 5, 60, 60, '44444', '22010106');
insert into 수강내역 values(0, 10, 10, 0, 20, 20, '55555', '22010107');
insert into 수강내역 values(10, 40, 20, 5, 75, 75, '22222', '22010108');
insert into 수강내역 values(10, 15, 25, 10, 60, 60, '33333', '22010109');
insert into 수강내역 values(10, 30, 25, 5, 70, 70, '55555', '22010110');
select * from 수강내역;

insert into 담당 values('1학년 2학기', '201526','22010101');
insert into 담당 values('2학년 1학기', '201526','22010102');
insert into 담당 values('1학년 2학기', '201415','22010103');
insert into 담당 values('3학년 2학기', '201624','22010104');
insert into 담당 values('1학년 1학기', '201845','22010105');
insert into 담당 values('2학년 2학기', '201214','22010106');
insert into 담당 values('4학년 1학기', '201415','22010107');
insert into 담당 values('3학년 1학기', '201214','22010108');
insert into 담당 values('1학년 2학기', '201784','22010109');
insert into 담당 values('4학년 2학기', '201784','22010110');
select * from 담당;


-- 수강하지 않은 학생 명단 출력
select  *
from 학생 where 학생번호 not in (select 학생번호 from 수강내역);


-- 교수별 담당학생 명단 출력
select 교수번호, 교수이름 , 학생번호, 학생이름
from 교수 join 학생 on 교수.학과번호 = 학생.학과번호;


-- 컴퓨터학과 자료의 학과번호 학과명 변경
select * from 학과;
set foreign_key_checks = 0;
update 학과
set 학과번호='0111', 학과명='컴퓨터공학과'
where 학과명='컴퓨터학과';
set foreign_key_checks = 1;
select * from 학과;


-- 강좌 진행하지 않는 교수 관련 자료 삭제
select * from 담당;
delete from 담당 where 교수번호=(
	select  교수번호
	from 교수 where 교수번호 not in (select 교수번호 from 강좌)
);
select * from 담당;
