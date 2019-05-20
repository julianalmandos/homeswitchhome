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

var transporter = nodemailer.createTransport({
  service: 'Gmail',
  auth: {
    user: 'homeswitchhome23@gmail.com',
    pass: 'grupoing23'
  }
});

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


app.post('/properties/:id/delete', function (req, res){
  var sql = "SELECT * FROM properties p WHERE id=" + req.params.id + " AND NOT EXISTS (SELECT * FROM weeks w WHERE w.idProperty=p.id AND w.reserved=1)"
  conn.query(sql, function(err, result){
    if (err) throw err;
    console.log(result);
    if (result.length > 0){
      var sqlRemove = "DELETE FROM properties WHERE id=" + req.params.id;
      conn.query(sqlRemove, function(err, result){
        if (err) throw err;
        res.send(result);
      })
    }
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
  //BUSCO LA PUJA MAS ALTA PARA LA SEMANA Y ME QUEDO CON EL EMAIL DEL PUJANTE PARA MANDARLE UN AVISO
  var sql = "SELECT email,price FROM bids WHERE idWeek=" + req.params.id + ' AND price=(SELECT MAX(price) FROM bids WHERE idWeek='+req.params.id+')';
  conn.query(sql, function (err, result) {
    var maxEmail=result[0]['email'];
    var maxPrice = JSON.parse(JSON.stringify(result[0]['price']));
    if (maxPrice === null) {
      maxPrice = -1;
    }
    else { };
    console.log(req.body.data.price, maxPrice, req.body.data.base_price)
    if (maxPrice < req.body.data.price && req.body.data.base_price < req.body.data.price) {
      //SI LA PUJA FUE MAYOR AL PRECIO BASE Y A LA ULTIMA PUJA, ENTONCES INSERTO LA NUEVA PUJA
      var sql = "INSERT INTO bids (price, idWeek, email) VALUES ('" + req.body.data.price + "','" + req.body.data.id + "','" + req.body.data.email + "')";
      conn.query(sql, function (err, result) {
        if (err)  throw err;
        //HAGO UNA CONSULTA PARA SABER LA PROPIEDAD}
        var sql="SELECT p.name,p.id FROM properties p INNER JOIN weeks w ON (w.idProperty=p.id) WHERE w.id="+req.params.id;
        conn.query(sql, function(err, result){
          console.log('entra envio email');
          console.log(maxEmail);
          console.log(result);
          sendEmail(maxEmail,'Puja por "'+result[0]['name']+'" superada','Usted está recibiendo este e-mail porque su puja por la propiedad "'+result[0]['name']+'" fue superada. Para volver a pujar, puede ingresar a http://localhost:8080/details/'+result[0]['id']);
        })        
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

function sendEmail(to,subject,text){
  console.log("Estoy mandando el mail");
  // Definimos el email
  var mailOptions = {
    from: 'homeswitchhome23@gmail.com',
    to: to,
    subject: subject,
    text: text
  };
  // Enviamos el email
  transporter.sendMail(mailOptions, function (error, info) {
    if (error) {
      return error;
    } else {
      return 0;
    }
  });
}

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

app.post('/properties/:id/edit', function (req, res) {
  if (req.body.data.description !== "" && req.body.data.description !== undefined) {
  var sql = "UPDATE properties p SET p.description = '" + req.body.data.description + "' WHERE p.id=" + req.params.id;
  conn.query(sql, function (err, result) {

  });
  }
  if ((req.body.data.files).length>0){
  var sqlIm = "DELETE FROM images WHERE idProperty ="  + req.params.id 
    conn.query(sqlIm, function (err, result) {
      console.log("borre")
  });
  req.body.data.files.forEach(function (file) {
    if ((file !== undefined)&&(file !== "")&&(file!==null)) {
      var sqlIm = "INSERT INTO images (idProperty,image) VALUES ('" + req.params.id + "','" + file + "')";
      conn.query(sqlIm, function (err, result) {
        if (err) throw err;

      })
    }
  })
  
}
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

  app.listen(3000, function () {
    console.log('Example app listening on port 3000!');
  });

