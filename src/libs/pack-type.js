const minimist = require('minimist');
const args = minimist(process.argv.slice(2));

let packVariant = args.variant;

if (!packVariant || typeof packVariant !== 'string') {
    packVariant = 'release';
}

console.log(packVariant);