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
