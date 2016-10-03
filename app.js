"use strict"

var express = require('express');
var logger = require('morgan');
var bodyParser = require('body-parser');

var authenticator = require('./routes/authenticate');
var user = require('./routes/user');
var product = require('./routes/product');
var retail = require('./routes/retail');

var app = express();
var server = require('http').Server(app);
var io = require('socket.io')(server);

io.on('connection', function(socket){
  console.log("User connected...");
  socket.emit("hello", { text: "yo dude!"});
});

app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

app.use(function(req, res, next){
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept, token");
  res.header("Access-Control-Allow-Methods", "POST, GET");
  next();
});

app.use('/api/login', authenticator);
app.use('/api/user', user);
app.use('/api/product', product);
app.use('/api/retail', retail);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.json({
      message: err.message,
      error: err
    });
  });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.json({
    message: err.message,
    error: err
  });
});

server.listen(3000, function(){
  console.log("Listening on 3000...");
});

module.exports = app;