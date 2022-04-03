--************START CREATING TABLE ******************************---------------
create table user_info(
user_id varchar2(6) primary key,
user_type varchar(11));
---------------------------------------------------------------------------------
create table customer_master(
cust_id varchar2(6) primary key,
cust_name varchar(25)Not null,
cust_add varchar(60) Not null,
cust_phone_no number(10)Not null,
cust_email_add varchar(20),
constraint ck_customer_master check(cust_id like 'c%'));
commit;
--------------------------------------------------------------------------------
create table salesman_master(
seller_id varchar2(6) primary key,
seller_name varchar(25)not null,
seller_add varchar(60) not null,
seller_phone_no number(10) not null,
seller_email_add varchar(20),
constraint ck_salesman_master check(seller_id like 's%'));
commit;
------------------------------------------------------------------------------
create table category_master(
pro_cat_id varchar2(6) primary key,
pro_cat_type varchar(10) not null);
commit;
-------------------------------------------------------------------------------
create table product_master(
prod_id varchar2(6) primary key,
pro_name varchar(20)not null,
color varchar(11),
pro_size varchar(11),
qty_on_hand number(8)not null,
price decimal(8,2) Not Null,
seller_id varchar2(6),
FOREIGN KEY (seller_id)REFERENCES salesman_master(seller_id),
pro_cat_id varchar2(6),
FOREIGN KEY (pro_cat_id)REFERENCES category_master(pro_cat_id),
constraint ck_product_master check(prod_id like 'p%'));
--------------------------------------------------------------------------------
create table sales_order(
order_id varchar2(6) primary key,
order_date date not null,
order_status varchar(15)not null,
cust_id varchar2(6) not null,
FOREIGN KEY(cust_id)REFERENCES customer_master(cust_id),
seller_id varchar2(6) not null,
FOREIGN KEY(seller_id)REFERENCES salesman_master(seller_id),
constraint ck_sales_order check(order_id like 'o%'));
--------------------------------------------------------------------------------
create table sales_order_details(
prod_id varchar2(6) not null,
FOREIGN KEY(prod_id)REFERENCES product_master(prod_id),
order_id varchar2(6)not null,
FOREIGN KEY(order_id)REFERENCES sales_order(order_id),
qty_ordered number(8)not null,
pro_rate decimal(8,2) not null,
primary key(order_id,prod_id));
commit;
--------------------------------------------------------------------------------
create table payment_info(
payment_id varchar2(6) primary key,
payment_type varchar(15)not null,
payment_date date not null,
cust_id varchar2(6) not null,
FOREIGN KEY(cust_id)REFERENCES customer_master(cust_id),
order_id varchar2(6) not null,
FOREIGN KEY(order_id)REFERENCES sales_order(order_id),
constraint ck_payment_info check(payment_id like 'py%'));
commit;
--------------------------------------------------------------------------------
create table product_history(
price_chng_id DECIMAL(12) NOT NULL PRIMARY KEY,
prod_id varchar2(6)not null,
FOREIGN KEY(prod_id)REFERENCES product_master(prod_id),
pro_old_price decimal(8,2) Not Null,
pro_new_price decimal(8,2) not null,
pro_price_change_date date not null);
commit;
--------------------------------------------------------------------------------
create table customer_master_history(
cust_id varchar2(6)not null,
cust_name varchar2(25)not null,
cust_old_add varchar2(60)not null,
cust_new_add varchar2(60)not null,
cust_phone_no number(10)not null,
add_change_date date not null,
FOREIGN KEY (cust_id) REFERENCES customer_master(cust_id));
--------------------------------------------------------------------------------
----------------INDEX CREATION -------------------------------------------------
create index sales_ord_cust_id_idx on sales_order(cust_id);
create index pro_cat_id_idx on product_master(pro_cat_id);
create index pro_seller_id_idx on product_master(seller_id);
create index sales_ord_seller_id_idx on sales_order(seller_id);

