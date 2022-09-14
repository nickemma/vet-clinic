/*Queries that provide answers to the questions from all projects.*/
SELECT * FROM animals;
SELECT name FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered is true AND escape_attempt < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempt FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered is true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;
ALTER TABLE animal ADD COLUMN specie VARCHAR;
SELECT * FROM animals;
UPDATE animal SET specie = 'unspecified';
ROLLBACK;
SELECT * FROM animals;
BEGIN
UPDATE animals SET specie = 'digimon' WHERE name LIKE '%mon';
SELECT * FROM animals;
UPDATE animals SET specie = 'Pokemon' WHERE specie is NULL;
COMMIT;
SELECT * FROM animals;
BEGIN
DELETE FROM animals; 
ROLLBACK;
SELECT * FROM animals;
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT sp1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
ROLLBACK sp1;
SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempt = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT MAX(escape_attempt) FROM animals GROUP BY neutered;
SELECT MIN(weight_kg), MAX(weight_kg) FROM animals;
SELECT AVG(escape_attempt) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31';


-- Link animal table to species table and owners table

-- Update species_id in animal table
UPDATE animal SET species_id = 2 WHERE name LIKE '%mon';

UPDATE animal SET species_id = 1 WHERE name NOT LIKE '%mon';

-- Update owner_id in animal table
UPDATE animal SET owners_id = 1 WHERE name = 'Agumon';

UPDATE animal SET owners_id = 2 WHERE name  = 'Gabumon' OR name ='Pikachu';

UPDATE animal SET owners_id = 3 WHERE name = 'Devimon' OR name = 'Plantmon';

UPDATE animal SET owners_id = 4 WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';

UPDATE animal SET owners_id = 5 WHERE name = 'Angemon' OR name = 'Boarmon';


--  write querries usinf JOIN

SELECT animal.name FROM animal JOIN owners ON animal.owners_id = owners.id WHERE owners.full_name = 'Melody Pond';

SELECT * FROM animal JOIN species ON animal.species_id = species.id WHERE species.name = 'Pokemon';

SELECT animal.name, owners.full_name FROM animal RIGHT JOIN owners ON animal.owners_id = owners.id;

SELECT species.name, COUNT(animal.species_id) FROM animal JOIN species ON species.id = animal.species_id GROUP BY species.name;

SELECT animal.name from animal JOIN owners ON owners.id = animal.owners_id JOIN species on species.id = animal.species_id WHERE animal.species_id = '2' AND animal.owners_id = '2';

SELECT animal.name from animal JOIN owners ON owners.id = animal.owners_id WHERE animal.escape_attempts = '0' AND animal.owners_id = '5';

SELECT full_name, COUNT(owners_id) FROM owners JOIN animal on owners.id = animal.owners_id GROUP BY full_name ORDER BY COUNT (owners_id) desc limit 1;