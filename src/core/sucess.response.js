"use strict";

const { StatusCode, ReasonPhrases } = require("../util/httpStatusCode");

class Response {
  constructor(message, statusCode, reasonStatusCode, data = {}) {
    (this.message = message || reasonStatusCode),
      (this.status = statusCode),
      (this.data = data);
  }
  send(res, header = {}) {
    return res.status(this.status).json(this);
  }
}

class CreatedResponse extends Response {
  constructor({
    // options = {},
    message,
    statusCode = StatusCode.CREATED,
    reasonStatusCode = ReasonPhrases.CREATED,
    data,
  }) {
    super(message, statusCode, reasonStatusCode, data);
  }
}

class Ok extends Response {
  constructor({
    // options = {},
    message,
    statusCode = StatusCode.OK,
    reasonStatusCode = ReasonPhrases.OK,
    data,
  }) {
    super(message, statusCode, reasonStatusCode, data);
  }
}

module.exports = {
  Response,
  CreatedResponse,
  Ok,
};