create index sales_ord_prod_id_idx on sales_order_details(prod_id);
create index sales_ord_dt_order_id_idx on sales_order_details(order_id);
create unique index py_info_cust_id_idx on payment_info(cust_id);
create unique index py_info_ord_id_idx on payment_info(order_id);
create unique index prod_hist_pro_id_idx on product_history(prod_id); 
Create unique index cm_history_cust_idx On customer_master_history(cust_id);

-------------------------------------------------------------------------------
-- QUERY DRIVEN INDEX
create unique index sm_email_add_idx
on salesman_master(seller_email_add);

create index prod_mst_pro_name_idx
on product_master(pro_name);

create index sales_ord_order_status
on sales_order(order_status); 
--------------------------------------------------------------------------------
-----------------INSERTION STARTS -------------------------------------
-- customer_master
insert into customer_master(cust_id,cust_name,cust_add,cust_phone_no,
cust_email_add)
values
('c001','Mark Twin','1 park Street Boston MA 02115',9876543211,
'mt@gmail.com');

insert into customer_master(cust_id,cust_name,cust_add,cust_phone_no,
cust_email_add)
values
('c002','Toni Trate','2 Boylston street Boston MA 02235',8765432112,
'tt@gmail.com');

insert into customer_master(cust_id,cust_name,cust_add,cust_phone_no,
cust_email_add)
values
('c003','James Band','3 Tremont Street Boston MA 02109',7654321899,
'jb@gmail.com');

insert into customer_master(cust_id,cust_name,cust_add,cust_phone_no,
cust_email_add)
values
('c004','Mice Pinsky','4 vermont street Boston MA 02346',8976543211,
'mp@gmail.com');

insert into customer_master(cust_id,cust_name,cust_add,cust_phone_no,
cust_email_add)
values
('c005','Lucy Finch','12 mile street Boston MA 02467',7654321899,
'lf@gmail.com');

--select * from customer_master;
--------------------------------------------------------------------------------
insert into salesman_master
(seller_id,seller_name,seller_add,seller_phone_no,seller_email_add)
values
('s001','Leo Tolstoy','4 farmington hill MA 02106',5432167891,'lt@gmail.com');

insert into salesman_master
(seller_id,seller_name,seller_add,seller_phone_no,seller_email_add)
values
('s002','Steve Smith','5 Babcok street Boston MA 02109',2342156789,'ss@gmail.com');

insert into salesman_master
(seller_id,seller_name,seller_add,seller_phone_no,seller_email_add)
values
('s003','Alex Carey','6 Qunicy Ave Boston MA 02245',3214567899,
'ac@gmail.com');

insert into salesman_master
(seller_id,seller_name,seller_add,seller_phone_no,seller_email_add)
values
('s004','Ricky Pointing','7 brain tree Boston MA 02307',9876543212,
'rp@gmail.com'); 

insert into salesman_master
(seller_id,seller_name,seller_add,seller_phone_no,seller_email_add)
values
('s005','David Warner','8 arlington Boston MA 02125',6789543211,
'dw@gmail.com'); 

--select * from salesman_master;
--------------------------------------------------------------------------------
insert into category_master (pro_cat_id,pro_cat_type)
values
('pc01','Man');

insert into category_master (pro_cat_id,pro_cat_type)
values
('pc02','Women');

insert into category_master (pro_cat_id,pro_cat_type)
values
('pc03','Youth');

insert into category_master (pro_cat_id,pro_cat_type)
values
('pc04','Infant');

-- select * from category_master;
--------------------------------------------------------------------------------
insert into product_master (prod_id,pro_name,color,pro_size,qty_on_hand,price,
seller_id,pro_cat_id)
values
('p001','Jeans','Red','XL',3,35.25,'s001','pc01');

insert into product_master (prod_id,pro_name,color,pro_size,qty_on_hand,price,
seller_id,pro_cat_id)
values
('p002','Skirt','Green','M',5,50.35,'s002','pc02');

insert into product_master (prod_id,pro_name,color,pro_size,qty_on_hand,price,
seller_id,pro_cat_id)
values
('p003','Tank Top','Pink','S',6,25.75,'s003','pc03');

