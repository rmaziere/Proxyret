--BAN
ALTER TABLE ban
	ADD COLUMN geom geometry(Point,4326);

UPDATE ban
  SET geom = ST_SetSRID(ST_Point(lon, lat), 4326)
  WHERE geom IS NULL;

--Siren
ALTER TABLE siren93
	ADD COLUMN code_insee character varying(5),
  ADD COLUMN banid character varying(30);

UPDATE siren93
  SET code_insee = CONCAT(depet, comet);
  
UPDATE siren93 s
SET banid = (
	SELECT t.banid
	FROM test.siren93 t
	WHERE t.siren = s.siren
	AND t.nic = s.nic);


ALTER TABLE siren93
	ADD COLUMN geom geometry(Point,4326);
		
UPDATE siren93 s
SET geom = (
	SELECT b.geom
	FROM test.ban b
	WHERE b.id = s.banid);
