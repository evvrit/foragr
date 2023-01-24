import { Controller } from "@hotwired/stimulus";
import mapboxgl from "mapbox-gl/dist/mapbox-gl";
import MapboxWorker from "mapbox-gl/dist/mapbox-gl-csp-worker";

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
  };

  connect() {
    this.link = document.getElementById("new-cache-link");
    this.plus = document.getElementById("plus-link");

    mapboxgl.workerClass = MapboxWorker;
    mapboxgl.accessToken = this.apiKeyValue;

    this.#setStaticImage();

    this.map = new mapboxgl.Map({
      container: "map",
      style: "mapbox://styles/mapbox/streets-v10?optimize=true",
      center: [-73.60488, 45.53257],
      zoom: 10,
    });

    this.map.on("load", () => {
      const mapContainerEl = document.getElementById("map");
      mapContainerEl.style.visibility = "visible";
    });

    if (this.markersValue.length > 1) {
      this.map.addControl(
        new MapboxGeocoder({
          accessToken: mapboxgl.accessToken,
          mapboxgl: mapboxgl,
        })
      );
    }

    this.map.doubleClickZoom.disable();
    this.#addMarkersToMap();
    this.#fitMapToMarkers();
    this.#togglePinDropAbility();
  }

  #setStaticImage() {
    if (this.markersValue.length === 1) {
      this.static = document.getElementById("sm-static");
      this.lat = this.markersValue[0].lng; // lng/lat are inverted somewhere. should be
      this.lng = this.markersValue[0].lat; // fixed for clarity.
    } else {
      this.static = document.getElementById("static");
      this.lat = -73.60488;
      this.lng = 45.53257;
    }
    const width = this.static.offsetWidth;
    const height = this.static.offsetHeight;
    this.static.style.backgroundImage = `url(https://api.mapbox.com/styles/v1/mapbox/streets-v10/static/${this.lat},${this.lng},10/${width}x${height}?access_token=${this.apiKeyValue})`;
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup({
        className: "popup-container",
        closeOnClick: true,
        focusAfterOpen: false,
      })
        .setHTML(marker.cache_info)
        .setMaxWidth("250px");
      let one_marker = new mapboxgl.Marker({ color: "#35635B" })
        .setLngLat([marker.lng, marker.lat])
        .addTo(this.map);
      if (this.markersValue.length > 1) {
        one_marker.setPopup(popup, { focusAfterOpen: true }).addTo(this.map);
      }
    });
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds();
    this.markersValue.forEach((marker) =>
      bounds.extend([marker.lng, marker.lat])
    );
    if (this.markersValue.length === 1) {
      this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
    }
  }

  #togglePinDropAbility() {
    if (this.plus) {
      this.plus.addEventListener("click", (e) => {
        ["fa-xl", "fa-2xl"].map((v) => e.currentTarget.classList.toggle(v));
        if (e.currentTarget.classList.contains("fa-2xl")) {
          this.#checkClickLocation();
        }
      });
    }
  }

  #checkClickLocation() {
    this.map.on("click", (e) => {
      const offset = 0.01; // we use it to build a selection area around each marker
      const clickLat = e.lngLat.lat;
      const clickLng = e.lngLat.lng;
      let userClickedMarker = false;
      this.markersValue.forEach((marker) => {
        // this actually checks the longitude
        const clickedWithinLat =
          clickLat > marker.lat && clickLat < marker.lat + 2 * offset;
        // actually checks latitude
        const clickedWithinLng =
          clickLng > marker.lng - offset && clickLng < marker.lng + offset;
        if (clickedWithinLat && clickedWithinLng) {
          userClickedMarker = true;
          return;
        }
      });
      if (!userClickedMarker && this.markersValue.length > 1) {
        this.#dropPin(e);
        this.#sendCoordsToForm(e);
      }
    });
  }

  #dropPin(e) {
    new mapboxgl.Marker({ color: "#957009" })
      .setLngLat(e.lngLat)
      .addTo(this.map);
  }

  #sendCoordsToForm(e) {
    this.link.href = `${this.link.href}?lat=${e.lngLat.lat}&lng=${e.lngLat.lng}`;
    new mapboxgl.Marker()
      .setLngLat([e.lngLat.lat, e.lngLat.lng])
      .addTo(this.map);
    this.link.click();
  }
}
