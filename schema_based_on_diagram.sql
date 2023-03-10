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

CREATE TABLE IF NOT EXISTS invoice_items
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    unit_price decimal not null,
    quantity integer not null,
    total_price decimal not null,
    invoice_id integer not null,
    treatment_id integer not null,
    CONSTRAINT invoice_items_pkey PRIMARY KEY (id),
    CONSTRAINT invoices_fkey FOREIGN KEY (invoice_id) REFERENCES invoices (id)
);


CREATE TABLE IF NOT EXISTS treatments
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    type varchar (30) not null,
    name varchar (50) not null,
    CONSTRAINT treatment_pkey PRIMARY KEY (id)
);

ALTER TABLE invoice_items ADD CONSTRAINT treatments_fkey FOREIGN KEY (treatment_id) REFERENCES treatments (id);

CREATE TABLE IF NOT EXISTS medicalHist_treatments (
    treatment_id integer not null,
    medical_historeis_id integer not null,
    CONSTRAINT medicalHist_treatments_compkey PRIMARY KEY (treatment_id,medical_historeis_id),
    CONSTRAINT medical_history_fkey FOREIGN KEY (medical_historeis_id) REFERENCES medical_histories (id),
    CONSTRAINT treatments_fkey FOREIGN KEY (treatment_id) REFERENCES treatments (id)
);

    CREATE INDEX patient_id_indx ON medical_histories(patient_id);
    CREATE INDEX medical_history__id_indx ON invoices(medical_history__id);
    CREATE INDEX invoice_id_indx ON invoice_items(invoice_id);
    CREATE INDEX treatment_id_indx ON invoice_items(treatment_id);
    CREATE INDEX medical_historeis_id_indx ON medicalHist_treatments(medical_historeis_id);
    CREATE INDEX medhist_treatment_id_indx ON medicalHist_treatments(treatment_id);