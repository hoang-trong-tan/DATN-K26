"use strict";

const dev = {
  app: {
    port: process.env.DEV_APP_PORT || 5000,
  },

  db: {
    host: process.env.DEV_DB_PORT || "127.0.0.1",
    port: process.env.DEV_DB_PORT || "27017",
    name: process.env.DEV_DB_PORT || "lmsDEV",
  },
};

const prod = {
  app: {
    port: process.env.PROD_APP_PORT || 8080,
  },

  db: {
    host: process.env.PROD_DB_PORT || "127.0.0.1",
    port: process.env.PROD_DB_PORT || "27017",
    name: process.env.PROD_DB_PORT || "lmsPROD",
  },
};

const config = { dev, prod };

const env = process.env.NODE_ENV || "dev";

console.log(config[env], env);

module.exports = config[env];
