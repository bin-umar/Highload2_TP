'use strict';

const express = require('express');
const path = require('path');
const morgan = require('morgan');

const sleep = (ms) => {
    return new Promise(resolve => setTimeout(resolve, ms));
};

const app = express();
app.use(express.static(path.resolve(__dirname, 'public')));
app.use(morgan('dev'));

app.get('*', async (req, res) => {
    await sleep(2000);

    res.json({message: 'ok'});
});

const port = process.env.PORT || 8000;
app.listen(port, () => console.log(`Server listening port ${port}`));
