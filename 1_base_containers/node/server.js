'use strict';

const express = require('express');

// Constants
const PORT = 5000;
const HOST = '0.0.0.0';

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

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
