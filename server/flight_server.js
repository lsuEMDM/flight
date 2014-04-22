var connect = require('connect'),
    http = require('http'),
    app = connect().use(connect.static(__dirname)).listen(8080),
    io = require('socket.io').listen(app);
    console.log("http server on 8080");


io.sockets.on('connection', function (socket) {
    socket.on('fromwebsite', function (data) {
      socket.broadcast.emit("fromserver", data);
      console.log(data);
    });
});