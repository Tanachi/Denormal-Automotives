DROP USER IF EXISTS denormal_user;
CREATE USER denormal_user;
DROP DATABASE IF EXISTS denormal_cars;;
CREATE DATABASE denormal_cars;
DROP TABLE IF EXISTS car_models;
GRANT ALL ON DATABASE denormal_cars TO denormal_user;
\i scripts/denormal_data.sql
\dS
SELECT DISTINCT ON (make_title) make_title FROM car_models;
SELECT DISTINCT ON (model_title) model_title FROM car_models WHERE make_code = 'VOLKS';
SELECT make_code, model_code, model_title, year FROM car_models WHERE make_code = 'LAM';
SELECT * FROM car_models WHERE year <= 2015 AND year >= 2010;
