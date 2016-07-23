DROP USER IF EXISTS normal_user;
CREATE USER normal_user;
DROP DATABASE IF EXISTS normal_cars;
CREATE DATABASE normal_cars;
GRANT ALL ON DATABASE normal_cars TO normal_user;
DROP TABLE IF EXISTS make;
DROP TABLE IF EXISTS model;
DROP TABLE IF EXISTS normal_cars;
CREATE TABLE make(
  id SERIAL PRIMARY KEY,
  code character varying(125) NOT NULL,
  title character varying(125) NOT NULL
);
INSERT INTO make (
  code,
  title
)
SELECT DISTINCT ON (make_code) make_code,
  make_title
  FROM car_models;

CREATE TABLE model(
  id SERIAL PRIMARY KEY,
  code character varying(125) NOT NULL,
  title character varying(125) NOT NULL
);
INSERT INTO model(code,
  title
)
SELECT DISTINCT ON(model_code) model_code,
  model_title
  FROM car_models;

CREATE TABLE normal_cars(
  make_id INTEGER REFERENCES make(id) NOT NULL,
  model_id INTEGER REFERENCES model(id) NOT NULL,
  year INTEGER NOT NULL
);
INSERT INTO normal_cars(
  make_id,
  model_id, year
)
  SELECT make.id, model.id, car_models.year
  FROM car_models
    INNER JOIN make
      ON car_models.make_code = make.code
    INNER JOIN model
      ON car_models.model_code = model.code;

SELECT make.code, make.title, model.code, model.title, normal_cars.year FROM normal_cars
RIGHT JOIN make ON normal_cars.make_id = make.id
RIGHT JOIN model ON normal_cars.model_id = model.id;

