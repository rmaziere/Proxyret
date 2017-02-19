--BAN
ALTER TABLE ban
	ADD COLUMN geom geometry(Point,4326);

UPDATE ban
  SET geom = ST_SetSRID(ST_Point(lon, lat), 4326)
  WHERE geom IS NULL;

--Siren
ALTER TABLE siren
	ADD COLUMN code_insee character varying(5),
  ADD COLUMN banid character varying(30);

UPDATE siren
  SET code_insee = CONCAT(depet, comet)
  WHERE code_insee IS NULL;
