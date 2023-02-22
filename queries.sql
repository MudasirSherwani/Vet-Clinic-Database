/*Queries that provide answers to the questions from all projects.*/

-- Project#: 1 Vet clinic database: create animals table
select * from animals where name like'%mon';
select * from animals where EXTRACT(YEAR FROM date_of_birth) between 2016 and 2019;
select name from animals where neutered = true and escape_attempts < 3;
select date_of_birth from animals where name in ('Agumon', 'Pikachu');
select name, escape_attempts from animals where weight_kg > 10.5;
select * from animals where neutered =true;
select * from animals where name<>'Gabumon';
select * from animals where  weight_kg between 10.4 and 17.3;

-- Project#: 2 Vet clinic database: query and update animals table
BEGIN;
UPDATE animals SET species = 'unspecifie';
ROLLBACK;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT svpDelete;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT svpDelete;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) AS Total_Animals FROM animals;
SELECT COUNT(*) AS Never_Escap_Animals FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) AS Avg_weight_kg FROM animals;
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;
SELECT MAX(weight_kg) AS maximum_wgt, MIN(weight_kg)AS minimum_wgt FROM animals;
SELECT AVG(escape_attempts) AS Avg_Escaped FROM animals 
WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 1990 AND 2000;

-- Project#: 3 Vet clinic database: query multiple tables

SELECT an.name FROM animals an inner join owners ow on ow.id=an.owner_id 
where ow.full_name='Melody Pond';

SELECT an.name FROM animals an INNER JOIN species sp ON an.species_id = sp.id 
WHERE sp.name='Pokemon';

SELECT ow.full_name, an.name FROM owners ow LEFT JOIN animals an 
ON ow.id = an.owner_id;

SELECT COUNT(*) as No_Of_Animals, sp.name FROM animals an JOIN species sp
ON an.species_id = sp.id GROUP BY sp.name;

SELECT an.name as Animal_Name, sp.name as Species_Type, ow.full_name as Owener_Name 
FROM animals an inner join owners ow 
on an.owner_id = ow.id inner join species sp
on an.species_id = sp.id 
where ow.full_name = 'Jennifer Orwell' and sp.name = 'Digimon';

SELECT ow.full_name, an.name, an.escape_attempts FROM animals an INNER JOIN owners ow
on an.owner_id = ow.id
where ow.full_name = 'Dean Winchester' and an.escape_attempts = 0;

SELECT ow.full_name, COUNT(*) FROM animals an 	INNER JOIN owners ow 
ON an.owner_id = ow.id GROUP BY ow.full_name ORDER BY COUNT(*) desc
FETCH FIRST 1 ROWS ONLY;