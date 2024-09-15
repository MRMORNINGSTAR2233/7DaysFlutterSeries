const mongoose = require('mongoose');

const connection = mongoose
  .createConnection("Enter your api key here")
  .on("open", () => {
    console.log("MongoDb Connected");
  })
  .on("error", () => {
    console.log("MongoDb connection error");
  });

module.exports = connection;