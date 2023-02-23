/*Queries that provide answers to the questions from all projects.*/

SELECT *
FROM animals
WHERE pet_name LIKE '%mon';

SELECT pet_name 
FROM animals 
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT pet_name 
FROM animals 
WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth 
FROM animals 
WHERE pet_name IN ('Agumon', 'Pikachu');

SELECT pet_name, escape_attempts
FROM animals
WHERE weight_kg > 10.5;

SELECT * 
FROM animals
WHERE neutered = true;

SELECT * 
FROM animals
WHERE pet_name <> 'Gabumon';

SELECT * 
FROM animals 
WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE pet_name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, AVG(escape_attempts) AS avg_attempts
FROM animals
GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg)
FROM animals
GROUP BY species;
SELECT species, AVG(escape_attempts) 
FROM animals 
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' 
GROUP BY species;

SELECT animals.pet_name, species.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.pet_name, species.name AS species_name
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT owners.full_name AS owner_name, animals.pet_name AS animal_name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
ORDER BY owners.full_name;

SELECT species.name AS species_name, COUNT(*) AS num_animals
FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species.id, species.name;

SELECT animals.pet_name, species.name AS species_name
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT animals.pet_name, species.name AS species_name, owners.full_name AS owner_name
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name, COUNT(animals.id) AS num_animals
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.id
ORDER BY num_animals DESC
LIMIT 1;
