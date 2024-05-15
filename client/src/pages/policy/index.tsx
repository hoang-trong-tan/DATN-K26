import mapboxgl from "mapbox-gl";
import "mapbox-gl/dist/mapbox-gl.css";
import { useCallback, useMemo, useRef, useState } from "react";
import Map, { Marker } from "react-map-gl";

const MAPBOX_TOKEN =
  "pk.eyJ1IjoibG9jZHgta296b2NvbTIwMDQiLCJhIjoiY2x3NHBnbGY2MWJ6ZjJpcDdiMW84OWQ1YSJ9.gAQM8biUngpUEifraC4TlQ";
export const Policy = () => {
  const [viewport, setViewport] = useState({
    latitude: 35.72,
    longitude: 139.74,
    zoom: 8,
  });
  const markerRef: any = useRef<mapboxgl.Marker>();
  const popup = useMemo(() => {
    return new mapboxgl.Popup().setText("Hello");
  }, []);

  const togglePopup = useCallback(() => {
    markerRef.current?.togglePopup();
  }, []);
  return (
    <div className="w-[500px] h-[500px]">
      <h1 style={{}}>Hello</h1>
      <Map
        {...viewport}
        mapboxAccessToken={MAPBOX_TOKEN}
        onMove={(evt) => setViewport(evt.viewState)}
        cooperativeGestures
        mapStyle="mapbox://styles/mapbox/standard"
      >
        <Marker
          longitude={139.74}
          latitude={35.72}
          color="red"
          popup={popup}
          ref={markerRef}
          onClick={togglePopup}
        />
        <Marker
          longitude={139.5}
          latitude={35.9}
          color="red"
          popup={popup}
          ref={markerRef}
          onClick={togglePopup}
        />
        <Marker
          longitude={139.8}
          latitude={36}
          color="red"
          popup={popup}
          ref={markerRef}
          onClick={togglePopup}
        />
      </Map>
    </div>
  );
};

export default Policy;
