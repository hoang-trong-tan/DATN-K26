"use strict";

const transporter = require("../config/config.email");
const path = require("path");
const ejs = require("ejs");

const sendMail = async (option) => {
  const { email, subject, template, data } = option;

  const templatePath = path.join(__dirname, "../mails", template);

  const html = await ejs.renderFile(templatePath, data);

  const mailOptions = {
    from: process.env.SMTP_MAIL,
    to: email,
    subject,
    html,
  };

  await transporter.sendMail(mailOptions);
};

module.exports = sendMail;
