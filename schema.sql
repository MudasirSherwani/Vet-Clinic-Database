/* Database schema to keep the structure of entire database. */

-- Project#: 1 Vet clinic database: create animals table
CREATE TABLE animals
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name character varying(50) NOT NULL,
    date_of_birth date NOT NULL,
    escape_attempts integer,
    neutered boolean,
    weight_kg numeric NOT NULL,
    CONSTRAINT animals_pkey PRIMARY KEY (id)
)

-- Project#: 2 Vet clinic database: query and update animals table
ALTER TABLE animals ADD species varchar(30) NULL;

-- Project#: 3 Vet clinic database: query multiple tables

CREATE TABLE owners 
(
   id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    full_name character varying(50) NOT NULL,
    age integer not null,
    CONSTRAINT owners_prkey PRIMARY KEY(id)
)

CREATE TABLE species 
(
   id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name character varying(30) NOT NULL,
    CONSTRAINT species_prkey PRIMARY KEY(id)
)

ALTER table animals
drop column species

alter table animals
add column species_id integer,
add FOREIGN KEY (species_id) REFERENCES species(id);

alter table animals
add column owner_id integer,
add FOREIGN KEY (owner_id) REFERENCES owners(id);