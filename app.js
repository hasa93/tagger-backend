"use strict"

var express = require('express');
var logger = require('morgan');
var path = require('path');
var bodyParser = require('body-parser');
var uploader = require('./uploader');

var authenticator = require('./routes/authenticate');
var user = require('./routes/user');
var product = require('./routes/product');
var retail = require('./routes/retail');
var messageQueue = require('./messages');

var app = express();
var server = require('http').Server(app);
var io = require('socket.io')(server);
var appRouter = express.Router();

io.on('connection', function(socket){
  console.log("User connected...");
  socket.emit("hello", { text: "yo dude!"});

  socket.on('CASHIER_LOGGED_IN', function(msg){
      console.log("Cahier login event...");
      console.log(msg);
      messageQueue.addToMessageQueue(msg.branchName, { type: "LOGIN", uname: msg.uname });
      io.emit('UPDATE_MESSAGES', "Update Message Feeds");
  });

  socket.on('GET_MESSAGES', function(branch){
    socket.emit('BRANCH_MESSAGES', messageQueue.getMessageQueue(branch.branchName));
  });

});


app.set('view engine', 'jade');
app.set('views', path.join(__dirname, 'views'));

app.use(logger('dev'));
app.use(bodyParser.json());

app.use(express.static(path.join(__dirname,'public')));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static('thumbs'));

app.use(function(req, res, next){
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Content-Type, token");
  res.header("Access-Control-Allow-Methods", "POST, GET");
  next();
});

app.use('/api/login', authenticator);
app.use('/api/user', user);
app.use('/api/product', product);
app.use('/api/retail', retail);
app.use('/api', appRouter);

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