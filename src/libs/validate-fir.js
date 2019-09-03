const minimist = require('minimist');
const colors = require('colors');

const args = minimist(process.argv.slice(2));
const result = JSON.parse(args._[0]);

if (result.error) {
    try {
        console.error(colors.red('\nError: ' + result.error + '\n'));
    } catch (e) {
        console.error('\nError: ' + colors.red(args._[0]) + '\n');
    }
    process.exit(1);
}
