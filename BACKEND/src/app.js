require("dotenv").config();
const express = require("express");
const morgan = require("morgan");
const helmet = require("helmet");
const compression = require("compression");
const cors = require("cors");
const { NotFoundError } = require("./core/error.response");
const app = express();

// Implement CORS
app.use(cors());
// init middleware
app.use(morgan("dev")); //ghi logs yeu cau http vao ung dung
app.use(helmet()); // set security http header
app.use(compression()); // nén các tệp tin truyền từ server đến client để giảm băng thông mạng và tăng tốc độ tải trang
app.use(express.json()); // đọc dữ liệu JSON từ yêu cầu và chuyển đổi nó thành đối tượng JavaScript
app.use(
  express.urlencoded({
    extended: true,
  })
); // đọc dữ liệu từ các biểu mẫu được gửi thông qua yêu cầu và chuyển đổi nó thành đối tượng JavaScript.

// init db
require("./dbs/init.mongodb");

// init router

app.use("/", require("./router/index"));

//handling error
app.all("*", (req, res, next) => {
  const error = new Error(`Can't find ${req.originalUrl} on this server!`);
  error.status = 404;
  next(error);
});

app.use((error, req, res, next) => {
  const statusCode = error.status || 500;
  return res.status(statusCode).json({
    status: "error",
    code: statusCode,
    message: error.message || "Internal Server Error",
    stack: error.stack,
  });
});

module.exports = app;
