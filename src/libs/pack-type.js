const minimist = require('minimist');

const args = minimist(process.argv.slice(2));

let releaseType = 'release';

if (args.debug === true) {
    releaseType = 'debug';
}

console.log(releaseType);