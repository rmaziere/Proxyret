--BAN
CREATE INDEX ban_insee ON ban
	USING btree (code_insee);

CREATE INDEX ban_id ON ban
	USING btree (id);

--Siren
CREATE INDEX siren_dept ON siren
  USING btree (depet);

CREATE INDEX siren_code_insee ON siren
  USING btree (code_insee);
