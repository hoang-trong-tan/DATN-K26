import { BrowserRouter, Route, Routes } from "react-router-dom";
import { Providers } from "./Provider";
import routesConfig, { RouteConfigType } from "./routesConfig";
import { Toaster } from "react-hot-toast";

const renderRoutes = (routes: RouteConfigType[]) => {
  return routes.map((route: RouteConfigType, index: number) => {
    if (route.children) {
      return (
        <Route key={index} path={route.path} element={route.element}>
          {renderRoutes(route.children)}
        </Route>
      );
    }

    return (
      <Route
        key={index}
        path={route.path}
        index={route.index}
        element={route.element}
      />
    );
  });
};
function App() {
  return (
    <Providers>
      <BrowserRouter>
        <Routes>{renderRoutes(routesConfig)}</Routes>
      </BrowserRouter>
      <Toaster />
    </Providers>
  );
}

export default App;
