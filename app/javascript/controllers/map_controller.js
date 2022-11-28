import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  // static targets = ['link']

  connect() {
    this.link = document.getElementById("new-cache-link");

    // console.log(link);
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })

    this.map.doubleClickZoom.disable();
    this.#addMarkersToMap();
    this.#fitMapToMarkers();

    this.#dropDraggablePin();
    // this.#sendCoordsToForm();

    this.map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl }))
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      // console.log(marker);
        const popup = new mapboxgl.Popup().setHTML(marker.cache_info)
        new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup, {focusAfterOpen: true})
        .addTo(this.map)
      })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

  #sendCoordsToForm(e) {
    // console.log(coords);
    // console.log(`${e.lngLat.lat}`);
    this.link.href = `${this.link.href}?lat=${e.lngLat.lat}&lng=${e.lngLat.lng}`
    // const link = this.link
    new mapboxgl.Marker()
    .setLngLat([ e.lngLat.lat, e.lngLat.lng ])
    .addTo(this.map)

    // setTimeout(function(link) {
    //   console.log(link);
    //   link.click()
    // }, 500);
    this.link.click();
  }

  #dropDraggablePin() {
    const map = this.map
    console.log(map);

    // const canvas = map.getCanvasContainer();

    map.once('mouseup', (e) => {
      // console.log(e.lngLat);
      new mapboxgl.Marker({color: '#f58b54'}).setLngLat(e.lngLat).addTo(map);
      this.#sendCoordsToForm(e)
      // console.log(canvas);
      // const geojson = {
      //   'type': 'FeatureCollection',
      //   'features': [
      //       {
      //         'type': 'Feature',
      //         'geometry': {
      //           'type': 'Point',
      //           'coordinates': [e.lngLat.lat, e.lngLat.lng]
      //         }
      //       }
      //     ]
      //   };

      // console.log(geojson);

      // function onMove(e) {
      //   const coords = e.lngLat;

      //   // Set a UI indicator for dragging.
      //   canvas.style.cursor = 'grabbing';

      //   // Update the Point feature in `geojson` coordinates
      //   // and call setData to the source layer `point` on it.
      //   geojson.features[0].geometry.coordinates = [coords.lat, coords.lng];
      //   map.getSource('point').setData(geojson);
      // }

      // function onUp(e) {
      //   const coords = e.lngLat;

      //   // Print the coordinates of where the point had
      //   // finished being dragged to on the map.
      //   canvas.style.cursor = '';

      //   // Unbind mouse/touch events
      //   map.off('mousemove', onMove);
      //   map.off('touchmove', onMove);
      // }

      //   // Add a single point to the map.
      // map.addSource('point', {
      // 'type': 'geojson',
      // 'data': geojson
      // });

      // map.addLayer({
      //   'id': 'point',
      //   'type': 'circle',
      //   'source': 'point',
      //   'paint': {
      //     'circle-radius': 10,
      //     'circle-color': '#F84C4C' // red color
      //   }
      // });

      // map.setPaintProperty('point', 'circle-color', '#3bb2d0');

      // // // When the cursor enters a feature in
      // // // the point layer, prepare for dragging.
      // map.on('mouseenter', 'point', () => {
      //     map.setPaintProperty('point', 'circle-color', '#3bb2d0');
      //     canvas.style.cursor = 'move';
      // });

      // map.on('mouseleave', 'point', () => {
      //     map.setPaintProperty('point', 'circle-color', '#3887be');
      //     canvas.style.cursor = '';
      //   });

      // map.on('mousedown', 'point', (e) => {
      //     // Prevent the default map drag behavior.
      //     e.preventDefault();

      //     canvas.style.cursor = 'grab';

      //     map.on('mousemove', onMove);
      //     map.once('mouseup', onUp);
      //   });

      // map.on('touchstart', 'point', (e) => {
      //     if (e.points.length !== 1) return;

      //     // Prevent the default map drag behavior.
      //     e.preventDefault();

      //     map.on('touchmove', onMove);
      //     map.once('touchend', onUp);
      //   });
    });
  };
}
