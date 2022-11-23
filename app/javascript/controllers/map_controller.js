import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

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
    this.#sendCoordsToForm();

  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
        const popup = new mapboxgl.Popup().setHTML(marker.cache_info)
        new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
      })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

  #sendCoordsToForm() {
    this.map.on('dblclick', (e) => {
      // const coords = `?lat=${e.lngLat.lat}&lng=${e.lngLat.lng}`

      this.link.href = `${this.link.href}?lat=${e.lngLat.lat}&lng=${e.lngLat.lng}`
      // console.log(coords);
      // console.log(this.link.href);
      // console.log(this.link.href);
      this.link.click()
    })
  }

}
