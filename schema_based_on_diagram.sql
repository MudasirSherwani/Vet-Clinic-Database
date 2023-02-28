 CREATE TABLE IF NOT EXISTS patients 
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name varchar(50) NOT NULL,
    date_of_birth date NOT NULL,
    CONSTRAINT patient_pkey PRIMARY KEY (id)
);