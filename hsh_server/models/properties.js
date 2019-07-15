const express = require('express');
const conn = require('../connection.js');
const app = express.Router();
const mailer = require('../mailer.js');

app.get('/', (req, res) => {
  var sql = "SELECT p.id, p.name, p.description, p.address, p.base_price, l.name AS locality, pr.name AS province, c.name AS country FROM properties p INNER JOIN localities l ON (l.id=p.idLocality) INNER JOIN provinces pr ON (pr.id=l.idProvince) INNER JOIN countries c ON (c.id=pr.idCountry)";
  conn.query(sql, function (err, result) {
    res.send(result);
  })
})

app.get('/random', (req, res) => {
  const quantity = req.query.quantity || 5;
  var sql = `SELECT p.id, p.name, p.description, p.address, p.base_price, l.name AS locality, pr.name AS province, c.name AS country FROM properties p INNER JOIN localities l ON (l.id=p.idLocality) INNER JOIN provinces pr ON (pr.id=l.idProvince) INNER JOIN countries c ON (c.id=pr.idCountry) ORDER BY RAND() LIMIT ${quantity}`;
  conn.query(sql, function (err, result) {
    res.send(result);
  })
})

app.post('/generateWeeks', (req, res) => {
      var fechaInicial = new Date();
      const sqlWeeks = `SELECT MAX(date) AS date FROM weeks WHERE idProperty=${req.body.data.id} AND date >= "${fechaInicial.toISOString().substring(0, 10)}"`;
      conn.query(sqlWeeks, function (err, result) {
        if (result[0].date==null) {//es igual a null creo
          fechaInicial.setMonth(fechaInicial.getMonth() + 12)
          while (fechaInicial.getDay() != 0) {
            fechaInicial.setDate(fechaInicial.getDate() - 1);
          }
          var sql2 = "INSERT INTO weeks (idProperty,date) VALUES (" + req.body.data.id + ",'" + fechaInicial.toISOString().substring(0, 10) + "')";
          conn.query(sql2, function (err, result) {
            if (err) throw err;
          });
          res.status(200).send(`${1}`)
        } else {
          var total = 0;
          fechaInicial.setMonth(fechaInicial.getMonth()+12);
          result[0].date.setDate(result[0].date.getDate()+7)
          while(result[0].date.toISOString().substring(0, 10)<fechaInicial.toISOString().substring(0, 10)){
            var sql2 = "INSERT INTO weeks (idProperty,date,auctionDate) VALUES (" + req.body.data.id + ",'" + result[0].date.toISOString().substring(0, 10) + "','" + new Date(0000, 00, 00).toISOString().substring(0, 10) + "')";
            conn.query(sql2, function (err, result) {
              if (err) throw err;
            });
            total+=1
            result[0].date.setDate(result[0].date.getDate()+7)
          }
          res.status(200).send(`${total}`)
        };
      });
    })
 

app.get('/openAuctions', (req, res) => {
  var finishDate = new Date();
  finishDate.setMonth(finishDate.getMonth() + 6);
  var startDate = new Date();
  startDate.setMonth(startDate.getMonth() + 6);
  startDate.setDate(startDate.getDate() - 3); 
  const sqlWeeks = `SELECT * FROM weeks WHERE auction=0 AND (date BETWEEN "${startDate.toISOString().substring(0, 10)}" AND "${finishDate.toISOString().substring(0, 10)}")`;
  conn.query(sqlWeeks, function (err, result) {
    result.forEach(function (week) {
      var actualDate = new Date();
      const sql = `UPDATE weeks w SET w.auction = 1, w.auctionDate="${actualDate.toISOString().substring(0, 10)}" WHERE id=${week.id}`
      conn.query(sql, function (err, result) {
        if (err) throw err;
      })
    })
    res.send(`${result.length}`)
  })
})

app.get('/:id', (req, res) => {
  var sql = "SELECT p.id, p.name, p.description, p.address, p.base_price, l.name AS locality, pr.name AS province, c.name AS country FROM properties p INNER JOIN localities l ON (l.id=p.idLocality) INNER JOIN provinces pr ON (pr.id=l.idProvince) INNER JOIN countries c ON (c.id=pr.idCountry) WHERE p.id=" + req.params.id;
  conn.query(sql, function (err, result) {
    res.send(result);
  })
})


