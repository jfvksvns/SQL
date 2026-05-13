#I HAD CRETED THE 3 TABLES IN DAY6 FILE
#BELOW ARE THE SELECTION QUERY RELATED TO PAST CREATED TABLES

select a.order_id,
	    a.order_date,
        a.customer_id,
        a.product_id,
        b.name as customer_names,
        c.product_name
        from  orderss as a
        inner join
        customers as b
        on a.customer_id=b.customer_id
        inner join
        productss as c
        on a.product_id=c.product_id;
        
        
        /*self join- it is applied on single table and when you have same type of columns,
        to find the hierarchical details we can use self join*/
        
        select *from myemp;/*in this table both emp_id and mgr_id are same 
        bcz the mgr is also the emp only*/
        #it is most used in HR related data
                
select  e.emp_id,
        e. mgr_id,
        m.first_name
        from myemp as e
        inner join 
        myemp as m
        on e.mgr_id=m.emp_id;
        
        
/*constraint-rules applying on table
  keys-primary key,foriegn key
  domain contraints-unique, not null,check,default
  */
  
  /*#types of : primary key,foriegn key,unique 
primary key: will not allows nulls
unique: will allow one null */
  
  create table student(sid int primary key,
              snames varchar(30) not null,
              age int check (age>25),
              course varchar (30) default"mysql");
              
insert into student (sid,snames,age) values(1,"anil",26);
select *from student;
insert into student (sid,snames,age) values(1,"anil",26);   
insert into student (sid,snames,age) values(2,null,26);
insert into student(sid,snames,age) values(3,"abhi",22);