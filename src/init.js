#!/usr/bin/env node

const path = require('path');
const fs = require('fs');
const colors = require('colors');

const target = path.resolve('upload.json');

if (fs.existsSync(target)) {
    console.error(colors.red('\nThe config file "upload.json" was created, delete before you can regenerate it.\n'));
    process.exit(1);
}

fs.copyFileSync(path.join(__dirname, 'libs/upload.json'), target);

console.log(colors.green('\nThe config file "upload.json" is created for this project.\n'));
