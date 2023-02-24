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

SELECT animals.pet_name AS animal_name, visits.visit_date
FROM visits
JOIN animals ON animals.id = visits.animal_id
WHERE visits.vet_id = (SELECT id FROM vets WHERE name = 'William Tatcher')
ORDER BY visits.visit_date DESC
LIMIT 1;

SELECT COUNT(DISTINCT animal_id) AS num_animals
FROM visits
WHERE vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez');

SELECT v.name AS vet_name, s.name AS specialization_name
FROM vets v
LEFT JOIN specializations sp ON v.id = sp.vet_id
LEFT JOIN species s ON sp.species_id = s.id;

SELECT a.pet_name, v.visit_date
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets vt ON v.vet_id = vt.id
WHERE vt.name = 'Stephanie Mendez' AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT a.pet_name, COUNT(*) AS num_visits
FROM visits v
JOIN animals a ON v.animal_id = a.id
GROUP BY a.id
ORDER BY num_visits DESC
LIMIT 1;

SELECT v.visit_date, a.pet_name, vt.name AS vet_name
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets vt ON v.vet_id = vt.id
WHERE a.owner_id = (SELECT id FROM owners WHERE full_name = 'Maisy Smith')
ORDER BY v.visit_date
LIMIT 1;

SELECT a.pet_name, v.visit_date, vt.name AS vet_name, vt.date_of_graduation
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets vt ON v.vet_id = vt.id
WHERE v.visit_date = (SELECT MAX(visit_date) FROM visits) 
LIMIT 1;

SELECT COUNT(*)
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets vt ON v.vet_id = vt.id
WHERE NOT EXISTS (
  SELECT *
  FROM specializations s
  WHERE s.vet_id = vt.id AND s.species_id = a.species_id
);

SELECT s.name AS specialty, COUNT(*) AS visit_count
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN species s ON a.species_id = s.id
JOIN vets vt ON v.vet_id = vt.id
WHERE vt.name = 'Maisy Smith'
GROUP BY s.name
ORDER BY visit_count DESC
LIMIT 1;
