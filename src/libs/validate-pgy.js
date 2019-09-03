const minimist = require('minimist');
const colors = require('colors');
const qrcodeTerminal = require('qrcode-terminal');

const args = minimist(process.argv.slice(2));
const result = JSON.parse(args._[0]);

if (result.buildShortcutUrl) {
    console.log('\nVisit link: ' + colors.green(result.buildShortcutUrl) + '\n');
    qrcodeTerminal.generate(result.buildShortcutUrl, console.log);
} else {
    try {
        console.log(colors.red('\nError: ' + result.message + '\n'));
    } catch (e) {
        console.error('\nError: ' + colors.red(args._[0]) + '\n');
    }
    process.exit(1);
}
