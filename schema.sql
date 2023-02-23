/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;
\c vet_clinic

CREATE TABLE animals (
  id              INT GENERATED ALWAYS AS IDENTITY,
  pet_name        VARCHAR(15),
  date_of_birth   DATE,
  escape_attempts INT,
  neutered        BOOLEAN,
  weight_kg       DECIMAL,  
  PRIMARY KEY(id)
);

ALTER TABLE animals ADD COLUMN species VARCHAR(20);

CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name TEXT,
  age INTEGER
);

CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name TEXT
);

ALTER TABLE animals DROP COLUMN species;

-- Add the 'species_id' column as a foreign key referencing the 'species' table
ALTER TABLE animals ADD COLUMN species_id INTEGER REFERENCES species(id);

-- Add the 'owner_id' column as a foreign key referencing the 'owners' table
ALTER TABLE animals ADD COLUMN owner_id INTEGER REFERENCES owners(id);

