<?php
header('Content-type: text/html; charset=utf-8');
$beginning_time = microtime(true);
include_once("connexion.inc.php");

$limit = 1000;

//Companies
if (isset($_GET["type"]) && $_GET["type"] == "companies") {
  $companies_list = "SELECT s.siren, s.nic, s.nomen_long, s.libapet, b.geom, b.lat, b.lon, ST_Distance(ST_SetSRID(ST_Point(" . $_GET['lon'] . ", " . $_GET['lat'] . "), 4326), b.geom) AS distance, b.numero, b.nom_voie, b.code_post, b.nom_commune FROM test.siren93 s, test.ban b WHERE s.banid = b.id ";
  if (isset($_GET["insee"]) && strlen($_GET["insee"]) == 5) {
    $companies_list .= " AND s.code_insee = '" . $_GET['insee'] . "'";
  }
  if (isset($_GET["lat"]) && is_numeric($_GET["lat"]) && isset($_GET["lon"]) && is_numeric($_GET["lon"]) && isset($_GET["distance"]) && is_numeric($_GET["distance"])) { //Lat/Long in WGS84
    $companies_list .= " AND ST_DWithin(ST_SetSRID(ST_Point(" . $_GET['lon'] . ", " . $_GET['lat'] . "), 4326), b.geom, " . distanceConverter($_GET['distance'], "m2dgr") . ")";
  }
  elseif (isset($_GET["x"]) && is_numeric($_GET["x"]) && isset($_GET["y"]) && is_numeric($_GET["y"]) && isset($_GET["distance"]) && is_numeric($_GET["distance"])) { //x/y in Lambert 93
    $companies_list .= " AND ST_DWithin(ST_Transform(ST_SetSRID(ST_Point(" . $_GET['lon'] . ", " . $_GET['lat'] . "), 2154), 4326), b.geom, " . distanceConverter($_GET['distance'], "m2dgr") . ")";
  }
  if (isset($_GET["activity"]) && !empty($_GET["activity"])) {
    $companies_list .= " AND libapet ILIKE '%" . $_GET['activity'] . "%'";
  }

  //Add the ORDER BY
  $companies_list .= " ORDER BY b.code_insee, b.nom_voie, b.numero";

  if (isset($_GET["quantity"]) && is_numeric($_GET["quantity"]) && $_GET["quantity"] <= $limit) {
    $companies_list .= " LIMIT " . $_GET['quantity'] . ";";
  }
  else {
    $companies_list .= " LIMIT " . $limit . ";";
  }

  if (isset($_GET["DEBUG"])) {
    echo "<p><strong>Query :</strong> " . $companies_list . "</p>";
  }

  if ($result = pg_query($dbconn, $companies_list)) {
    $count = pg_num_rows($result);
    if (isset($_GET["DEBUG"])) {
      echo "<p><strong>Count :</strong> " . $count . "</p>";
    }
    $json_companies = "{\"companies\":[";

    $i = 0;

    while ($data = pg_fetch_array($result)) {
      if (isset($_GET["format"]) && strtolower($_GET["format"]) == "json") {
        $json_companies .= json_encode($data);
        if($i < $count - 1){
          $json_companies .= ",";
        }
        $i++;
      }else {
        echo "<strong>SIREN :</strong> " . $data['siren'] . $data['nic'] . " - ";
        echo "<strong>Activité :</strong> " . $data['libapet'] . " - ";
        echo "<strong>Adresse :</strong> " . $data['numero'] . " " . $data['nom_voie'] . " " . $data['code_post'] . " " . $data['nom_commune'] . " - ";
        echo "<strong>Distance :</strong> " . distanceConverter($data['distance'], "dgr2m") . "<br>";
      }
    }
    $json_companies .= "]}";
    if (isset($_GET["format"]) && strtolower($_GET["format"]) == "json") {
      echo $json_companies;
    }
  }
}

function distanceConverter($value, $type){
  //Distances in meters
  $defaultDistance = 500;
  $max_Distance = 10000;
  $ratioDegreeMeter = 6.2e-06;

  if($type == 'm2dgr'){
    if (is_numeric($value) && $value < $max_Distance) {
      return $value * $ratioDegreeMeter;
    }
    else {
      return $defaultDistance * $ratioDegreeMeter;
    }
  }elseif($type == 'dgr2m'){
    if (is_numeric($value) && $value < $max_Distance) {
      return round($value / $ratioDegreeMeter);
    }
    else {
      return round($defaultDistance / $ratioDegreeMeter);
    }
  }
}

pg_free_result($result);

//Company

//Addresses

//Address

pg_close($dbconn);

if (isset($_GET["DEBUG"])) {
  echo "<p><strong>Temps d'exécution :</strong> " . round(microtime(true) - $beginning_time, 4) . " s</p>";
}
?>
