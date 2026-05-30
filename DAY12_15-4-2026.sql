# inout example
CREATE PROCEDURE `INOUTPARAMETER` (IN DID INT,
									OUT SL INT,
                                    OUT MX INT,
                                    OUT MN INT,
                                    OUT AG INT)
BEGIN
SELECT SUM(SALARY),MAX(SALARY),MIN(SALARY),avg(SALARY) INTO SL,MX,MN,AG FROM MYEMP
WHERE DEP_ID=DID;
END


  #INOUT PARAMETER
call excelr.INOUTPARAMETER(50, @SL, @MX, @MN, @AG);
select @SL, @MX, @MN, @AG;


#LOOP=LOOP WILL RUN ON PROCEDURE OR STEPS CONTINUOULSY UNTIL CONDTIONS ARE SATISFIED OR MET THEN IT WILL STOP ONCE CONDITION IS SATISFIED



#ERROR HANDLING-CONSIDER THE ERRORS WHEN THE QUERY IS RUNNING
  #BY USING CONTINUE HANDLER AND EXIT HANDLER

  SELECT *FROM PAYMENTS;
  SELECT *FROM FRAUD;
  
  DESC PAYMENTS;
  
INSERT INTO PAYMENTS VALUES(1,2000);
INSERT INTO PAYMENTS VALUES(2,3000);
INSERT INTO PAYMENTS VALUES(3,null);#IF U RUN THE DESC THING U WILL GET TO KNOW THAT THIS NULL IS NOT ALLWOED HERE
	

    
    /* HERE if i try to insert the null value to the payments table it will not allow it
    so by using the error handling function in stored procedure we can redirect those null
    values to the fraud table 
    the condition for this will be see in the ERROR_HANDLING stored procedure
    */
    
    
    
       #CURSOR
	# READING THE DATA FROM ONE TABLE AND WRITING IN ANOTHER TABLE[1:34]
    
    
   SELECT *FROM PRODUCTS;
   desc products;
   SELECT *FROM ORDERS;
   desc orders;
   
      

