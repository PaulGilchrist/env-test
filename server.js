var cors = require('cors')
const express = require('express');
var path = require('path');
const app = express();

// Environment variables
const port = process.env.port ?? 8080;

// Enable All CORS Requests
app.use(cors())
// For parsing application/json
app.use(express.json());

app.use("/swagger", express.static(path.resolve(__dirname, 'swagger')));
app.get('/', (req, res) => { // Swagger is the homepage for an API
    res.redirect('/swagger');
});

app.get('/key', function (req, res) {
    //console.log(req);
    const name = req.query["name"];
    const envVariable = {
        name,
        value: process.env[name]
    }
    res.json(envVariable);
});

const server = app.listen(port, () => {
    const host = server.address().address
    const port = server.address().port
    console.log(`Listening on port ${port}`)
})
