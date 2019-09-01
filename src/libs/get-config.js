#!/usr/bin/env node

const path = require('path');
const fs = require('fs');
const minimist = require('minimist');
const colors = require('colors');

const args = minimist(process.argv.slice(2));
const configPath = (args._[0] || '').split('.');
const file = path.resolve('upload.json');

if (!fs.existsSync(file)) {
    console.error(colors.red('\nOops, did you forget to create config file "upload.json"?\n'));
    process.exit(1);
}

const config = JSON.parse(fs.readFileSync(file).toString());
const propertyValue = configPath.reduce((carry, item) => {
    if (carry[item] === undefined) {
        console.error(colors.red(`\nProperty "${configPath.join(' -> ')}" is missing in file "upload.json"?\n`));
        process.exit(1);
    }

    if (typeof carry[item] === 'boolean') {
        return parseInt(carry[item], 10);
    }

    return carry[item];
}, config);

console.log(propertyValue);
