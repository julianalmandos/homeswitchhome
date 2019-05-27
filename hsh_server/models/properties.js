const express = require('express');
const conn = require('../connection.js');
const app = express.Router();

app.get('/', (req, res) => {
  var sql = "SELECT * FROM properties prop";
  conn.query(sql, function (err, result) {
    res.send(result);
  })
})

app.get('/:id', (req, res) => {
  var sql = "SELECT * FROM properties prop WHERE prop.id=" + req.params.id;
  conn.query(sql, function (err, result) {
    res.send(result);
  })
})


app.post('/:id/delete', function (req, res){
  var sql = "SELECT * FROM properties p WHERE id=" + req.params.id + " AND NOT EXISTS (SELECT * FROM weeks w WHERE w.idProperty=p.id AND w.reserved=1)"
  conn.query(sql, function(err, result){
    if (result.length > 0){
      var sqlRemove = "DELETE FROM properties WHERE id=" + req.params.id;
      conn.query(sqlRemove, function(err, result){
        if (err) throw err;
        res.send(result);
      })
    }else{
      res.sendStatus(400);
    }
  })
})

app.get('/:id/bookings', function(req,res){
  var sql= "SELECT * FROM properties p INNER JOIN weeks w ON (p.id = w.idProperty) WHERE p.id='"+ req.params.id +"' AND w.reserved=1";
  conn.query(sql,function (err,result){
    if (result.length==0){
      res.status(200).send({data:false});
    }else{
      res.status(200).send({data:true});
    }
  })
})

app.post('/', function (req, res) {
  console.log(req.body.data)
  var sql = "INSERT INTO properties (name,description,address,base_price,country,province,locality) VALUES ('" + req.body.data.name + "','" + req.body.data.description + "','" + req.body.data.address + "','" + req.body.data.base_price + "','" + req.body.data.country + "','" + req.body.data.province + "','" + req.body.data.locality + "')";
  var sqlIm;
  conn.query(sql, function (err, result) {
    console.log(result);
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
    var fechaInicial=new Date()
    while(fechaInicial.getDay()!=0){
      console.log('entra');
      fechaInicial.setDate(fechaInicial.getDate() + 1);
    }
    for(var i=0;i<12;i++){
      var sql="INSERT INTO weeks (idProperty,date,auction,reserved,idle) VALUES ('"+idPropertyIm+"','"+fechaInicial.toISOString().substring(0,10)+"',0,0,0)";
      conn.query(sql, function (err, result) {
        if (err) throw err; 
      });
      fechaInicial.setDate(fechaInicial.getDate() + 7);
    }
    res.send(result)
  });
})

app.post('/:id/edit', function (req, res) {
  console.log("acata")
  if (req.body.data.property.description !== "" && req.body.data.property.description !== undefined) {
  var sql = "UPDATE properties p SET p.description = '" + req.body.data.property.description + "',p.name = '" + req.body.data.property.name + "',p.base_price = '" + req.body.data.property.base_price + "',p.locality = '" + req.body.data.property.locality + "',p.country = '" + req.body.data.property.country + "',p.province= '" + req.body.data.property.province + "'  WHERE p.id='" + req.params.id+"'";
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

module.exports = app;