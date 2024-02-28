"use strict";

const nodemailer = require("nodemailer");

const mailConfig = {
  host: process.env.SMTP_HOST,
  port: process.env.SMTP_PORT,
  service: process.env.SMTP_SERVICE,
  auth: {
    user: process.env.SMTP_MAIL,
    pass: process.env.SMTP_PASSWORD,
  },
};

const transporter = nodemailer.createTransport(mailConfig);

module.exports = transporter;
