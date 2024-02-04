const app = require("./src/app");

const PORT = process.env.DEV_APP_PORT || 5000;

const server = app.listen(PORT, () => {
  console.log(`LMS Is Start With ${PORT}`);
});

process.on("SIGINT", () => {
  server.close(() => console.log(`Exit Server Express`));
});
