##Benchmark##

###BAN93###

**Volumétrie :** 230.046 entités (38,99 Mo)

Requête|Champ|Sans Index|Avec Index
---|---|---|---
0|id|16,277 ms|0,505 ms
1|id|65,989 ms|63,981 ms
2|id|79,285 ms|78,409 ms
3|id|118,167 ms|116,099 ms
10|nom_voie|53,061 ms|0,661 ms
11|nom_voie|59,211 ms|0,497 ms

####Index####

**id**

```sql
CREATE INDEX ban_id
   ON ban (id ASC NULLS LAST);
--Time : 8,5 s
```

**nom_voie**

```sql
CREATE INDEX ban_voie
   ON ban (nom_voie ASC NULLS LAST);
--Time : 4,9 s
```

####Requêtes####

```sql
0 : SELECT * FROM ban WHERE id = 'ADRNIVX_0000000268114257';
1 : SELECT * FROM ban WHERE id LIKE 'ADRNIVX_0000000268114257';
2 : SELECT * FROM ban WHERE id LIKE '%ADRNIVX_0000000268114257%';
3 : SELECT * FROM ban WHERE id LIKE '%0000000268114257';

10 : SELECT * FROM ban WHERE nom_voie = 'rue charles de gaulle';
11 : SELECT * FROM ban WHERE nom_voie LIKE 'rue charles de gaulle';
```

###SIRENE###

**Volumétrie :** 10.563.603 entités (8.514,09 Mo)

Requête|Champ|Sans Index|Avec Index
---|---|---|---
20|depet|138.674,392 ms|109.476,719 ms
30|libvoie|140.194,666 ms|75.194,083 ms
31|libvoie|150.663,147 ms|566,153 ms

####Index####

**id**

```sql
CREATE INDEX siren_depet
   ON siren (depet ASC NULLS LAST);
--Time : 200.913,973 ms
```

**libvoie**

```sql
CREATE INDEX siren_voie
   ON siren (libvoie ASC NULLS LAST);
--Time : 300.584,191 ms
```

####Requêtes####

```sql
20 : SELECT * FROM siren WHERE depet = '93';

30 : SELECT * FROM siren WHERE libvoie = 'CHARLES DE GAULLE';
31 : SELECT * FROM siren WHERE libvoie LIKE 'CHARLES DE GAULLE';
```