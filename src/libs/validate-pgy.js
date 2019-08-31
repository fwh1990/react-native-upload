const minimist = require('minimist');
const colors = require('colors');

const args = minimist(process.argv.slice(2));
const result = JSON.parse(args._[0]);

if (result.buildShortcutUrl) {
    console.log(colors.green('\nVisit link: ' + result.buildShortcutUrl + '\n'));
} else {
    console.log(colors.red('\nError: ' + result.message + '\n'));
    process.exit(1);
}