insert into product_master (prod_id,pro_name,color,pro_size,qty_on_hand,price,
seller_id,pro_cat_id)
values
('p004','Tank Top','Black','M',4,30.55,'s003','pc03');

insert into product_master (prod_id,pro_name,color,pro_size,qty_on_hand,price,
seller_id,pro_cat_id)
values
('p005','Baby Body suit','Purple','S',2,10.25,'s004','pc04');

insert into product_master (prod_id,pro_name,color,pro_size,qty_on_hand,price,
seller_id,pro_cat_id)
values
('p006','T-shirt','Blue','xs',4,20.35,'s002','pc01');

insert into product_master (prod_id,pro_name,color,pro_size,qty_on_hand,price,
seller_id,pro_cat_id)
values
('p007','capri','Yellow','M',2,7.55,'s004','pc02');  

--select * from product_master;
--------------------------------------------------------------------------------
insert into sales_order(order_id,order_date,order_status,cust_id,seller_id)
values
('o001',cast('jan-01-2018' as date),'in process','c001','s001');

insert into sales_order(order_id,order_date,order_status,cust_id,seller_id)
values
('o002',cast('May-05-2018' as date),'cancelled','c002','s002');

insert into sales_order(order_id,order_date,order_status,cust_id,seller_id)
values
('o003',cast('June-20-2018' as date),'completed','c003','s003');

insert into sales_order(order_id,order_date,order_status,cust_id,seller_id)
values
('o004',cast('Sep-02-2019' as date),'delayed','c001','s003'); 

insert into sales_order(order_id,order_date,order_status,cust_id,seller_id)
values
('o005',cast('oct-15-2019' as date),'completed','c004','s004'); 

insert into sales_order(order_id,order_date,order_status,cust_id,seller_id)
values
('o006',cast('FEB-03-2019' as date),'in process','c002','s002'); 

insert into sales_order(order_id,order_date,order_status,cust_id,seller_id)
values
('o007',cast('MAY-04-2019' as date),'Shipping','c005','s004'); 

insert into sales_order(order_id,order_date,order_status,cust_id,seller_id)
values
('o008',cast('AUG-08-2021' as date),'delivered','c001','s003');

--select * from sales_order;
--------------------------------------------------------------------------------
insert into sales_order_details (prod_id,order_id,qty_ordered,pro_rate)
values
('p001','o001',1,35.25);

insert into sales_order_details (prod_id,order_id,qty_ordered,pro_rate)
values
('p002','o002',2,50.35);

insert into sales_order_details (prod_id,order_id,qty_ordered,pro_rate)
values
('p003','o003',3,25.75);

insert into sales_order_details (prod_id,order_id,qty_ordered,pro_rate)
values
('p004','o004',2,30.55);

insert into sales_order_details (prod_id,order_id,qty_ordered,pro_rate)
values
('p005','o005',1,10.25);

insert into sales_order_details (prod_id,order_id,qty_ordered,pro_rate)
values
('p006','o006',2,20.35);

insert into sales_order_details (prod_id,order_id,qty_ordered,pro_rate)
values
('p007','o007',1,7.55); 

insert into sales_order_details (prod_id,order_id,qty_ordered,pro_rate)
values
('p004','o008',2,30.55);

-- select * from sales_order_details;
--------------------------------------------------------------------------------
-- PAYMENT_INFO
insert into payment_info(payment_id,payment_type,payment_date,cust_id,order_id)
values
('py01','credit card',cast('jan-01-2018' as date),'c001','o001');

insert into payment_info(payment_id,payment_type,payment_date,cust_id,order_id)
values
('py02','debit card',cast('May-05-2018' as date),'c002','o002');

insert into payment_info(payment_id,payment_type,payment_date,cust_id,order_id)
values
('py03','master card',cast('jun-20-2018' as date),'c003','o003');

insert into payment_info(payment_id,payment_type,payment_date,cust_id,order_id)
values
('py04','credit card',cast('sep-02-2019' as date),'c001','o004');

insert into payment_info(payment_id,payment_type,payment_date,cust_id,order_id)
values
('py05','debit card',cast('oct-15-2019' as date),'c004','o005');

