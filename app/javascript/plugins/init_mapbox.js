import 'mapbox-gl/dist/mapbox-gl.css';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

  const fitMapToMarkers = (map, features) => {
  const bounds = new mapboxgl.LngLatBounds();
  features.forEach(({ geometry }) => bounds.extend(geometry.coordinates));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15 });
  };

  const initMapbox = () => {
  const mapElement = document.getElementById('map');


  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v11', // stylesheet location
      center: [13.4, 52.5], // starting position [lng, lat]
      zoom: 12 // starting zoom
    });


    map.addControl(
    new MapboxGeocoder({
    accessToken: mapboxgl.accessToken,
    mapboxgl: mapboxgl
    })
    );


    map.addControl(new mapboxgl.GeolocateControl({
      positionOptions: {
        enableHighAccuracy: true
      },
      trackUserLocation: true
    }));

      map.on('load', function() {
        const tables = JSON.parse(mapElement.dataset.tables);
        map.addSource('tables', {
            type: 'geojson',
            data: tables,
            cluster: true,
            clusterMaxZoom: 14,
            clusterRadius: 50
          })
        });

      map.on('styledata', function() {
      map.addLayer({
        id: 'clusters',
        type: 'circle',
        source: 'tables',
        filter: ['has', 'point_count'],
        paint: {
          'circle-color': [
            'step',
            ['get', 'point_count'],
            '#51bbd6',
            100,
            '#f1f075',
            750,
            '#f28cb1'
          ],
          'circle-radius': [
            'step',
            ['get', 'point_count'],
            20,
            100,
            30,
            750,
            40
          ]
        }
      });
      map.addLayer({
        id: 'cluster-count',
        type: 'symbol',
        source: 'tables',
        filter: ['has', 'point_count'],
        layout: {
          'text-field': '{point_count_abbreviated}',
          'text-font': ['DIN Offc Pro Medium', 'Arial Unicode MS Bold'],
          'text-size': 12
        }
      });
      map.addLayer({
        id: 'unclustered-point',
        type: 'circle',
        source: 'tables',
        filter: ['!', ['has', 'point_count']],
        paint: {
          'circle-color': '#11b4da',
          'circle-radius': 10,
          'circle-stroke-width': 1,
          'circle-stroke-color': '#fff'
        }
      });

      });

      map.on('click', 'clusters', function (e) {
        const features = map.queryRenderedFeatures(e.point, { layers: ['clusters'] });
        const clusterId = features[0].properties.cluster_id;

        map.getSource('tables').getClusterExpansionZoom(clusterId, function (err, zoom) {
          if (err) return;

          map.easeTo({
            center: features[0].geometry.coordinates,
            zoom: zoom
          });
        });
      });

      map.on('mouseenter', 'clusters', function (e) {
        map.getCanvas().style.cursor = 'pointer';
      });

      map.on('mouseleave', 'clusters', function () {
        map.getCanvas().style.cursor = '';
      });

      map.on('click', 'unclustered-point', function (e) {
        const features = map.queryRenderedFeatures(e.point, { layers: ['unclustered-point'] });
        const infoWindow = features[0].properties.info_window;
        const coordinates = features[0].geometry.coordinates;

        map.easeTo({
          center: features[0].geometry.coordinates
        });

        new mapboxgl.Popup()
          .setLngLat(coordinates)
          .setHTML(infoWindow)
          .addTo(map);
      });

      map.on('mouseenter', 'unclustered-point', function () {
        map.getCanvas().style.cursor = 'pointer';
      });

      map.on('mouseleave', 'unclustered-point', function () {
        map.getCanvas().style.cursor = '';
      });
            // if user clicks on map a new red pin is placed - could be used for easier creating of tables.
        //    map.on("click", function(e){
        //     console.log("background click", e.lngLat);
        //     var geojson = {
        //         type: "FeatureCollection",
        //         features: [{
        //             type:"Feature",
        //             geometry: { type: "Point", coordinates: [ e.lngLat.lng, e.lngLat.lat ]}
        //         }]
        //     };
        //     map.addSource("pins", {
        //         "type": "geojson",
        //         "data": geojson
        //     });
        //     map.addLayer({
        //         id: "pinsLayer",
        //         type: "circle",
        //         source: "pins",
        //         paint: {
        //             "circle-color": "red",
        //             "circle-radius": 5
        //         }
        //     });
        // });


    };
  };


export { initMapbox };
