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

app.get('/users', function (req, res) {
  var sql = "SELECT * FROM users";
  conn.query(sql, function (err, result) {
    if (err) throw err;
    res.send(result);
  });
});

app.post('/login', (req, res) => {
  var sql = "SELECT * FROM users us WHERE us.email='" + req.body.data.email + "'";
  conn.query(sql, function (err, result) {
    if (err) throw err;
    if (result[0] == null) {
      return res.status(401).send('Ese e-mail no se encuentra registrado.');
    }else if (result[0].disabled==1){
      return res.status(401).send('Esa cuenta se encuentra deshabilitada.');
    } else {
      let contraseñaValida = bcrypt.compareSync(req.body.data.password, result[0].password);
      //let contraseñaValida=result[0].password==req.body.data.password;
      if (!contraseñaValida) {
        return res.status(401).send({ auth: false, token: null, msg: 'Contraseña incorrecta.' });
      }
      let token = jwt.sign({ id: result[0].id }, 'shhhhh', {
        expiresIn: 86400 // 10 minutos de sesión
      });
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

app.post('/profile/edit', (req, res) => {
  if (req.body.data.newPassword==''){
    var sql="UPDATE users SET card_number="+ req.body.data.card_number+", card_security_number="+req.body.data.card_security_number+", card_expiration_month="+ req.body.data.card_expiration_month+", card_expiration_year="+req.body.data.card_expiration_year+", card_type='"+req.body.data.card_type+"' WHERE id="+req.body.data.userid;
    conn.query(sql, function(err, result){
      res.send(result);
    })
  }else{
    var contraseña = bcrypt.hashSync(req.body.data.newPassword, 8);
    console.log(contraseña)
    var sql1="UPDATE users SET password='"+contraseña+"', card_number='"+ req.body.data.card_number+"', card_security_number='"+req.body.data.card_security_number+"', card_expiration_month='"+ req.body.data.card_expiration_month+"', card_expiration_year='"+req.body.data.card_expiration_year+"', card_type='"+req.body.data.card_type+"' WHERE id="+req.body.data.userid;
    conn.query(sql1, function(err, result){
      res.send(contraseña);
      
    })
  };
  
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
        console.log(new Date().toISOString());
        sql = "INSERT INTO users (email,password,name,surname,birthday,card_type,card_number,card_expiration_month,card_expiration_year,card_security_number,role,credits,last_charge,register_date) VALUES ('" + req.body.data.email + "','" + contraseña + "','" + req.body.data.name + "','" + req.body.data.surname + "','" + new Date(req.body.data.birthday).toISOString().substring(0,10) + "','" + req.body.data.cardType + "','" + req.body.data.cardNumber + "','" + req.body.data.cardExpirationDate.month + "','" + req.body.data.cardExpirationDate.year + "','" + req.body.data.cardSecurityNumber + "',0,2,null,'"+new Date().toISOString().substring(0,10)+"')";
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
    var sql="SELECT w.date,p.name,book.email,book.price FROM bookings book INNER JOIN weeks w ON (w.id=book.idWeek) INNER JOIN properties p ON (p.id=w.idProperty) WHERE book.cancelled=0"
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

  app.post('/contact', function(req, res){
    mailer.sendEmail('homeswitchhome23@gmail.com','Mensaje de '+req.body.data.surname+', '+req.body.data.name,'E-Mail: '+req.body.data.email+' Mensaje: '+req.body.data.message);
    res.sendStatus(200);
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
   var normalPrice;
   var premiumPrice;
  var sql = "SELECT price FROM suscription_prices WHERE role=0";
  conn.query(sql, function (err, result) {
    if (err) throw err;
    normalPrice=result[0].price;
    console.log(normalPrice);
    sql = "SELECT price FROM suscription_prices WHERE role=1";
    conn.query(sql, function (err, result) {
      if (err) throw err;
      premiumPrice=result[0].price;
      console.log(premiumPrice);
      sql= "SELECT * FROM users WHERE role<2";
      conn.query(sql,function(err, result){
        var total = 0;
        var actual = new Date().toISOString().substring(0,10);
        var previous = new Date();
        previous.setMonth(previous.getMonth()-1);
        result.forEach(element => {
          if (element.last_charge==null || element.last_charge.toISOString()<=previous.toISOString()){
            if (element.role == 1){
              total = total + premiumPrice 
            } else {
              total = total + normalPrice 
            }
            mailer.sendEmail(element.email,'Cobro de suscripción','Se le ha cobrado la suscripción este mes. Gracias por confiar en nosotros.');
            var sql2 = "UPDATE users SET last_charge='"+ actual +"'WHERE id ='"+ element.id+"'";
            conn.query(sql2,function(err, result){
              if(err) throw err;
            })
            
          }
        });
        res.status(200).send({data:total});        
      })
    });
  });
})

  app.post('/bookingsOfUser', function (req, res) {
    var sql = `SELECT w.date, p.name, book.price, book.idWeek, book.id, book.type FROM bookings book INNER JOIN weeks w ON (w.id=book.idWeek) INNER JOIN properties p ON (p.id=w.idProperty) WHERE book.email="${req.body.data.email}" AND book.cancelled=0`
    conn.query(sql, function (err, result) {
      if (err) throw err;
      res.send(result);
    });
  })

  app.post('/bidsOfUser', function (req, res) { 
    var sql = `SELECT w.date, p.name, b.price FROM bids b INNER JOIN weeks w ON (w.id=b.idWeek) INNER JOIN properties p ON (p.id=w.idProperty) WHERE b.email="${req.body.data.email}"`
    conn.query(sql, function (err, result) {
      if (err) throw err; 
      res.send(result);
    });
  })
 app.get('/auctions', (req, res) => {
  var sql = "SELECT * FROM weeks WHERE weeks.auction = 1";
  conn.query(sql, function (err, result) {
    if (err) throw err;
    res.send(result);
  });
})

app.get('/countries', function (req,res){
  var sql = "SELECT name FROM countries"
  conn.query (sql, function (err,result){
    res.send(result)
  })
})

app.get('/allLocalities', function (req,res){
  var sql = "SELECT DISTINCT name FROM localities"
  conn.query (sql, function (err,result){
    res.send(result)
  })
})

app.get('/provinces/:country', function (req,res){
  var sql2 = "SELECT id FROM countries WHERE name='"+req.params.country+"'"
  conn.query(sql2, function(err,result){
    var sql = "SELECT name FROM provinces WHERE idCountry='"+result[0].id+"'";
    conn.query (sql, function (err,result){
      res.send(result)
    })
  })
})

app.get('/localities/:province/:country', function (req,res){
  var sql2 = "SELECT p.id FROM provinces p INNER JOIN countries c ON (c.id=p.idCountry) WHERE p.name='"+req.params.province+"' AND c.name='"+req.params.country+"'";
  conn.query(sql2, function(err,result){
    var sql = "SELECT name FROM localities WHERE idProvince='"+result[0].id+"'";
    conn.query (sql, function (err,result){
      res.send(result)
    })
  })
})

app.post('/country', function (req,res){
  var sql = "SELECT * FROM countries WHERE name='"+req.body.data.country+"'"
  conn.query (sql, function (err,result){
    if (result.length==0){
      var sql2 = "INSERT INTO countries (name) VALUES ('"+req.body.data.country+"')"
      conn.query(sql2, function(err,result){
        if (err) throw err;
        res.send(result);
      }) 
    }else{
      res.status(401).send();
    }
  })
})

app.post('/province', function (req,res){
  var sql = "SELECT * FROM provinces p INNER JOIN countries c ON (c.id=p.idCountry) WHERE c.name='"+req.body.data.country+"' AND p.name='"+req.body.data.province+"'"
  conn.query (sql, function (err,result){
    if (result.length==0){
      var sql2 = "SELECT id FROM countries WHERE name='"+req.body.data.country+"'"
      conn.query(sql2, function(err,result){
        var sql3 = "INSERT INTO provinces (name, idCountry) VALUES ('"+req.body.data.province+"',"+ result[0].id+")"
        conn.query(sql3, function(err,result){
         if (err) throw err;
         res.send(result);
        }) 
      })
    }else{
      res.status(401).send();
    }
  })
})

app.post('/locality', function (req,res){
  var sql = "SELECT * FROM localities l INNER JOIN provinces p ON (p.id=l.idProvince)  WHERE p.name='"+req.body.data.province+"' AND l.name='"+req.body.data.locality+"'";
  conn.query (sql, function (err,result){
    if (result.length==0){
      var sql2 = "SELECT p.id FROM provinces p INNER JOIN countries c ON (c.id=p.idCountry) WHERE p.name='"+req.body.data.province+"' AND c.name='"+ req.body.data.country+"'";
      conn.query(sql2, function(err,result){
        var sql3 = "INSERT INTO localities (name, idProvince) VALUES ('"+req.body.data.province+"',"+ result[0].id+")"
        conn.query(sql3, function(err,result){
         if (err) throw err;
         res.send(result);
        }) 
      })
    }else{
      res.status(401).send();
    }
  })
})
  app.get('/suscriptionPrices', (req, res) => {
    var sql = "SELECT * FROM suscription_prices ORDER BY role ASC";
    conn.query(sql, function (err, result) {
      if (err) throw err;
      console.log(result);
      res.send(result);
    });
  })

  app.post('/suscriptionPrices', (req, res) => {
    var sql = "UPDATE suscription_prices SET price="+req.body.data.normalPrice+" WHERE role=0";
    conn.query(sql, function (err, result) {
      if (err) throw err;
      var sql = "UPDATE suscription_prices SET price="+req.body.data.premiumPrice+" WHERE role=1";
      conn.query(sql, function (err, result) {
        if (err) throw err;
        res.sendStatus(200);
      });
    });
  })

  app.post('/searchAll', (req, res) => {
    var sql = "SELECT p.id, p.name, p.description, p.address, p.base_price, l.name AS locality, pr.name AS province, c.name AS country FROM properties p INNER JOIN localities l ON (p.idLocality=l.id) INNER JOIN provinces pr ON (pr.id=l.idProvince) INNER JOIN countries c ON (c.id=pr.idCountry) WHERE l.name='" + req.body.data.locality+"' AND EXISTS (SELECT * FROM weeks w WHERE w.date>'"+req.body.data.startDate+"' AND w.date<'"+req.body.data.finishDate+"'AND reserved=0 AND p.id=w.idProperty)";
    conn.query(sql, function (err, result) {
      res.send(result);
    })
  })
  app.post('/searchLocality', (req, res) => {
    var sql = "SELECT p.id, p.name, p.description, p.address, p.base_price, l.name AS locality, pr.name AS province, c.name AS country FROM properties p INNER JOIN localities l ON (p.idLocality=l.id) INNER JOIN provinces pr ON (pr.id=l.idProvince) INNER JOIN countries c ON (c.id=pr.idCountry) WHERE l.name='" + req.body.data.locality+"'";
    conn.query(sql, function (err, result) {
      res.send(result);
    })
  })
  app.post('/searchRange', (req, res) => {
    var sql = "SELECT p.id, p.name, p.description, p.address, p.base_price, l.name AS locality, pr.name AS province, c.name AS country FROM properties p INNER JOIN localities l ON (p.idLocality=l.id) INNER JOIN provinces pr ON (pr.id=l.idProvince) INNER JOIN countries c ON (c.id=pr.idCountry) WHERE EXISTS (SELECT * FROM weeks w WHERE w.date>'"+req.body.data.startDate+"' AND w.date<'"+req.body.data.finishDate+"' AND reserved=0 AND p.id=w.idProperty)";
    conn.query(sql, function (err, result) {
      res.send(result);
    })
  })
  app.post('/cancelBooking', (req,res)=> {
    var sql = "UPDATE weeks SET reserved=0 WHERE id="+ req.body.data.booking.idWeek;
    conn.query(sql,function (err,result){
      if (err) throw err; 
    })
    if (req.body.data.booking.type == 0 || req.body.data.booking.type == 1){
      var sql2 = "UPDATE users SET credits=credits + 1 WHERE email='"+ req.body.data.email+"'";
    conn.query(sql2,function (err,result){
      if (err) throw err; 
    })
    }
    var sql1 = "UPDATE bookings SET cancelled=1 WHERE id="+ req.body.data.booking.id;
    conn.query(sql1,function (err,result){
      if (err) throw err; 
      res.send(result)
    })
   
    
  })

  app.post('/disableUser', (req,res)=> {
    var sql = "UPDATE users SET disabled=1 WHERE email='"+ req.body.data.email+"'";
    conn.query(sql,function (err,result){
      if (err) throw err; 
      res.send(result)
    })
  })

  app.post('/addFavorite', (req, res) => {
    var sql = "SELECT * FROM favorites WHERE user_id="+req.body.data.userId+" AND week_id="+req.body.data.weekId+" AND active=1";
    conn.query(sql, function (err, result) {
      if (err) throw err;
      if(result.length==0){
        sql = "INSERT INTO favorites (user_id,week_id,active) VALUES ("+req.body.data.userId+","+req.body.data.weekId+",1)";
        console.log(sql);
        conn.query(sql, function (err, result) {
          if (err) throw err;
          res.sendStatus(200);
        })
      }else{
        res.sendStatus(401);
      }      
    });
  })

  app.post('/deleteFavorite', (req, res) => {
    var sql = "UPDATE favorites SET active=0 WHERE user_id="+req.body.data.userId+" AND week_id="+req.body.data.weekId+" AND active=1";
    console.log(sql);
    conn.query(sql, function (err, result) {
      if (err) throw err;
      res.sendStatus(200);
    })
  })

  app.get('/getFavorites/:userId', (req, res) => {
    var sql = "SELECT * FROM favorites f INNER JOIN weeks w ON(w.id=f.week_id) INNER JOIN properties p ON (p.id=w.idProperty) WHERE user_id="+req.params.userId+" AND active=1";
    conn.query(sql, function (err, result) {
      if (err) throw err;
      res.send(result);
    });
  })  



  app.listen(3000, function () {
    console.log('Example app listening on port 3000!');
  });