insert into payment_info(payment_id,payment_type,payment_date,cust_id,order_id)
values
('py06','credit card',cast('feb-03-2019' as date),'c002','o006');

insert into payment_info(payment_id,payment_type,payment_date,cust_id,order_id)
values
('py07','credit card',cast('May-04-2019' as date),'c005','o007'); 

--select * from payment_info; 
-------------------------------------------------------------------------------
--*************************insertion over--------------------------------------

--- IMPLEMENTATION OF THE QUERIES STARTS ------------------------------------------
--Query1 

-- If customer wants to see filtered product on the basis of product name size.
select PROD_ID,color,to_char(price,'$999.99') as price,seller_id
from product_master
where
pro_name='Tank Top' and pro_size = 'M' and QTY_ON_HAND >0; 
--------------------------------------------------------------------------------------------
Query 2)
--Find the sum total of all the billed orders for the month of the January 2018
select sales_order.order_id,to_char(sum(qty_ordered*pro_rate),'$999.99')as total_price
from sales_order,sales_order_details
where sales_order_details.order_id = sales_order.order_id
and order_date between ('jan-01-2018') and ('dec-31-2018')
group by sales_order.order_id;

--------------------------------------------------------------------------------
---Query 3)
--Retrieve the order number, customer name and their order date.
--The customer name should be sorted in asc order.
select order_id,cust_name,to_char(order_date,'Mon-DD-YYYY')as order_date
from sales_order,customer_master
where customer_master.cust_id = sales_order.cust_id
order by cust_name;
-------------------------------------------------------------------------------------------------------------
--Query 4
--to find product allocation based on category,total number of the qty order for 
--respected product which is grater than 1 and catgory type should be in asc order.
select p.prod_id,p.pro_name,c.pro_cat_type,sum(s.qty_ordered)as total_qty
from product_master p
join category_master c
on p.pro_cat_id = c.pro_cat_id
right join sales_order_details s
on s.prod_id = p.prod_id
group by p.prod_id,p.pro_name,c.pro_cat_type,s.qty_ordered
having s.qty_ordered >1
order by c.pro_cat_type;
-----------------------------------------------------------------------------------------------------------------------
--Query 5)
--Find out if the product Skirt has been ordered by any customer and print the customer id and customer name 
select cust_id,cust_name
from customer_master
where cust_id in 
(select cust_id from sales_order
where order_id in 
(select order_id from sales_order_details
where prod_id in
(select prod_id from product_master
where pro_name ='Skirt')));
---------------------------------------------------------------------------------------------------------------
--Query6)
--Find product and their quantities for the order placed by 
--customer id c001 and c003.Display product name in asc order.
select sales_order_details.prod_id,pro_name,cust_name,
sum(qty_ordered)as total 
from sales_order_details,sales_order,product_master,customer_master
where sales_order.order_id = sales_order_details.order_id
    and sales_order_details.prod_id = product_master.prod_id
    and sales_order.cust_id = customer_master.cust_id
group by sales_order.cust_id,sales_order_details.prod_id,pro_name,
customer_master.cust_name
having 
sales_order.cust_id = 'c001' or sales_order.cust_id = 'c003'
order by pro_name;
-------------------------------------------------------------------------------------------------------------------
--Query7)
--Function which returns total number of the products sells by respected seller.
set serveroutput on;
create or replace function tot_num_prod(
    seller_id_arg in varchar2)
    return number
    is
    tot_num number(2):=0;
    begin
    select count(*) into tot_num
    from product_master
    where seller_id=seller_id_arg;
    return tot_num;
    end;
    /
    -- execute function
    declare
    cnt number(2);
    begin
    cnt:=tot_num_prod('s002');
    dbms_output.put_line('Total products is : '|| cnt);
    end; 
    /
-------------------------------------------------------------------------------------------------------------------------
-- query8) Customer are eligible when put the order above $35.
set serveroutput on;
create or replace procedure chk_free_shipping_order(
       order_id_arg varchar2)
