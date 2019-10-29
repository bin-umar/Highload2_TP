'use strict';

const express = require('express');
const path = require('path');
const url = require('url');
const fs = require('fs');
const morgan = require('morgan');

const sleep = (ms) => {
    return new Promise(resolve => setTimeout(resolve, ms));
};

const app = express();
app.use(express.static(path.resolve(__dirname)));
app.use(morgan('dev'));

app.get('*', async (req, res) => {
    const parsed = url.parse(req.url);
    const filename = path.basename(parsed.pathname);

    if (fs.existsSync(filename)) {
        res.sendFile(filename);
    } else {
        res.json({message: 'ok'});
    }
});

const port = process.env.PORT || 8000;
app.listen(port, () => console.log(`Server listening port ${port}`));
