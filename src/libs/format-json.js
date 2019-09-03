const minimist = require('minimist');
const args = minimist(process.argv.slice(2));
const result = JSON.parse(args._[0]);

console.log(JSON.stringify(result, null, 1));