is
price_arg decimal(8,2);
Begin
    select(qty_ordered*pro_rate) into price_arg
        from sales_order_details
        where order_id = order_id_arg;      
    if price_arg > 35 then
        dbms_output.put_line('The total cost of the order is ' || price_arg
        ||'$');
        dbms_output.put_line('Congratulation! You are eligible for free shipping.');
    else
        dbms_output.put_line('The total cost of the order is ' || price_arg
        ||'$');
        dbms_output.put_line('You are not eligible for free shipping.');
    end if;
end; 
/
-- Exe procedure
begin
chk_free_shipping_order('o003');
end;
/
------------------------------------------------------------------------------------------
--Query9) 
--Procedure which returns the total quantity of product with the given ID
Set serveroutput on;
create or replace procedure prod_details(
    prod_id_arg in varchar2)
    is
    qty_on_hand_arg number(8);
    begin
        select QTY_ON_HAND into qty_on_hand_arg
        from product_master
        where prod_id=prod_id_arg;       
    exception
        when no_data_found then
             dbms_output.put_line('Sorry no such product exist !!');             
    end;
    /

---when data doesn't exist
    begin
    prod_details('p0001');
    end;
/
---when data exist
    begin
    prod_details('p001');
    end;
   /
   select * from product_master where prod_id = 'p001'; 
 
--------------------------------------------------------------------------------------------------------
--Query10) 
--Once the customers place the order and for some reason they want
--to cancel the order they can't cancel it once order status is shipping.
create or replace procedure chk_cancel_order(
    order_id_arg varchar2)    
is
    ord_status_arg varchar(15);
begin
    select order_status into ord_status_arg
        from sales_order 
        where order_id = order_id_arg;    
    if ord_status_arg ='Shipping' then
        dbms_output.put_line('Sorry ! User can not cancel the order.');
   else
        dbms_output.put_line(' Yes..If user want to cancel the order before shipping stage
        they can do it.');
    end if;
end; 
/ 
begin
chk_cancel_order('o004');
end;
/ 
--------------------------------------------------------------------------------------------------------------------
-- Query11) 
set serveroutput on;
CREATE OR REPLACE TRIGGER Change_Order_Status 
AFTER INSERT ON payment_info FOR EACH ROW
Declare 
BEGIN
    Update sales_order 
        Set order_status = 'completed' 
        where order_id = :New.order_id;
        dbms_output.put_line(:New.order_id);
END;
 /
insert into payment_info (payment_id,payment_type,payment_date,cust_id,order_id)
values
('py08','cash',cast('Aug-08-2021' as date),'c001','o008');
---------------------------------------------------------------------------------------------------------------------------
-- Query12)
--Price_change_history trigger.
CREATE OR REPLACE TRIGGER price_chng_trigg
BEFORE UPDATE OF price ON product_master
FOR EACH ROW
BEGIN
INSERT INTO product_history(price_chng_id,
pro_old_price, pro_new_price, prod_id, pro_price_change_date)
VALUES(NVL((SELECT MAX(price_chng_id)+1
FROM product_history), 1),
:OLD.price,
:NEW.price,
:New.prod_id,
trunc(sysdate));
end;
/
update product_master
set price = 20.25
where prod_id = 'p003';

--select * from product_master;
-----------------------------------------------------------------------------------------------------------------------------
-- Query13) Customer's address change
CREATE OR REPLACE TRIGGER cm_add_hist_trig
BEFORE UPDATE ON customer_master
FOR EACH ROW
BEGIN
    IF :OLD.cust_add <> :NEW.cust_add THEN
        INSERT INTO customer_master_history(cust_id,cust_name,
        cust_old_add,cust_new_add,cust_phone_no,add_change_date)
        VALUES(:NEW.cust_id,:New.cust_name,:OLD.cust_add,
        :NEW.cust_add,:new.cust_phone_no,
        TRUNC(sysdate));
    END IF;
END;
/
Update customer_master
Set cust_add = '5 waymouth Boston MA 02188'
Where cust_id = 'c005';
/

---------------------------END OF SCRIPT-----------------------------------------------------------------------------




