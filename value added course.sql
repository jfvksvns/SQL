create database jan_26;
use jan_26;


create table Sample (Sno int , Sname char(10) , city char(10) );
show tables;
describe Sample;

insert INTO Sample values(1,"gru", "banglore");
insert into sample values(2, "jhiii" , "KA");
insert into sample values(3,"fugaerh" , "hniuarhg"),(4, "dfg","addgaer"),(5,"ercgserg","setgvae");

alter table sample add column age tinyint;
alter table sample add column sales int;# adding the column
alter table sample drop column age , drop column sales;# droping the columns 
insert into sample values(6,"guruuur","mumbai",58,252525);

insert into sample values(7,"sdfghs","sdffhsgdfg",250,55652);#shows error bcz age 250 is more than tinyint
alter table sample modify column age int;#this will age datatype to int 
insert into sample values(7,"sdfghs","sdffhsgdfg",250,55652);# now the age 250 will accepts

alter table sample change column age qunatity int;# it will change age to quantity
alter table sample drop column qunatity;# just deleted the qunatity column


rename table sample to example;# changing the name of the table 
rename table example to sample;




select * from sample;

create table example( sno int , name char);# new table created
truncate example;#deleted the example table
show tables;
drop table example;# completly delete the table
