 CREATE TABLE IF NOT EXISTS patients 
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name varchar(50) NOT NULL,
    date_of_birth date NOT NULL,
    CONSTRAINT patient_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS medical_histories 
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    admitted_at timestamp not null,
    patient_id integer not null,
    status varchar (30) null,
    CONSTRAINT medical_histories_pkey PRIMARY KEY (id),
    CONSTRAINT patient_medical_hist_fkey FOREIGN KEY (patient_id) REFERENCES patients (id)
);

 CREATE TABLE IF NOT EXISTS invoices 
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    total_amount decimal not null,
    generated_at timestamp not null,
    payed_at timestamp not null,
    medical_history__id integer not null,
    CONSTRAINT invoice_pkey PRIMARY KEY (id),
    CONSTRAINT medical_hist_fkey FOREIGN KEY (medical_history__id) REFERENCES medical_histories (id)
);
