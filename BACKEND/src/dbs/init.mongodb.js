"use strict";

const mongoose = require("mongoose");

const {
  db: { host, port, name },
} = require("../config/config.mongodb");

const stringConnect = `mongodb://${host}:${port}/${name}`;

console.log(`ConnectString::${stringConnect}`);

mongoose
  .connect(stringConnect)
  .then((_) => console.log(`Connect Mongodb Success!!`))
  .catch((err) => console.log(`Error Connect::`, err));

if (1 === 1) {
  mongoose.set("debug", true);
  mongoose.set("debug", { color: true });
}

module.exports = mongoose;
