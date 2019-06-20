const express = require('express');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const app = express();
const conn = require('./connection.js');
const mailer = require('./mailer.js');

const propertiesRouter = require('./models/properties');
const weeksRouter = require('./models/weeks.js');
const convertAccountsRouter = require('./models/convertAccounts.js');

const bodyParser = require('body-parser');
app.use(bodyParser.json()); // support json encoded bodies
app.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies

app.use(function (req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  res.header('Access-Control-Allow-Methods', '*');
  next();
});

app.use('/properties',propertiesRouter);
app.use('/weeks',weeksRouter);
app.use('/',convertAccountsRouter);

//Ruta de prueba
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

app.get('/images/:id', (req, res) => {
  var sql="SELECT images.image FROM images WHERE images.idproperty="+req.params.id;
  conn.query(sql, function(err, result){
    res.send(result);
  });
})

app.post('/checkWinner', function(req,res){
  var sql= "SELECT * FROM bookings b INNER JOIN bids bi ON (bi.id = b.idMaxBid) INNER JOIN weeks w ON (w.id=bi.idWeek) WHERE w.date='"+ req.body.data.date +"' AND bi.email='"+req.body.data.winner+"'";
  conn.query(sql,function (err,result){
    if (result.length==0){
      res.status(200).send({data:false});
    }else{
      res.status(200).send({data:true});
    }
  })
})

app.post('/makeReservation',function(req,res){
  var sql= "INSERT INTO bookings (idMaxBid) VALUES ('"+req.body.data.id+"')";
  conn.query(sql,function(err, result){
    mailer.sendEmail(req.body.data.email,'Reserva confirmada para la propiedad '+req.body.data.propertyName,'Usted esta recibiendo este e-mail porque su reserva para la propiedad '
      	  +req.body.data.propertyName+' de la semana del '+req.body.data.date.substring(0,10)+' fue confirmada. Gracias por confiar en nosotros. Disfrute su estadía.');
    res.send(result);
  })
})

app.get('/deleteBid/:winner',function(req,res){
  var sql= "DELETE FROM bids WHERE id="+req.params.winner;
  conn.query(sql,function(err, result){
    res.send(result);
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
    var sql = "SELECT * FROM users us WHERE us.email='"+req.body.data.email+"'";
    conn.query(sql, function (err, result) {
      console.log(result);
      if(result[0]==null){
        console.log(req.body.data);
        sql = "INSERT INTO users (email,password,name,surname,birthday,card_number,card_expiration_month,card_expiration_year,card_security_number) VALUES ('" + req.body.data.email + "','" + contraseña + "','" + req.body.data.name + "','" + req.body.data.surname + "','" + new Date(req.body.data.birthday).toLocaleDateString() + "','" + req.body.data.cardNumber + "','" + req.body.data.cardExpirationDate.month + "','" + req.body.data.cardExpirationDate.year + "','" + req.body.data.cardSecurityNumber + "')";
        console.log(sql);
        conn.query(sql, function (err, result) {
          if (err) throw err;
          res.status(200).send(result);
        });
      }else{
        res.sendStatus(409);
      }      
    });
  });

  app.get('/bookings', function (req, res) {
    var sql="SELECT w.date,p.name,b.email,b.price FROM bookings book INNER JOIN bids b ON (book.idMaxBid=b.id) INNER JOIN weeks w ON (w.id=b.idWeek) INNER JOIN properties p ON (p.id=w.idProperty)"
    conn.query(sql, function (err, result) {
      if (err) throw err;
      res.send(result);
    });
  })

  app.post('/recoverPassword', function (req, res) {
    var sql="SELECT * FROM users u WHERE u.email='"+req.body.data.email+"'";
    conn.query(sql, function (err, result) {
      if(err) throw err;
      if(result[0]==null){
        res.sendStatus(409);
      } else {
        //CREAR TOKEN, POR AHORA SERA EL EMAIL (BUSCAR ALGORITMO)
        var token=createToken(10);
        mailer.sendEmail(req.body.data.email,'Recuperación de Contraseña','Por favor, haga click en el siguiente enlace para cambiar su contraseña: http://localhost:8080/recover_password/'+token);
        var sql="UPDATE users SET recover_password_token='"+token+"' WHERE email='"+req.body.data.email+"'";
        conn.query(sql, function (err, result) {
          if(err) throw err;
          res.status(200).send(result);
        })
      }
    })
  })

  app.post('/changePassword', function (req, res) {
    var sql="SELECT * FROM users u WHERE u.recover_password_token='"+req.body.data.token+"'";
    conn.query(sql, function (err, result) {
      if(err) throw err;
      if(result[0]==null){
        res.sendStatus(409);
      } else {
        //CAMBIO CONTRASEÑA
        var contraseña = bcrypt.hashSync(req.body.data.password, 8);
        var sql="UPDATE users SET password='"+contraseña+"',recover_password_token='' WHERE recover_password_token='"+req.body.data.token+"'";
        conn.query(sql, function (err, result) {
          if(err) throw err;
          res.status(200).send(result);
        })
      }
    })
  })

  app.post('/tokenExists', function (req, res) {
    var sql="SELECT * FROM users u WHERE u.recover_password_token='"+req.body.data.token+"'";
    conn.query(sql, function (err, result) {
      if(err) throw err;
      if(result[0]==null){
        res.sendStatus(409);
      }else{
        res.sendStatus(200);
      }
    })
  })

  function createToken(length) {
    var result           = '';
    var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var charactersLength = characters.length;
    for ( var i = 0; i < length; i++ ) {
       result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
 }
 app.get('/chargeSubscription',function(req,res){
  var sql= "SELECT * FROM users WHERE role<2";
  conn.query(sql,function(err, result){
    var total = 0;
    var actual = new Date().toISOString();
    var previous = new Date()
    previous.setMonth(previous.getMonth()+1);
    result.forEach(element => {
      if (previous<=actual){
        if (element.role == 1){
          total = total + 5000 
        } else {
          total = total + 3000
        }
        var sql2 = "UPDATE users SET last_charge='"+ actual +"'WHERE id ='"+ element.id+"'";
        conn.query(sql2,function(err, result){
        })
        // mailer.sendEmail(element.email,'Cobro de suscripción','Se le ha cobrado la suscripción este mes. Gracias por confiar en nosotros.');
      }
    });
    
    res.status(200).send({data:total});
    
  })
})
  

  app.listen(3000, function () {
    console.log('Example app listening on port 3000!');
  });

