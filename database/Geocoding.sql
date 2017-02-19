UPDATE siren s
SET banid = (SELECT b.id
	FROM ban b
	WHERE b.code_insee = s.code_insee
	AND levenshtein(LOWER(CONCAT(s.numvoie, ' ', s.typvoie, ' ', s.libvoie)), LOWER(CONCAT(b.numero, b.nom_voie))) < 8
	ORDER BY levenshtein(LOWER(CONCAT(s.numvoie, ' ', s.typvoie, ' ', s.libvoie)), LOWER(CONCAT(b.numero, b.nom_voie)))
	LIMIT 1)
WHERE depet = '93' AND banid IS NULL;

UPDATE siren s
SET banid = (SELECT b.id
	FROM ban b
	WHERE b.code_insee = s.code_insee
	AND levenshtein(LOWER(CONCAT(s.numvoie, ' ', s.typvoie, ' ', s.libvoie)), LOWER(CONCAT(b.numero, b.nom_voie))) < 12
	ORDER BY levenshtein(LOWER(CONCAT(s.numvoie, ' ', s.typvoie, ' ', s.libvoie)), LOWER(CONCAT(b.numero, b.nom_voie)))
	LIMIT 1)
WHERE typvoie IN ('AV', 'BD') AND depet = '93' AND banid IS NULL;
