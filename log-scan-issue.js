var WebSocket = require('ws');
var crypto = require('crypto');
var fs = require('fs');

var ws = new WebSocket('ws://localhost:8000/');

ws.on('open', function () {
    console.log('opened connection to ws://localhost:8000/');
});

ws.on('message', function (data, flags) {
    var filename = __dirname + "/data/" + crypto.randomBytes(12).toString('hex') + ".json";

    var obj = JSON.parse(data);
    if (obj.messageType === 'scanIssue') {
        fs.writeFileSync(filename, JSON.stringify(obj, null, 4));
        console.log(obj.name);
    }
});

ws.on('error', function (err) {
    console.log(err);
});
