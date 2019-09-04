const minimist = require('minimist');
const colors = require('colors');

const args = minimist(process.argv.slice(2));
const result = JSON.parse(args._[0]);

if (result.error) {
    try {
        console.error('\n' + colors.red('Error: ' + result.error) + '\n');
    } catch (e) {
        console.error('\n' + colors.red('Error: ' + args._[0]) + '\n');
    }
    process.exit(1);
}
