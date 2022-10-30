

DROP TABLE current_location CASCADE
DROP TABLE bank CASCADE
DROP TABLE card CASCADE
DROP TABLE status CASCADE
DROP TABLE bank_member CASCADE
DROP TABLE branch_office CASCADE

CREATE TABLE current_location 
(
    PRIMARY KEY (id),
    id serial,
    city varchar(255) NOT NULL,
    street varchar(100) NOT NULL,
    house varchar(100),
    post_code varchar(6) 
);
CREATE TABLE bank 
(
    PRIMARY KEY (id),
    id serial,
    bank_name varchar(255) NOT NULL,
    fax_no varchar(100) NOT NULL,
	location_id serial REFERENCES current_location(id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE status
(
    PRIMARY KEY (id),
    id serial,
    name varchar(255) NOT NULL,
    index float NOT NULL
);
CREATE TABLE branch_office
(
    PRIMARY KEY (id),
    id serial,
    name varchar(255) NOT NULL,
    fax_no varchar(100) NOT NULL,
	location_id serial REFERENCES current_location(id) ON DELETE CASCADE ON UPDATE CASCADE
	--bank_id integer
	
	
);
CREATE TABLE bank_member
(
    PRIMARY KEY (id),
    id serial,
    first_name varchar(255) NOT NULL,
    last_name varchar(100) NOT NULL,
    balance float,
    gender varchar(100),
    age varchar(100),
	status_id serial REFERENCES status(id) ON DELETE CASCADE ON UPDATE CASCADE,
    branch_id serial REFERENCES branch_office(id) ON DELETE RESTRICT ON UPDATE CASCADE
	
);

CREATE TABLE card 
(
    PRIMARY KEY (id),
    id serial,
    first_name varchar(255) NOT NULL,
    last_name varchar(100) NOT NULL,
    currency varchar(100),
    card_numb varchar(100),
    period_of_validity date, 
    created_at timestamptz,
    balance float,
	bank_id serial REFERENCES bank(id) ON DELETE CASCADE ON UPDATE CASCADE,
	member_id serial REFERENCES bank_member(id) ON DELETE CASCADE ON UPDATE CASCADE
	
);


--ALTER TABLE branch_office ADD CONSTRAINT fk_bank_member_id FOREIGN KEY(bank_id) REFERENCES bank_member(id) ON DELETE RESTRICT ON UPDATE CASCADE;

INSERT INTO status (name,index) VALUES('orphan',0.9);
INSERT INTO status (name,index) VALUES('retire',1);
INSERT INTO status (name,index) VALUES('unempliyed',1);
INSERT INTO status (name,index) VALUES('under-age',0.9);
INSERT INTO status (name,index) VALUES('disabled',0.9);

INSERT INTO current_location (city,street,house,post_code) VALUES('Minsk','Mihalovo','31','220019');
INSERT INTO current_location (city,street,house,post_code) VALUES('Gorky','Syvorova','6','213410');
INSERT INTO current_location (city,street,house,post_code) VALUES('Gomel','Lygovaya','1','247040');
INSERT INTO current_location (city,street,house,post_code) VALUES('Brest','Malaya','33','225027');
INSERT INTO current_location (city,street,house,post_code) VALUES('Mogilev','Staroselskaya','10','213116');

INSERT INTO bank (bank_name,fax_no,location_id) VALUES('Belarus','+843847','1');
INSERT INTO bank (bank_name,fax_no,location_id) VALUES('Belinvest','+848899','2');
INSERT INTO bank (bank_name,fax_no,location_id) VALUES('BonnieClide','+849211','3');
INSERT INTO bank (bank_name,fax_no,location_id) VALUES('Polska','+843841','4');
INSERT INTO bank (bank_name,fax_no,location_id) VALUES('RogatiyCredit','+843822','5');

INSERT INTO branch_office (name,fax_no,location_id) VALUES('Mihalovo','+844544',1);
INSERT INTO branch_office (name,fax_no,location_id) VALUES('Syvorova','+844142',2);
INSERT INTO branch_office (name,fax_no,location_id) VALUES('Lygovaya','+844343',3);
INSERT INTO branch_office (name,fax_no,location_id) VALUES('Malaya','+844414',4);
INSERT INTO branch_office (name,fax_no,location_id) VALUES('Staroselskaya','+847444',5);

INSERT INTO bank_member (first_name,last_name,balance,gender,age,status_id,branch_id) VALUES('Ilya','Kuzmenkow',100000,'men',21,1,1);
INSERT INTO bank_member (first_name,last_name,balance,gender,age,status_id,branch_id) VALUES('Anton','Antonov',200000,'men',20,2,2);
INSERT INTO bank_member (first_name,last_name,balance,gender,age,status_id,branch_id) VALUES('Pavel','Cheburnet',300000,'men',18,3,3);
INSERT INTO bank_member (first_name,last_name,balance,gender,age,status_id,branch_id) VALUES('Maksim','Markelov',400000,'men',15,4,4);
INSERT INTO bank_member (first_name,last_name,balance,gender,age,status_id,branch_id) VALUES('Natalia','Vasilkova',500000,'woman',30,5,5);
INSERT INTO bank_member (first_name,last_name,balance,gender,age,status_id,branch_id) VALUES('Antonio','Belychi',100330,'men',30,1,1);

INSERT INTO card (first_name,last_name,currency,card_numb,period_of_validity,created_at,balance,bank_id,member_id) 
VALUES('Ilya','Kuzmenkow','USD','1234 5678 9012 3456','10/1/2022','10/1/2021',9999,'1',1);
INSERT INTO card (first_name,last_name,currency,card_numb,period_of_validity,created_at,balance,bank_id,member_id) 
VALUES('Ilya','Kuzmenkow','USD','1234 5678 9012 7777','10/1/2022','10/1/2021',90001,'1',1);
INSERT INTO card (first_name,last_name,currency,card_numb,period_of_validity,created_at,balance,bank_id,member_id) 
VALUES('Anton','Antonov','USD','2222 2222 2222 2222','9/1/2023','9/1/2022',9999,'2',2);
INSERT INTO card (first_name,last_name,currency,card_numb,period_of_validity,created_at,balance,bank_id,member_id) 
VALUES('Pavel','Cheburnet','USD','3333 3333 3333 3333','10/12/2023','10/12/2022',9999,'3',3);
INSERT INTO card (first_name,last_name,currency,card_numb,period_of_validity,created_at,balance,bank_id,member_id) 
VALUES('Maksim','Markelov','USD','4444 4444 4444 4444','6/4/2023','6/4/2022',9999,'4',4);
INSERT INTO card (first_name,last_name,currency,card_numb,period_of_validity,created_at,balance,bank_id,member_id) 
VALUES('Natalia','Vasilkova','USD','5555 5555 5555 5555','5/11/2024','5/11/2024',9999,'5',5);
INSERT INTO card (first_name,last_name,currency,card_numb,period_of_validity,created_at,balance,bank_id,member_id)
VALUES('Natalia','Vasilkova','USD','6666 6666 6666 6666','6/11/2024','6/11/2024',9999999,'5',5);

-- DELETE FROM card 
-- SELECT * FROM bank
-- SELECT * FROM card

-- SELECT * FROM branch_office
-- DELETE FROM branch_office



-- DELETE FROM bank_member
--1
-- Покажи мне список банков у которых есть филиалы в городе X (выбери один из городов)
SELECT b.bank_name FROM bank b 
JOIN current_location c ON b.location_id=c.id
WHERE c.city='Minsk'
---
--2
-- Получить список карточек с указанием имени владельца, баланса и hназвания банка
SELECT c.first_name, c.balance, b.bank_name FROM card c
JOIN bank b ON c.bank_id=b.id
---
--3
-- Показать список банковских аккаунтов у которых баланс не совпадает с суммой баланса по карточкам. В отдельной колонке вывести разницу
SELECT SUM(c.balance),c.first_name, m.balance, m.first_name,ABS(SUM(c.balance) - m.balance) AS difference  FROM  card c
JOIN bank_member m ON c.member_id=m.id
GROUP BY c.first_name, m.balance, m.first_name
HAVING SUM(c.balance)<>m.balance
---

--4
-- Вывести кол-во банковских карточек для каждого соц статуса (2 реализации, GROUP BY и подзапросом)
SELECT COUNT(*), s.name FROM card c
JOIN bank_member m ON c.member_id=m.id
JOIN status s ON m.status_id=s.id
GROUP BY s.id
--подзапросом
SELECT COUNT(*),c.first_name, s.name FROM card c
JOIN bank_member m ON c.member_id=m.id
JOIN status s ON m.status_id=s.id
GROUP BY c.first_name,c.member_id,s.name
HAVING c.member_id IN(SELECT m.id FROM bank_member m WHERE m.status_id  IN (SELECT s.id FROM status s))
---

--5
-- Написать stored procedure которая будет добавлять по 10$ на каждый банковский аккаунт для определенного соц статуса 
--(У каждого клиента бывают разные соц. статусы. Например, пенсионер, инвалид и прочее). 
--Входной параметр процедуры - Id социального статуса. 
--Обработать исключительные ситуации 
--(например, был введен неверные номер соц. статуса. Либо когда у этого статуса нет привязанных аккаунтов).
---
SELECT * FROM bank_member m
-- DROP PROCEDURE add10usd
---
CREATE OR REPLACE PROCEDURE add10usd(a text)
LANGUAGE plpgsql
AS $$
declare
	count_of_status INTEGER;
BEGIN 
SELECT COUNT(*)  INTO count_of_status FROM status WHERE status.name = a;
IF count_of_status IS NULL THEN RAISE  NOTICE 'Status not found';
ELSE
UPDATE bank_member  
SET balance=balance+10
WHERE status_id IN (SELECT status.id FROM status WHERE status.name = a );
END IF;
RETURN;
END; $$

CALL add10usd('disabled1');
---
SELECT * FROM bank_member m
---

-- CREATE PROCEDURE add10usd("{a}" varchar(30))
-- LANGUAGE SQL
-- AS $$
-- UPDATE bank_member  
-- SET balance=balance+10
-- WHERE status_id IN (SELECT s.id FROM status s WHERE s.name ="{a}"  )
-- $$;
-- UPDATE bank_member  
-- SET balance=balance+10
-- WHERE status_id IN (SELECT s.id FROM status s WHERE s.name =  )
---

--6
-- Получить список доступных средств для каждого клиента. 
-- То есть если у клиента на банковском аккаунте 60 рублей, и у него 2 карточки по 15 рублей на каждой, 
-- то у него доступно 30 рублей для перевода на любую из карт
--helpfull function
CREATE OR REPLACE FUNCTION AvailableMoney () 
RETURNS TABLE (last_name varchar(255), money float) AS $$
BEGIN 
RETURN QUERY SELECT  m.last_name,m.balance - SUM(c.balance)  AS difference FROM  card c
JOIN bank_member m ON c.member_id=m.id
GROUP BY m.last_name,m.balance
HAVING SUM(c.balance)<>m.balance;
END;
$$ LANGUAGE plpgsql;
-- usage of this function and final query
SELECT last_name, money  FROM AvailableMoney ()
WHERE money>0 AND last_name = 'Markelov'
---

--7
-- Написать процедуру которая будет переводить определённую сумму со счёта на карту этого аккаунта.  
-- При этом будем считать что деньги на счёту все равно останутся, просто сумма средств на карте увеличится. 
-- Например, у меня есть аккаунт на котором 1000 рублей и две карты по 300 рублей на каждой. 
-- Я могу перевести 200 рублей на одну из карт, при этом баланс аккаунта останется 1000 рублей, а на картах будут суммы 300 и 500 рублей соответственно. 
-- После этого я уже не смогу перевести 400 рублей с аккаунта ни на одну из карт, так как останется всего 200 свободных рублей (1000-300-500). 
-- Переводить БЕЗОПАСНО. То есть использовать транзакцию



CREATE PROCEDURE transaction_money_transfer(l_name VARCHAR(255))
LANGUAGE plpgsql
AS $$
DECLARE 
mcount float;
BEGIN

SELECT money INTO mcount FROM AvailableMoney ()
WHERE money>0 AND last_name=l_name;

UPDATE card 
SET balance = balance + mcount
WHERE last_name = l_name;
COMMIT;
END;
$$;
--
UPDATE bank_member 
SET balance = balance + 100
WHERE last_name ='Cheburnet'; --change Cheburnet's member balance
--
SELECT last_name, money FROM AvailableMoney () -- before using procedure
WHERE money>0 

CALL transaction_money_transfer('Cheburnet');

SELECT last_name, money FROM AvailableMoney ()
WHERE money>0
---

--8
-- Написать триггер на таблицы Account/Cards чтобы нельзя была занести значения в поле баланс если это противоречит условиям 
-- (то есть нельзя изменить значение в Account на меньшее, 
-- чем сумма балансов по всем карточкам. 
-- И соответственно нельзя изменить баланс карты если в итоге сумма на картах будет больше чем баланс аккаунта)

CREATE OR REPLACE FUNCTION update_card_member_check() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$

DECLARE 
current_value FLOAT;

BEGIN 
SELECT money INTO current_value FROM AvailableMoney () WHERE money>0 AND last_name=OLD.last_name;
IF current_value > NEW.balance THEN ROLLBACK;
COMMIT;
END IF;
RETURN NEW;
END
$$;


CREATE TRIGGER balance_update
BEFORE UPDATE ON bank_member 
FOR EACH ROW 
EXECUTE FUNCTION update_card_member_check()
---
UPDATE bank_member
SET balance = 10000000
WHERE last_name = 'Antonov';

SELECT * FROM bank_member

UPDATE bank_member
SET balance = 100
WHERE last_name = 'Antonov';

SELECT * FROM bank_member


