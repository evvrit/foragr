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

    mapboxgl.workerCount = 4;
    // console.log(mapboxgl.workerCount);
    mapboxgl.prewarm();

    this.map = new mapboxgl.Map({
      container: "map",
      style: "mapbox://styles/mapbox/streets-v10?optimize=true",
      center: [-73.60488, 45.53257],
      zoom: 10,
    })

    this.map.on('load', () => {
      const mapContainerEl = document.getElementById('map');
      mapContainerEl.style.visibility = 'visible';
    });

    this.map.doubleClickZoom.disable();
    this.#addMarkersToMap();
    this.#fitMapToMarkers();

    this.#dropPin();
    // this.#sendCoordsToForm();

    this.map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl }))

      // this.map.on('click', (e) => {
      // console.log("click");
      // console.log(e);
    // })

    // this.map.on('zoom', (e) => {
    //   // this.map.doubleClickZoom.disable();
    //   console.log("zoom");
    //   // this.map.doubleClickZoom.enable();
    // })

    // this.map.on('doubleClickZoom', (e) => {
    //   console.log(e.originalEvent);
    // })
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      // console.log(marker);
        const popup = new mapboxgl.Popup().setHTML(marker.cache_info)
        this.marker = new mapboxgl.Marker({color: '#35635B'})
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup, {focusAfterOpen: true})
        .addTo(this.map)
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    // this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

  #sendCoordsToForm(e) {
    // console.log(coords);
    // console.log(`${e.lngLat.lat}`);
    this.link.href = `${this.link.href}?lat=${e.lngLat.lat}&lng=${e.lngLat.lng}`
    // const link = this.link
    new mapboxgl.Marker()
    .setLngLat([ e.lngLat.lat, e.lngLat.lng ])
    .addTo(this.map)
    this.link.click();
  }

  #dropPin() {
    const map = this.map
    // console.log(map);

    // const canvas = map.getCanvasContainer();

    map.on('dblclick', (e) => {
      console.log(e.lngLat);

      new mapboxgl.Marker({color: '#957009'})
      .setLngLat(e.lngLat)
      .addTo(map);

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
