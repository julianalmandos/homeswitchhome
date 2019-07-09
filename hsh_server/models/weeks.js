const express = require('express');
const conn = require('../connection.js');
const app = express.Router();
const mailer = require('../mailer.js');

app.post('/:id/bid', function (req, res) {
  //BUSCO LA PUJA MAS ALTA PARA LA SEMANA Y ME QUEDO CON EL EMAIL DEL PUJANTE PARA MANDARLE UN AVISO
  var sql = "SELECT email,price FROM bids WHERE idWeek=" + req.params.id + ' AND price=(SELECT MAX(price) FROM bids WHERE idWeek='+req.params.id+')';
  conn.query(sql, function (err, result) {
    var maxPrice,maxEmail;
    if(result[0]){
      maxEmail=result[0]['email'];
      maxPrice = JSON.parse(JSON.stringify(result[0]['price']));
    }else{
      maxPrice = -1;
      maxEmail = '';
    }
    console.log(req.body.data.price, maxPrice, req.body.data.base_price)
    if (maxPrice < req.body.data.price && req.body.data.base_price < req.body.data.price) {
      //SI LA PUJA FUE MAYOR AL PRECIO BASE Y A LA ULTIMA PUJA, ENTONCES INSERTO LA NUEVA PUJA
      var sql = "INSERT INTO bids (price, idWeek, email) VALUES ('" + req.body.data.price + "','" + req.body.data.id + "','" + req.body.data.email + "')";
      conn.query(sql, function (err, result) {
        if (err)  throw err;
        //HAGO UNA CONSULTA PARA SABER LA PROPIEDAD}
        if(maxEmail!=''){
          var sql="SELECT p.name,p.id FROM properties p INNER JOIN weeks w ON (w.idProperty=p.id) WHERE w.id="+req.params.id;
          conn.query(sql, function(err, result){
            console.log('entra envio email');
            console.log(maxEmail);
            console.log(result);
            mailer.sendEmail(maxEmail,'Puja por "'+result[0]['name']+'" superada','Usted está recibiendo este e-mail porque su puja por la propiedad "'+result[0]['name']+'" fue superada. Para volver a pujar, puede ingresar a http://localhost:8080/details/'+result[0]['id']);
          })    
        }    
        res.send(result);
      });
    } else {
      console.log("Va por el else");
      res.status(401).send();
    }
  })
})

app.get('/:id/winner', function (req, res) {
  var sql = "SELECT * FROM bids WHERE idWeek='" + req.params.id +"'AND price=(SELECT MAX(price) FROM bids WHERE idWeek='" + req.params.id+"')";
  conn.query(sql, function (err, result) {
    if (err) throw err;
    res.send(result);
  });
})

app.get('/:id/maxbid', function (req, res) {
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

app.get('/:id', (req, res) => {
  var actualDate= new Date();
  var sql = "SELECT * FROM weeks WHERE weeks.idproperty='" + req.params.id+ "' AND weeks.date>'"+ actualDate.toISOString().substring(0,10) +"' ORDER BY weeks.date";
  conn.query(sql, function (err, result) {
    res.send(result);
  });
})



module.exports = app;