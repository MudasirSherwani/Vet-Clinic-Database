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

-- Project#: 4 Vet clinic database: add "join table" for visits
SELECT vt.name ,an.name ,vs.date_of_visit FROM animals an 
INNER JOIN visits vs ON an.id = vs.animal_id 
INNER JOIN vets vt ON vt.id = vs.vet_id
WHERE vt.name='William Tatcher' ORDER BY  vs.date_of_visit DESC 
FETCH FIRST 1 ROWS ONLY;

SELECT vt.name,COUNT(vs.date_of_visit) AS Number_of_visits FROM visits vs
INNER JOIN vets vt ON vt.id = vs.vet_id 
WHERE vt.name='Stephanie Mendez' GROUP BY vt.name;

SELECT * FROM vets vt
LEFT JOIN specializations sp ON vt.id = sp.vet_id;

SELECT vt.name AS Vets_Name , an.name AS animal_name, vs.date_of_visit FROM animals an
INNER JOIN visits vs ON an.id = vs.animal_id 
INNER JOIN vets vt ON vt.id = vs.vet_id 
WHERE vt.name='Stephanie Mendez'  AND  vs.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

SELECT an.name AS Animal_Name, COUNT(vs.date_of_visit) AS Number_Of_Checkup FROM visits vs
INNER JOIN animals an ON an.id = vs.animal_id 
GROUP BY an.name ORDER BY COUNT(vs.date_of_visit) DESC 
FETCH FIRST 1 ROWS ONLY ;

SELECT vt.name AS Vets_Name, an.name AS Animal_Name, vs.date_of_visit FROM animals an
INNER JOIN visits vs ON an.id = vs.animal_id 
INNER JOIN vets vt ON vt.id = vs.vet_id 
WHERE vt.name='Maisy Smith' ORDER BY  vs.date_of_visit
FETCH FIRST 1 ROWS ONLY;

SELECT vt.name AS Vet_Name, vt.age, vt.date_of_graduation, vs.date_of_visit, 
an.name, an.date_of_birth, an.escape_attempts, an.neutered, an.weight_kg FROM visits vs
INNER JOIN animals an ON an.id = vs.animal_id 
INNER JOIN vets vt ON vt.id = vs.vet_id
ORDER BY vs.date_of_visit DESC
FETCH FIRST 1 ROWS ONLY;

SELECT vt.name, COUNT(*) FROM visits vs
INNER JOIN vets vt ON vt.id = vs.vet_id 
INNER JOIN specializations sp ON sp.vet_id = vs.vet_id 
WHERE sp.species_id IS NULL GROUP BY vt.name;

SELECT vt.name AS Vet_Name, sp.name as Animal_Type, COUNT(sp.name) FROM visits vs
LEFT JOIN animals an ON an.id = vs.animal_id 
INNER JOIN vets vt ON vt.id = vs.vet_id 
INNER JOIN species sp ON sp.id = an.species_id 
WHERE vt.name = 'Maisy Smith' GROUP BY vt.name, sp.name 
ORDER BY COUNT DESC FETCH FIRST 1 ROWS ONLY;

-- Project#: 5 Vet clinic database: database performance audit
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';