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
    mapboxgl.accessToken = this.apiKeyValue

    mapboxgl.workerCount = 12;
    mapboxgl.prewarm();

    this.#setStaticImage();

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
    this.#checkClickLocation();
  }

  #setStaticImage() {
    if (this.markersValue.length === 1) {
      this.static = document.getElementById("sm-static");
      this.lat = this.markersValue[0].lng; // just trust me
      this.lng = this.markersValue[0].lat;

    } else {
      this.static = document.getElementById("static");
      this.lat = -73.60488
      this.lng = 45.53257
    }
    const width = this.static.offsetWidth;
    const height = this.static.offsetHeight;
    this.static.style.backgroundImage = `url(https://api.mapbox.com/styles/v1/mapbox/streets-v10/static/${this.lat},${this.lng},10/${width}x${height}?access_token=${this.apiKeyValue})`
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
    if (this.markersValue.length === 1) {
      this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
    }
  }

  #checkClickLocation() {
    this.map.on('click', (e) => {
      const offset = 0.01 // we use it to build a selection area around each marker
      const clickLat = e.lngLat.lat
      const clickLng = e.lngLat.lng
      let userClickedMarker = false
      this.markersValue.forEach(marker => {
        // this actually checks the longitude. error in seed do not touch !!!
        const clickedWithinLat = clickLat > (marker.lat) && clickLat < (marker.lat + (2 * offset))
        // actually checks latitude
        const clickedWithinLng = clickLng > (marker.lng - offset) && clickLng < (marker.lng + offset)
        if (clickedWithinLat && clickedWithinLng) {
          userClickedMarker = true
          return
        }
      })
      if (!userClickedMarker) {
        this.#dropPin(e);
        this.#sendCoordsToForm(e);
      }
    })
  }

  #dropPin(e) {
    new mapboxgl.Marker({color: '#957009'})
    .setLngLat(e.lngLat)
    .addTo(this.map);
  };

  #sendCoordsToForm(e) {
    this.link.href = `${this.link.href}?lat=${e.lngLat.lat}&lng=${e.lngLat.lng}`
    new mapboxgl.Marker()
    .setLngLat([ e.lngLat.lat, e.lngLat.lng ])
    .addTo(this.map)
    this.link.click();
  }
}
