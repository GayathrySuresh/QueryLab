//Write a SQL to find trade couples satisfying following conditions for each stock :

1- The trades should be within 10 seconds of window

2- The prices difference between the trades should be more than 10%//

--Create Table

Create Table Trade_tbl(
TRADE_ID varchar(20),
Trade_Timestamp time,
Trade_Stock varchar(20),
Quantity int,
Price Float
)

--Insert values

Insert into Trade_tbl Values('TRADE1','10:01:05','ITJunction4All',100,20)
Insert into Trade_tbl Values('TRADE2','10:01:06','ITJunction4All',20,15)
Insert into Trade_tbl Values('TRADE3','10:01:08','ITJunction4All',150,30)
Insert into Trade_tbl Values('TRADE4','10:01:09','ITJunction4All',300,32)
Insert into Trade_tbl Values('TRADE5','10:10:00','ITJunction4All',-100,19)
Insert into Trade_tbl Values('TRADE6','10:10:01','ITJunction4All',-300,19)



--Query


WITH Join_tbl as
(SELECT T1.trade_id as id1, T2.trade_id as id2,
CASE WHEN T1.trade_timestamp > T2.trade_timestamp  THEN T1.trade_timestamp - T2.trade_timestamp 
WHEN T2.trade_timestamp > T1.trade_timestamp  THEN T2.trade_timestamp - T1.trade_timestamp END as wndo,
 CASE WHEN T2.price > T1.price THEN (((T2.price - T1.price)/T2.price)*100)
WHEN T1.price > T2.price THEN (((T1.price - T2.price)/T1.price)*100) END as percent_diff
FROM Trade_tbl T1
JOIN Trade_tbl T2
ON T1.trade_id <> T2.trade_id)

SELECT id1, id2, wndo, ROUND(percent_diff::numeric, 2)
FROM Join_tbl 
WHERE wndo <= '00:00:10' AND id1 < id2 AND percent_diff > 10




