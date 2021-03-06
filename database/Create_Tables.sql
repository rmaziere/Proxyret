CREATE TABLE ban (
  id character varying(30) NOT NULL,
  nom_voie character varying(255) DEFAULT NULL,
  id_fantoir character varying(5),
  numero character varying(5) DEFAULT NULL,
  rep character varying(25) DEFAULT NULL,
  code_insee character varying(5) NOT NULL,
  code_post character varying(5) NOT NULL,
  alias character varying(50) DEFAULT NULL,
  nom_ld character varying(50) DEFAULT NULL,
  nom_afnor character varying(50),
  libelle_acheminement character varying(50),
  x numeric(10,2),
  y numeric(10,2),
  lon numeric(16,14),
  lat numeric(16,14),
  nom_commune character varying(255) NOT NULL,
  CONSTRAINT ban_pk PRIMARY KEY (id)
);

CREATE TABLE siren (
  siren character varying(9) NOT NULL,
  nic character varying(5) NOT NULL,
  l1_normalisee character varying(38),
  l2_normalisee character varying(38),
  l3_normalisee character varying(38),
  l4_normalisee character varying(38),
  l5_normalisee character varying(38),
  l6_normalisee character varying(38),
  l7_normalisee character varying(38),
  l1_declaree character varying(38),
  l2_declaree character varying(38),
  l3_declaree character varying(38),
  l4_declaree character varying(38),
  l5_declaree character varying(38),
  l6_declaree character varying(38),
  l7_declaree character varying(38),
  numvoie character varying(4),
  indrep character varying(1),
  typvoie character varying(4),
  libvoie character varying(32) DEFAULT NULL,
  codpos character varying(5) NOT NULL,
  cedex character varying(5) NOT NULL,
  rpet character varying(2),
  libreg character varying(70),
  depet character varying(2) NOT NULL,
  arronet character varying(2) DEFAULT NULL,
  ctonet character varying(3) DEFAULT NULL,
  comet character varying(3) NOT NULL,
  libcom character varying(32) NOT NULL,
  du character varying(2),
  tu character varying(1),
  uu character varying(2),
  epci character varying(9) DEFAULT NULL,
  tcd character varying(2),
  zemet character varying(4),
  siege character varying(1),
  enseigne character varying(50) NOT NULL,
  ind_publipo character varying(1),
  diffcom character varying(1) NOT NULL,
  amintret character varying(6),
  natetab character varying(1),
  libnatetab character varying(30) NOT NULL,
  apet700 character varying(5) NOT NULL,
  libapet character varying(65) NOT NULL,
  dapet character varying(4),
  tefet character varying(2) NOT NULL,
  libtefet character varying(23) NOT NULL,
  efetcent character varying(6) NOT NULL,
  defet character varying(4),
  origine character varying(2),
  dcret character varying(8),
  ddebact character varying(8),
  activnat character varying(2),
  lieuact character varying(2),
  actisurf character varying(2),
  saisonat character varying(2) NOT NULL,
  modet character varying(1) NOT NULL,
  prodet character varying(1) NOT NULL,
  prodpart character varying(1),
  auxilt character varying(1),
  nomen_long character varying(131) NOT NULL,
  sigle character varying(20),
  nom character varying(100) NOT NULL,
  prenom character varying(30) NOT NULL,
  civilite character varying(1),
  rna character varying(10),
  nicsiege character varying(5),
  rpen character varying(2),
  depcomen character varying(5),
  adr_mail character varying(80) DEFAULT NULL,
  nj character varying(4) NOT NULL,
  libnj character varying(100) NOT NULL,
  apen700 character varying(5) NOT NULL,
  libapen character varying(65) NOT NULL,
  dapen character varying(4),
  aprm character varying(6),
  ess character varying(1),
  dateess character varying(8),
  tefen character varying(2) NOT NULL,
  libtefen character varying(23) NOT NULL,
  efencent character varying(6) NOT NULL,
  defen character varying(4),
  categorie character varying(5) NOT NULL,
  dcren character varying(8),
  amintren character varying(6),
  monoact character varying(1),
  moden character varying(1),
  proden character varying(1),
  esaann character varying(4),
  tca character varying(1),
  esaapen character varying(5),
  esasec1n character varying(5),
  esasec2n character varying(5),
  esasec3n character varying(5),
  esasec4n character varying(5),
  vmaj character varying(1) NOT NULL,
  vmaj1 character varying(1),
  vmaj2 character varying(1),
  vmaj3 character varying(1),
  datemaj character varying(19),
  CONSTRAINT siren_pk PRIMARY KEY (siren, nic)
);
