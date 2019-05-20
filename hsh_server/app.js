var express = require('express');
var mysql = require('mysql');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const nodemailer = require('nodemailer');
var app = express();
var conn = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'hsh'
});

var bodyParser = require('body-parser');
app.use(bodyParser.json()); // support json encoded bodies
app.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies

app.use(function (req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  res.header('Access-Control-Allow-Methods', '*');
  next();
});

app.get('/', function (req, res) {
  var sql = "SELECT * FROM users";
  conn.query(sql, function (err, result) {
    if (err) throw err;
    res.send(result);
  });
});

app.post('/login', (req, res) => {
  console.log(req.body.data);
  var sql = "SELECT * FROM users us WHERE us.email='" + req.body.data.email + "'";
  conn.query(sql, function (err, result) {
    console.log(result);
    if (err) throw err;
    if (result[0] == null) {
      console.log('entra');
      return res.status(401).send('Ese e-mail no se encuentra registrado.');
    } else {
      let contraseñaValida = bcrypt.compareSync(req.body.data.password, result[0].password);
      //let contraseñaValida=result[0].password==req.body.data.password;
      if (!contraseñaValida) {
        return res.status(401).send({ auth: false, token: null, msg: 'Contraseña incorrecta.' });
      }
      let token = jwt.sign({ id: result[0].id }, 'shhhhh', {
        expiresIn: 86400 // 10 minutos de sesión
      });
      console.log(token);
      res.status(200).send({ auth: true, token: token, user: result[0] });
    }
  });
})

app.get('/properties', (req, res) => {
  var sql = "SELECT * FROM properties prop";
  conn.query(sql, function (err, result) {
    res.send(result);
  })
})

app.get('/properties/:id', (req, res) => {
  var sql = "SELECT * FROM properties prop WHERE prop.id=" + req.params.id;
  conn.query(sql, function (err, result) {
    res.send(result);
  })
})

app.post('/properties/:id/edit', function (req, res) {
  console.log(req.body.data.description)
  var sql = "UPDATE properties p SET p.description = '" + req.body.data.description + "' WHERE p.id=" + req.params.id;
  console.log(sql);
  conn.query(sql, function (err, result) {
    if (err) throw err;
    res.send(result);
  });
})

app.get('/properties/:id/delete', function (req, res){
  var sql = "SELECT * FROM properties p WHERE id=" + req.params.id + " AND NOT EXISTS (SELECT * FROM weeks w WHERE w.idProperty=p.id AND w.reserved=1)"
  conn.query(sql, function(err, result){
    if (err) throw err;
    console.log(result);
    if (result.length > 0){
      var sqlRemove = "DELETE FROM properties WHERE id=" + req.params.id;
      conn.query(sqlRemove, function(err, result){
        if (err) throw err;
      })
    }
    res.send(result);
  })
})

app.get('/weeks/:id', (req, res) => {
  var sql = "SELECT * FROM weeks WHERE weeks.idproperty=" + req.params.id;
  conn.query(sql, function (err, result) {
    res.send(result);
  });
})

app.get('/images/:id', (req, res) => {
  var sql="SELECT images.image FROM images WHERE images.idproperty="+req.params.id;
  conn.query(sql, function(err, result){
    res.send(result);
  });
})

app.get('/week/:id/maxbid', function (req, res) {
  var sql = "SELECT MAX(price) FROM bids WHERE idWeek=" + req.params.id;
  var pepe;
  conn.query(sql, function (err, result) {
    if (err) throw err;
    pepe = JSON.parse(JSON.stringify(result[0]['MAX(price)']));
    if(pepe==null){ 
      var sql = "SELECT p.base_price FROM weeks w INNER JOIN properties p ON (w.idProperty=p.id) WHERE w.id=" + req.params.id;
      conn.query(sql, function (err, result) {
        res.status(200).send({data: result[0].base_price});
      })
    } else {
      console.log(result);
      res.status(200).send({ data: pepe });
    }
  });
})