app.post('/:id/delete', function (req, res) {
  var sql = "SELECT b.email, w.date, p.name, b.id, b.type, b.idWeek FROM properties p INNER JOIN weeks w ON (w.idProperty = p.id) INNER JOIN bookings b ON (b.idWeek = w.id) WHERE p.id=" + req.params.id
  conn.query(sql, function (err, result) {
    result.forEach(function(element){
      mailer.sendEmail(element.email,`Cancelación de reserva`,`Se canceló la reserva de la semana ${element.date.toISOString().substring(0,10)} de la propiedad ${element.name}`);
      var sql = `UPDATE favorites SET active = 0 WHERE week_id = ${element.idWeek}`
      conn.query(sql, function (err, result3) {
        if (err) throw err;
      })
    })
    var sqlRemove = "DELETE FROM properties WHERE id=" + req.params.id;
      conn.query(sqlRemove, function (err, result2) {
        if (err) throw err;
      })
    res.send(result)
  })
 })


app.get('/:id/bookings', function (req, res) {
  var sql = "SELECT * FROM properties p INNER JOIN weeks w ON (p.id = w.idProperty) WHERE p.id='" + req.params.id + "' AND w.reserved=1";
  conn.query(sql, function (err, result) {
    if (result.length == 0) {
      res.status(200).send({ data: false });
    } else {
      res.status(200).send({ data: true });
    }
  })
})

app.post('/', function (req, res) {
  var sql = "SELECT * FROM properties p INNER JOIN localities l ON (l.id=p.idLocality) INNER JOIN provinces pr ON (pr.id=l.idProvince) WHERE l.name='"+req.body.data.locality+"' AND pr.name='"+req.body.data.province+"' AND p.name='"+req.body.data.name+"'";
  conn.query(sql, function (err, result) {
    if(result.length == 0){
      sql = "SELECT l.id FROM localities l INNER JOIN provinces p ON (l.idProvince=p.id) INNER JOIN countries c ON (p.idCountry=c.id) WHERE p.name='"+req.body.data.province+"' AND c.name='"+req.body.data.country+"' AND l.name='"+req.body.data.locality+"'"
      conn.query(sql, function (err, result) {
        sql = "INSERT INTO properties (name,description,address,base_price,idLocality) VALUES ('" + req.body.data.name + "','" + req.body.data.description + "','" + req.body.data.address + "','" + req.body.data.base_price + "','" +result[0].id+ "')";
        conn.query(sql, function (err, result) {
        var idPropertyIm = result["insertId"];
        req.body.data.files.forEach(function (file) {
          var sqlIm = "INSERT INTO images (idProperty,image) VALUES ('" + idPropertyIm + "','" + file + "')";
          conn.query(sqlIm, function (err, result) {
            if (err) throw err;
          });
        })
        res.send(result)
      });
    });
    }else{
      res.sendStatus(409);
    } 
  })
})

app.post('/:id/edit', function (req, res) {
  var sql = "SELECT * FROM properties p WHERE p.locality='" + req.body.data.property.locality + "' AND p.province='" + req.body.data.property.province + "' AND p.name='" + req.body.data.property.name + "'";
  conn.query(sql, function (err, result) {
    if (result.length == 0 || (result.length == 1 && result[0].id == req.body.data.property.id)) {
      console.log("acata")
      if (req.body.data.property.description !== "" && req.body.data.property.description !== undefined) {
        var sql = "UPDATE properties p SET p.description = '" + req.body.data.property.description + "',p.name = '" + req.body.data.property.name + "',p.base_price = '" + req.body.data.property.base_price + "',p.locality = '" + req.body.data.property.locality + "',p.country = '" + req.body.data.property.country + "',p.province= '" + req.body.data.property.province + "'  WHERE p.id='" + req.params.id + "'";
        conn.query(sql, function (err, result) {

        });
      }
      if ((req.body.data.files).length > 0) {
        var sqlIm = "DELETE FROM images WHERE idProperty =" + req.params.id
        conn.query(sqlIm, function (err, result) {
          console.log("borre")
        });
        req.body.data.files.forEach(function (file) {
          if ((file !== undefined) && (file !== "") && (file !== null)) {
            var sqlIm = "INSERT INTO images (idProperty,image) VALUES ('" + req.params.id + "','" + file + "')";
            conn.query(sqlIm, function (err, result) {
              if (err) throw err;

            })
          }
        })
      }
      res.sendStatus(200);
    } else {
      res.sendStatus(409);
    }
  });
})


module.exports = app;