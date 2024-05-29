use sql_challenge;

/*
Write SQL to get the most recent / latest balance, and TransactionID for
each AccountNumber
*/

/*
Create Table transaction_table
(
AccountNumber int,
TransactionTime DateTime,
TransactionID int,
Balance int
)


Insert into Transaction_Table Values (550,'2099-05-12 05:29:44.120' ,1001,2000)
Insert into Transaction_Table Values (550,'2099-05-15 10:29:25.630' ,1002,8000)
Insert into Transaction_Table Values (460,'2099-03-15 11:29:23.620' ,1003,9000)
Insert into Transaction_Table Values (460,'2099-04-30 11:29:57.320' ,1004,7000)
Insert into Transaction_Table Values (460,'2099-04-30 12:32:44.233' ,1005,5000)
Insert into Transaction_Table Values (640,'2099-02-18 06:29:34.420' ,1006,5000)
Insert into Transaction_Table Values (640,'2099-02-18 06:29:37.120' ,1007,9000)
*/

--select * from transaction_table;

--Method 1

with Latest_Trans as
(
select AccountNumber,
		max(TransactionTime) as Latest_Trans_Time
from transaction_table
group by AccountNumber
)
select lt.AccountNumber,
		lt.Latest_Trans_Time as Transaction_Time,
		tt.Balance as Account_Balance,
		tt.TransactionID
from transaction_table tt
right join Latest_Trans lt on tt.AccountNumber = lt.AccountNumber
and tt.TransactionTime = lt.Latest_Trans_Time
order by tt.TransactionID asc


--Method 2

with ranked_latest_trans as(
select *,
		row_number() over(partition by AccountNumber order by TransactionTime desc) as Latest_Flag
from transaction_table
)
select rlt.AccountNumber,
		rlt.TransactionTime,
		rlt.Balance as Account_Balance,
		rlt.TransactionID
from ranked_latest_trans rlt
where Latest_Flag = 1
order by rlt.TransactionID asc





-- Method 3

with latest_trans_time as(
select *,
		max(TransactionTime) over(partition by AccountNumber) as Latest_Trans_Time
from transaction_table
)
select AccountNumber,
		TransactionID,
		Balance as Account_Balance,
		Latest_Trans_Time as Transaction_Time
from latest_trans_time
where Latest_Trans_Time = TransactionTime
order by TransactionID