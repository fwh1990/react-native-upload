#!/usr/bin/env node

const path = require('path');
const fs = require('fs');
const minimist = require('minimist');
const colors = require('colors');

const args = minimist(process.argv.slice(2));
const file = path.resolve('upload.json');

if (!fs.existsSync(file)) {
    console.error(colors.red('\nOops, did you forget to create config file "upload.json"\n'));
    process.exit(1);
}

const config = JSON.parse(fs.readFileSync(file).toString());
let [configPaths, defaultValue] = args._[0].split('#');
let propertyValue;

configPaths = configPaths.split(',');

for (const configPath of configPaths) {
    if (configPath.indexOf('.') === -1) {
        if (args[configPath] !== undefined) {
            if (typeof args[configPath] === 'boolean') {
                propertyValue = Number(args[configPath]);
            } else {
                propertyValue = args[configPath];
            }
        }
    } else {
        propertyValue = configPath.split('.').reduce((carry, item) => {
            if (carry === undefined) {
                return carry;
            }

            if (carry[item] === undefined || carry[item] === '') {
                return undefined;
            }

            if (typeof carry[item] === 'boolean') {
                return Number(carry[item]);
            }

            return carry[item];
        }, config);
    }

    if (propertyValue !== undefined) {
        break;
    }
}

if (propertyValue === undefined) {
    if (defaultValue === undefined) {
        console.error(colors.red(`\nProperty "${configPaths.join('" or "')}" is missing in file "upload.json"?\n`));
        process.exit(1);
    } else {
        propertyValue = defaultValue;
    }
}

console.log(propertyValue);
