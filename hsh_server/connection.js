var mysql = require('mysql');

var conn = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'hsh'
});

module.exports = conn;