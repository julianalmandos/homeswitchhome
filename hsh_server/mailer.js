const nodemailer = require('nodemailer');

var transporter = nodemailer.createTransport({
  service: 'Gmail',
  auth: {
    user: 'homeswitchhome23@gmail.com',
    pass: 'grupoing23'
  }
});

function sendEmail(to,subject,text){
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

module.exports = {transporter,sendEmail};