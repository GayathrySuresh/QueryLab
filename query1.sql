-- Create tables 'people' and 'rekations'

CREATE TABLE people
(id int primary key not null,
name varchar(20),
gender char(2));

CREATE TABLE relations
(
c_id int,
p_id int,
FOREIGN KEY (c_id) REFERENCES people(id),
foreign key (p_id) references people(id)
);

-- Insert values

INSERT into people (id, name, gender) VALUES
(107,'Days','F'),
(145,'Hawbaker','M'),
(155,'Hansel','F'),
(202,'Blackston','M'),
(227,'Criss','F'),
(278,'Keffer','M'),
(305,'Canty','M'),
(329,'Mozingo','M'),
(425,'Nolf','M'),
(534,'Waugh','M'),
(586,'Tong','M'),
(618,'Dimartino','M'),
(747,'Beane','M'),
(878,'Chatmon','F'),
(904,'Hansard','F');

INSERT into relations(c_id, p_id) VALUES

(145, 202),
(145, 107),
(278,305),
(278,155),
(329, 425),
(329,227),
(534,586),
(534,878),
(618,747),
(618,904);

--Query :

WITH id_tbl as(
SELECT  DISTINCT r1.c_id,  r1.p_id as f_id,   r2.p_id as m_id
FROM relations r1
JOIN relations r2
ON r1.c_id = r2.c_id
WHERE r1.p_id <> r2.p_id),

Names_tbl as(
SELECT p1.id as id, p1.name as child, p2.id as id2, p2.name as father, p3.id as id3, p3.name as mother
FROM people p1, people p2, people p3
WHERE p1.id IN (SELECT c_id FROM relations)
AND p2.gender = 'M' 
AND p3.gender = 'F')

SELECT n.child, n.father, n.mother
FROM id_tbl r
JOIN Names_tbl n
ON r.c_id = n.id
WHERE f_id = id2 AND m_id = id3
ORDER BY child



