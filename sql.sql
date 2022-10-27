

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
	bank_id serial REFERENCES bank(id) ON DELETE CASCADE ON UPDATE CASCADE
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
	card_id serial REFERENCES card(id) ON DELETE CASCADE ON UPDATE CASCADE,
    branch_id serial REFERENCES branch_office(id) ON DELETE RESTRICT ON UPDATE CASCADE
	
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

INSERT INTO card (first_name,last_name,currency,card_numb,period_of_validity,created_at,balance,bank_id) 
VALUES('Ilya','Kuzmenkow','USD','1234 5678 9012 3456','10/1/2022','10/1/2021',9999,'1');
INSERT INTO card (first_name,last_name,currency,card_numb,period_of_validity,created_at,balance,bank_id) 
VALUES('Anton','Antonov','USD','2222 2222 2222 2222','9/1/2023','9/1/2022',9999,'2');
INSERT INTO card (first_name,last_name,currency,card_numb,period_of_validity,created_at,balance,bank_id) 
VALUES('Pavel','Cheburnet','USD','3333 3333 3333 3333','10/12/2023','10/12/2022',9999,'3');
INSERT INTO card (first_name,last_name,currency,card_numb,period_of_validity,created_at,balance,bank_id) 
VALUES('Maksim','Markelov','USD','4444 4444 4444 4444','6/4/2023','6/4/2022',9999,'4');
INSERT INTO card (first_name,last_name,currency,card_numb,period_of_validity,created_at,balance,bank_id) 
VALUES('Natalia','Vasilkova','USD','5555 5555 5555 5555','5/11/2024','5/11/2024',9999,'5');

-- DELETE FROM card 
-- SELECT * FROM bank
-- SELECT * FROM card

-- SELECT * FROM branch_office
-- DELETE FROM branch_office
INSERT INTO branch_office (name,fax_no,location_id) VALUES('Mihalovo','+844544',1);
INSERT INTO branch_office (name,fax_no,location_id) VALUES('Syvorova','+844142',2);
INSERT INTO branch_office (name,fax_no,location_id) VALUES('Lygovaya','+844343',3);
INSERT INTO branch_office (name,fax_no,location_id) VALUES('Malaya','+844414',4);
INSERT INTO branch_office (name,fax_no,location_id) VALUES('Staroselskaya','+847444',5);

INSERT INTO bank_member (first_name,last_name,balance,gender,age,status_id,card_id,branch_id) VALUES('Ilya','Kuzmenkow',100000,'men',21,1,1,1);
INSERT INTO bank_member (first_name,last_name,balance,gender,age,status_id,card_id,branch_id) VALUES('Anton','Antonov',200000,'men',20,2,2,2);
INSERT INTO bank_member (first_name,last_name,balance,gender,age,status_id,card_id,branch_id) VALUES('Pavel','Cheburnet',300000,'men',18,3,3,3);
INSERT INTO bank_member (first_name,last_name,balance,gender,age,status_id,card_id,branch_id) VALUES('Maksim','Markelov',400000,'men',15,4,4,4);
INSERT INTO bank_member (first_name,last_name,balance,gender,age,status_id,card_id,branch_id) VALUES('Natalia','Vasilkova',500000,'woman',30,5,5,5);



