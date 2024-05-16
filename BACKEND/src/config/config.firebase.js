"use strict";

var admin = require("firebase-admin");

var serviceAccount = require("./firebase/privatekey.json");

const firebaseConfig = admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  projectId: "datn-51c2e",
});

module.exports = firebaseConfig;
