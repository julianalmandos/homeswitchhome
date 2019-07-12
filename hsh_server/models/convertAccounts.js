const express = require('express');
const conn = require('../connection.js');
const app = express.Router();

app.post('/convertToPremium', (req, res) => {
  var sql = "SELECT * FROM premium_requests WHERE user_id=" + req.body.data.userId + " AND accepted=0";
  conn.query(sql, function (err, result) {
    if (result[0] == null) {
      var sql = "INSERT INTO premium_requests (user_id,comment) VALUES (" + req.body.data.userId + ",'" + req.body.data.comment + "')";
      conn.query(sql, function (err, result) {
        if (err) throw err;
        res.status(200).send(result);
      });
    } else {
      res.sendStatus(409)
    }
  });

})

app.post('/convertToNormal', (req, res) => {
  var sql = "SELECT * FROM normal_requests WHERE user_id=" + req.body.data.userId + " AND accepted=0";
  conn.query(sql, function (err, result) {
    if (result[0] == null) {
      var sql = "INSERT INTO normal_requests (user_id,comment) VALUES (" + req.body.data.userId + ",'" + req.body.data.comment + "')";
      conn.query(sql, function (err, result) {
        if (err) throw err;
        res.status(200).send(result);
      });
    } else {
      res.sendStatus(409)
    }
  });
})

app.get('/hasPremiumRequest/:id', function (req, res) {
  var sql = "SELECT * FROM premium_requests WHERE user_id=" + req.params.id + " AND accepted=0";
  conn.query(sql, function (err, result) {
    console.log(result);
    if (result[0] == null) {
      res.send(false);
    } else {
      res.send(true);
    }
  });
})

app.get('/hasNormalRequest/:id', function (req, res) {
  var sql = "SELECT * FROM normal_requests WHERE user_id=" + req.params.id + " AND accepted=0";
  conn.query(sql, function (err, result) {
    if (result[0] == null) {
      res.send(false);
    } else {
      res.send(true);
    }
  });
})

app.get('/normalRequests', function (req, res) {
  var sql = "SELECT * FROM normal_requests nr INNER JOIN users u ON (nr.user_id=u.id) WHERE nr.accepted=0";
  conn.query(sql, function (err, result) {
    if (err) throw err;
    res.send(result);
  });
})

app.get('/premiumRequests', function (req, res) {
  var sql = "SELECT * FROM premium_requests pr INNER JOIN users u ON (pr.user_id=u.id) WHERE pr.accepted=0";
  conn.query(sql, function (err, result) {
    if (err) throw err;
    res.send(result);
  });
})

app.post('/acceptNormalRequest', function (req, res) {
  var sql = "UPDATE normal_requests SET accepted=1 WHERE user_id=" + req.body.data.userId + " AND accepted=0";
  conn.query(sql, function (err, result) {
    if (err) throw err;
    var sql = "UPDATE users SET role=0 WHERE id=" + req.body.data.userId;
    conn.query(sql, function (err, result) {
      if (err) throw err;
      res.send(result);
    });
  });
})

app.post('/acceptPremiumRequest', function (req, res) {
  var sql = "UPDATE premium_requests SET accepted=1 WHERE user_id=" + req.body.data.userId + " AND accepted=0";
  conn.query(sql, function (err, result) {
    if (err) throw err;
    var sql = "UPDATE users SET role=1 WHERE id=" + req.body.data.userId;
    conn.query(sql, function (err, result) {
      if (err) throw err;
      res.send(result);
    });
  });
})

app.post('/acceptAdministratorRequest', function (req, res) {
  var sql = "UPDATE users SET role=2 WHERE id=" + req.body.data.userId;
  conn.query(sql, function (err, result) {
    if (err) throw err;
    res.send(result);
  });
})

module.exports = app;