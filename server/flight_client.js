var osc = require('node-osc'),
    client = new osc.Client('localhost', 4040);   
    console.log("socket.io client connected, osc client on 4040");

var ioclient = require('socket.io-client').connect("http://localhost:8080");
ioclient.on('connect', function () { 
  console.log("socket connected"); 
  ioclient.on('fromserver', function (data) {
    client.send(data.oscname, data.val);
    console.log(data);
  });
});