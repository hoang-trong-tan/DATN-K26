import mapboxgl from "mapbox-gl";
import "mapbox-gl/dist/mapbox-gl.css";
import { useCallback, useMemo, useRef } from "react";
import Map, { Marker } from "react-map-gl";

const MAPBOX_TOKEN =
  "pk.eyJ1IjoibG9jZHgta296b2NvbTIwMDQiLCJhIjoiY2x3NHBnbGY2MWJ6ZjJpcDdiMW84OWQ1YSJ9.gAQM8biUngpUEifraC4TlQ";
export const Policy = () => {
  // const [viewport, setViewport] = useState({
  //   latitude: 40,
  //   longitude: -100,
  //   zoom: 3.5,
  // });
  const markerRef: any = useRef<mapboxgl.Marker>();

  const popup = useMemo(() => {
    return new mapboxgl.Popup().setText("Hello world!");
  }, []);

  const togglePopup = useCallback(() => {
    console.log({ markerRef });
    markerRef.current?.togglePopup();
  }, []);
  return (
    <div className="w-[500px] h-[500px]">
      <Map
        // {...viewport}
        mapboxAccessToken={MAPBOX_TOKEN}
        latitude={40}
        longitude={-100}
        zoom={3.5}
        // onMove={(evt) => setViewport(evt.viewState)}
        cooperativeGestures
        mapStyle="mapbox://styles/mapbox/streets-v9"
        onClick={togglePopup}
      >
        <Marker
          longitude={-100}
          latitude={40}
          color="red"
          popup={popup}
          ref={markerRef}
        />
      </Map>
    </div>
  );
};

export default Policy;
