CREATE DATABASE TEST;

use TEST;

CREATE TABLE SHOPA (
  id_customer int PRIMARY KEY NOT NULL,
  customername varchar(40),
  Storeid varchar(20) NOT NULL,
  bill_id int NOT NULL,
  billdate date  NOT NULL,
  amount decimal(8, 2)  NOT NULL
)
PARTITION BY RANGE (id_customer) (
PARTITION p0 VALUES LESS THAN (3),
PARTITION p1 VALUES LESS THAN (5),
PARTITION p2 VALUES LESS THAN (7),
PARTITION p3 VALUES LESS THAN (10),
PARTITION p4 VALUES LESS THAN (100)
);




INSERT INTO SHOPA
  VALUES (1, 'name1', 'Store1', 1000, '2015-08-08', 123.20),
  (2, 'name2', 'Store2', 1001, '2015-08-25', 4726.50),
  (3, 'name3', 'Store3', 1002, '2016-11-15', 3235.00),
  (4, 'name4', 'Store4', 1003, '2016-11-26', 7387.00),
  (5, 'name5', 'Store5', 1004, '2017-01-19', 6478.00),
  (6, 'name6', 'Store6', 1005, '2017-12-31', 8264.00),
  (7, 'name7', 'Store7', 1006, '2018-02-11', 7632.00),
  (8, 'name8', 'Store8', 1007, '2019-04-24', 3040.00),
  (9, 'name9', 'Store9', 1008, '2019-03-02', 4962.20),
  (10, 'name10', 'Store10', 1009, '2020-06-11', 7632.00),
  (11, 'name11', 'Store11', 1010, '2021-07-24', 3040.00),
  (12, 'name12', 'Store12', 1011, '2022-08-02', 4962.20);  

---Since MariaDb Didn't expose the partition details to client, Can Replicate the logic in partition


--- FUNCTION DECLARATION
DELIMITER //

CREATE FUNCTION PARTITION_NAMEC ( value INT )
RETURNS varchar(10) DETERMINISTIC

BEGIN
   DECLARE part varchar(20);
   IF value < 3 THEN
      SET part = 'p0';

   ELSEIF value >= 3 AND value < 5 THEN
      SET part = 'p1';
     
   ELSEIF value >= 5 AND value < 7 THEN
      SET part = 'p2';
      
   ELSEIF value >= 7 AND value < 10 THEN
      SET part = 'p3';
   
   ELSEIF value >= 10 AND value < 100 THEN  
      SET part = 'p4';

   ELSE
      SET part = 'NULL';

   END IF;

   RETURN part;

END; //

DELIMITER ;


SELECT PARTITION_NAME (id_customer) FROM SHOPA WHERE id_customer=10;


