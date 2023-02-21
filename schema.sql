/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
id INT PRIMARY KEY NOT NULL,
name VARCHAR(50) NOT NULL,
date_of_birth DATE NOT NULL,
escape_attempts INT NULL,
neutered BOOLEAN NULL,
weight_kg DECIMAL NOT NULL
)
