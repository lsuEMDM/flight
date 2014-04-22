
var connect = require('connect'),
    http = require('http'),
    osc = require('node-osc'),
    client = new osc.Client('localhost', 4040);   
    console.log("http server on 8080, osc client on 4040");

var ioc = require('socket.io-client').connect("http://localhost:8080");
ioc.on('connect', function () { 
  console.log("socket connected"); 
  ioc.on('fromwebsite', function (data) {
    client.send(data.oscname, data.val);
    console.log(data);
  });
});
ioc.emit('private message', { user: 'me', msg: 'whazzzup?' });