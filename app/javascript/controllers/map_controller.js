import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    this.link = document.getElementById("new-cache-link");
<<<<<<< Updated upstream

    // console.log(link);
=======
>>>>>>> Stashed changes
    mapboxgl.accessToken = this.apiKeyValue

    mapboxgl.workerCount = 12;
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

    console.log(this.map.markers);

    this.map.doubleClickZoom.disable();
    this.#addMarkersToMap();
    this.#fitMapToMarkers();
    this.#dropPin();

    this.map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl }))
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
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
<<<<<<< Updated upstream
    // this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
=======
    if (this.markersValue.length === 1) {
      this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
    }
>>>>>>> Stashed changes
  }

  #sendCoordsToForm(e) {
    this.link.href = `${this.link.href}?lat=${e.lngLat.lat}&lng=${e.lngLat.lng}`
    new mapboxgl.Marker()
    .setLngLat([ e.lngLat.lat, e.lngLat.lng ])
    .addTo(this.map)
    this.link.click();
  }

  #dropPin() {
    const map = this.map

    map.on('dblclick', (e) => {
<<<<<<< Updated upstream
      console.log(e.lngLat);

=======
>>>>>>> Stashed changes
      new mapboxgl.Marker({color: '#957009'})
      .setLngLat(e.lngLat)
      .addTo(map);

      this.#sendCoordsToForm(e);
    });
  };
}
