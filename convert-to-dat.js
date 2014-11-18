// Make a simple newline json file that's useful for importing into npmjs.org/dat
var fs = require('fs');

var basedir = './raw_data';

var output = process.argv[2] || __dirname + '/output.nljson';


fs.readdir(basedir, function (err, files) {
    files.forEach(function (file) {
        var content = fs.readFileSync(basedir + '/' + file);
        var json = JSON.parse(content);
        delete json.requestResponses;
        var str = JSON.stringify(json) + '\n';
        fs.appendFileSync(output, str);
    });
});
