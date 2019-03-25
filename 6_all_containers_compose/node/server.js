'use strict';

const express = require('express');
const os = require('os');
const mysql = require('mysql');

// Constants
const PORT = 5000;
const HOST = '0.0.0.0';

const MYSQL_HOST = 'zip2000_db';
const MYSQL_USER = 'zip2000_user';
const MYSQL_PASS = 'zip2000_pass';
const MYSQL_DB   = 'zip2000_app';


var con = undefined;

function connect() {
    con = mysql.createConnection({
        host: MYSQL_HOST,
        user: MYSQL_USER,
        password: MYSQL_PASS,
        database: MYSQL_DB
    });
    con.connect(function(err) {
        if (err) {
            console.log('Connection failed, reconnect in 2 seconds..');
            setTimeout(connect, 2000);
        }
    });
}

connect();

var counter = 0;

// Do some 'work' for ms miliseconds
function blockCpuFor(ms) {
    var now = new Date().getTime();
    var result = 0
    while (true) {
        result += Math.random() * Math.random();
        if (new Date().getTime() > now +ms)
        return;
    }
}

// Generate a random integer in range 0..max
function getRandomInt(max) {
    return Math.floor(Math.random() * Math.floor(max));
}

// App
const app = express();
app.get('/', (req, res) => {
    console.log('Accessed endpoint /');
    res.send('Hello world\n');
});

// 'Heavyweight' endpoint
app.get('/counter', (req, res) => {
    console.log('Accessed endpoint /counter, starting work...');
    blockCpuFor(1000*getRandomInt(10));
    res.send(counter + '\n');
    counter++;
    console.log('Work finished.');
});

// Get network info
app.get('/whoami', (req, res) => {
    console.log('Accessed endpoint /whoami');
    res.send(os.networkInterfaces());
});

// Get last 10 messages from the DB
app.get('/messages', (req, res) => {
    console.log('Accessed endpoint /messages');
    var sql = 'select * from messages order by ts desc limit 10;'
    con.query(sql, function (err, result, fields) {
        if (err) {
            res.send('[]');
        } else {
            res.send(result);
        }
    });
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
