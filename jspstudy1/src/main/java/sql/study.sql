drop table board;
create table board (
   num int primary key, --게시글 번호. 기본키
   writer varchar(30), -- 작성자 이름
   pass varchar(20), -- 비밀번호
   title varchar(100), --글 제목
   content varchar(2000),  --글내용
   file1 varchar(200), --첨부파일 이름
   boardid varchar(2), --게시물종류 1.공지사항 2.자유게시판 3.Q&A
   regdate datetime, --등록일시
   readcnt int(10), --조회수, 상세보기 시 1씩 증가
   grp int,         --답글 작성 시 원글의 게시글 번호
   grplevel int(3), --답글의 레벨.
   grpstep  int(5)  --해당 그룹의 출력 순서
   );

   

 select * from board

create table member (
 id varchar(20) primary key,
 pass varchar(20),
 name varchar(20),
 gender int(1),
 tel varchar(15),
 email varchar(20),
 picture varchar(200)


);


alter table member modify email varchar(50);
select * from member


create table book (
    writer varchar(30) primary key,
    title varchar(100),
    content varchar(1000)
) 

select * from book

drop table comment;
create table comment (
  num int references board (num),
  seq int,
  writer varchar(30),
  content varchar(2000),
  regdate datetime,
  primary key (num,seq)
  
  )
  
select * from comment
select * from student