app.post('/week/:id/bid', function (req, res) {
  var sql = "SELECT (MAX(price)) FROM bids WHERE idWeek=" + req.params.id;
  conn.query(sql, function (err, result) {
    var pepe = JSON.parse(JSON.stringify(result[0]['(MAX(price))']));
    if (pepe === null) {
      pepe = -1;
    }
    else { };
    console.log(req.body.data.price, pepe, req.body.data.base_price)
    if (pepe < req.body.data.price && req.body.data.base_price < req.body.data.price) {
      var sql = "INSERT INTO bids (price, idWeek, email) VALUES ('" + req.body.data.price + "','" + req.body.data.id + "','" + req.body.data.email + "')";
      conn.query(sql, function (err, result) {
        if (err)  throw err;
        res.send(result);
      });
    } else {
      console.log("Va por el else");
      res.status(401).send();
    }
  })
})

app.get('/openAuction/:id', (req, res) => {
  var sql = "UPDATE weeks SET weeks.auction = 1 WHERE weeks.id=" + req.params.id;
  conn.query(sql, function (err, result) {
    res.send(result);
  })
})

app.post('/closeAuction/:id', (req, res) => {
  var sql="UPDATE weeks SET weeks.auction = 0, weeks.reserved ='"+ req.body.data.reserved +"', weeks.idle='"+req.body.data.idle +"'WHERE weeks.id="+req.params.id;
  conn.query(sql, function(err, result){
    res.send(result);
  })
})

app.get('/pepe', (req, res) => {
  exports.sendEmail = function (req, res) {
    // Definimos el transporter
    var transporter = nodemailer.createTransport({
      service: 'Gmail',
      auth: {
        user: 'orianarevalos@gmail.com',
        pass: 'Milanesaconpure12'
      }
    });
    console.log("Estoy mandando el mail");
    // Definimos el email
    var mailOptions = {
      from: 'orianarevalos@gmail.com',
      to: 'orianarevalos@gmail.com',
      subject: 'Subastas',
      text: 'Contenido del email'
    };
    // Enviamos el email
    transporter.sendMail(mailOptions, function (error, info) {
      if (error) {
        console.log(error);
        res.send(500, err.message);
      } else {
        console.log("Email sent");
        res.status(200).jsonp(req.body);
      }
    });
  };
  console.log("Enviando");
  res.send("hola")
})

app.post('/properties/publish', function (req, res) {
  console.log(req.body.data)
  var sql = "INSERT INTO properties (name,description,address,base_price,country,province,locality) VALUES ('" + req.body.data.name + "','" + req.body.data.description + "','" + req.body.data.address + "','" + req.body.data.base_price + "','" + req.body.data.country + "','" + req.body.data.province + "','" + req.body.data.locality + "')";
  var sqlIm;
  conn.query(sql, function (err, result) {
    console.log(result["insertId"]);
    console.log("aqui") 
    var idPropertyIm = result["insertId"];
    console.log(idPropertyIm);
    req.body.data.files.forEach(function (file) {
      console.log(file);
      var sqlIm = "INSERT INTO images (idProperty,image) VALUES ('" + idPropertyIm + "','" + file + "')";
      conn.query(sqlIm, function (err, result) {
        if (err) throw err; 
      });
    })
    res.send(result)
  });
})

  app.post('/validatetoken', (req, res) => {
    try {
      var decoded = jwt.verify(req.body.token, 'shhhhh');
      res.send(true);
    } catch (err) {
      res.send(false);
    }
  })

  app.post('/register', function (req, res) {
    //console.log(req.body.data);
    var contraseña = bcrypt.hashSync(req.body.data.password, 8);
    //falta chequear si el email ya existe
    var sql = "INSERT INTO users (email,password,name,surname) VALUES ('" + req.body.data.email + "','" + contraseña + "','" + req.body.data.name + "','" + req.body.data.surname + "')";
    console.log(sql);
    conn.query(sql, function (err, result) {
      if (err) throw err;
      res.send(result);
    });
  });

  app.get('/bookings', function (req, res) {
    var sql="SELECT w.date,p.name,b.email,b.price FROM bookings book INNER JOIN bids b ON (book.idMaxBid=b.id) INNER JOIN weeks w ON (w.id=b.idWeek) INNER JOIN properties p ON (p.id=w.idProperty)"
    conn.query(sql, function (err, result) {
      if (err) throw err;
      res.send(result);
    });
  })

  app.listen(3000, function () {
    console.log('Example app listening on port 3000!');
  });

