var datas = $(".data").text();
  datas = datas.replace(/=>/g,":");
  datas = datas.replace(/nil/g,"\"\"");


  datas = datas.substring(14);
  datas = datas.slice(0, -11);

  datas = datas.replace("\]",",");
  // datas = datas.replace("},",",");
  datas = datas.match(/{(.*?)},/g);



$(document).ready(function() {

  initializemap();

});

/* -- MAP --  */
function initializemap() {
  console.log('ok');

  var novagile = new google.maps.LatLng(48.875204, 2.351572);
  var map;
  var marker;
  var MY_MAPTYPE_ID = 'Novagile';

  function initialize() {

    var featureOpts = [
      {
        "featureType": "road.highway",
        "elementType": "geometry.fill",
        "stylers": [
          { "hue": "#0022ff" },
          { "color": "#00a7b0" },
          { "lightness": -31 }
        ]
      },{
        "featureType": "road",
        "elementType": "labels.text.stroke",
        "stylers": [
          { "visibility": "on" },
          { "lightness": 1 },
          { "color": "#ffffff" },
          { "weight": 3 }
        ]
      },{
        "featureType": "road.arterial",
        "elementType": "geometry.fill",
        "stylers": [
          { "hue": "#00a1ff" },
          { "color": "#00b0a7" }
        ]
      },{
        "featureType": "road.local",
        "elementType": "geometry",
        "stylers": [
          { "color": "#00b4a7" },
          { "lightness": 11 },
          { "gamma": 0.96 }
        ]
      },{
      }
    ];

    geocoder = new google.maps.Geocoder();

  for (i=0;i<datas.length;i++){
    datas[i] = datas[i].replace("},","}");
    var obj = jQuery.parseJSON(datas[i]);
    if (obj.location!=""){

      var address = obj.location;
      http://maps.google.com/maps/geo?key=yourkeyhere&output=xml&q=520+3rd+Street+San+Francisco+CA

      geocoder.geocode( { 'address': address}, function(results, status) {

      /* Si l'adresse a pu être géolocalisée */
      if (status == google.maps.GeocoderStatus.OK) {

        /* Récupération de sa latitude et de sa longitude */
        lat = results[0].geometry.location.lat();
        lng = results[0].geometry.location.lng();

        /* Affichage du marker */
        var marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location
        });

       } else {
        alert("Le geocodage n\'a pu etre effectue pour la raison suivante: " + status);
       }
      });





    }
    else
    {
      console.log("No location");
    }

  }



    var mapOptions = {
      zoom: 0,
      center: novagile,
      mapTypeControlOptions: {
        mapTypeIds: [google.maps.MapTypeId.ROADMAP, MY_MAPTYPE_ID]
      },
      mapTypeId: MY_MAPTYPE_ID
    };

    map = new google.maps.Map(document.getElementById('map_canvas'),mapOptions,marker);

    var styledMapOptions = {
      name: 'Novagile'
    };

    var customMapType = new google.maps.StyledMapType(featureOpts, styledMapOptions);

    map.mapTypes.set(MY_MAPTYPE_ID, customMapType);

    var marker = new google.maps.Marker({
      position: novagile,
      animation: google.maps.Animation.DROP,
      map: map,
      title:"Novagile"
    });

  }
  google.maps.event.addDomListener(window, 'load', initialize);
}