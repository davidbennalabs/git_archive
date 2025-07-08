const express = require('express');
const morgan = require('morgan');

const app = express();
app.use(morgan('combined'));


app.get('/', (req, res) => {
  res.sendFile(__dirname + '/index.html')
});

app.get('/dev', (req, res) => {
  res.sendFile(__dirname + '/devindex.html')
});

app.get('/prod', (req, res) => {
  res.sendFile(__dirname + '/prodindex.html')
});

var listener = app.listen(process.env.PORT || 80, function() {
 console.log('listening on port ' + listener.address().port);
});

