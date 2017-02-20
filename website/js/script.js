var server_name = "server.home";
var directory   = "/cartoWeb";

/***
**leaflet
***/
var map = L.map("map").setView([48.856578, 2.351828], 10);

var layer = L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
  attribution: "&copy; <a href='https://osm.org/copyright'>OpenStreetMap</a> contributors"
}).addTo(map);

var mylat, mylon;

var layerMarkers = [];

document.getElementById("submit").addEventListener("click", getValues);
document.getElementById("removeMarker").addEventListener("click", removeMarker);
document.getElementById("locateMe").addEventListener("click", locateMe);

function getValues(event){
  var distance = document.getElementById('distance').value;
  var activity = document.getElementById('activity').value;

  waitingDialog.show("Recherche en cours... Veuillez patienter.");

  // création de l'objet xhr
  var ajax = new XMLHttpRequest();

  var uri_query = "http://" + server_name + directory + "/api.php?format=json&type=companies&distance=" + distance + "&activity=" + activity + "&lat=" + mylat + "&lon=" + mylon;

  console.log(uri_query);

  // destination et type de la requête AJAX (asynchrone ou non)
  ajax.open("GET", uri_query, true);

  // métadonnées de la requête AJAX
  ajax.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

  // evenement de changement d'état de la requête
  ajax.addEventListener("readystatechange", function(e) {

    // si l'état est le numéro 4 et que la ressource est trouvée
    if (ajax.readyState == 4 && ajax.status == 200) {
      // le texte de la réponse
      var result = JSON.parse(ajax.responseText);

      console.log("Number of companies : " + result.companies.length);

      if (result.companies.length > 0) {
        var liste = "";
        for (var i = 0; i < result.companies.length; i++) {
          var siret = result.companies[i].siren + result.companies[i].nic;
          addMarker(result.companies[i].lat, result.companies[i].lon,
          "<strong>Nom : </strong>" + result.companies[i].nomen_long + "<br>" +
          "<strong>Activité : </strong>" + result.companies[i].libapet + "<br>" +
          "<strong>Distance : </strong>" + Math.round(result.companies[i].distance / 6e-06) + " m " +
          "<a href='http://map.project-osrm.org/?z=14&center="+ mylat + "," + mylon + "&loc="+ mylat +"," + mylon + "&loc=" + result.companies[i].lat + "," + result.companies[i].lon + "&hl=en&alt=0' target='_blank'>Y aller</a>");
        }
      } else {
        console.log("No result !");
      }
      waitingDialog.hide();
    }
  });
  // envoi de la requête
  ajax.send();
}

function addMarker(lat, long, label) {
  var marker = L.marker([lat, long]);
  layerMarkers.push(marker);
  marker.addTo(map).bindPopup(label);

  mapSetView(lat, long, 14);
}

function removeMarker(event){
  removeLayer(layerMarkers);
}

function removeLayer(layerName) {
  if (layerName !== undefined && layerName.length > 0) {
    for (var i = 0; i < layerName.length; i++) {
      layerName[i].remove();
    }
  }
}

function mapSetView(lat, long, zoom) {
  if (zoom === undefined) {
    zoom = 10;
  }
  map.setView([lat, long], zoom);
}

function setPosition(latitude, longitude){
  mylat = latitude;
  mylon = longitude;
}

//Locate Me
function locateMe(event) {
  navigator.geolocation.getCurrentPosition(function(position) {
    setPosition(position.coords.latitude, position.coords.longitude);
    addMarker(position.coords.latitude, position.coords.longitude, "Me");
    mapSetView(position.coords.latitude, position.coords.longitude, 16);
  });
}

//Add Marker on Map click
map.on('click', function(e){
  console.log("lat : " + e.latlng["lat"] + ", lon : " + e.latlng["lng"]);
  setPosition(e.latlng["lat"], e.latlng["lng"]);
  addMarker(e.latlng["lat"], e.latlng["lng"], "Me");
  mapSetView(e.latlng["lat"], e.latlng["lng"], 16);
});
