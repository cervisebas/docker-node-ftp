import express, { Router } from 'express';
const app = express(),
    router = Router(),
    PORT = 8081;

router.get('/', function(req, res) {
  res.send("hello world");
});
router.get('/ping', function(req, res) {
  res.send("Pong!");
});

app.use('/', router);
app.listen(PORT, function() {
  console.log(`Example app listening on port ${PORT}!`)
});