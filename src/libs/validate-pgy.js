const minimist = require('minimist');
const colors = require('colors');
const qrcode = require('./qrcode');

const args = minimist(process.argv.slice(2));
const result = JSON.parse(args._[0]);

if (result.code === 0) {
    const url = 'https://www.pgyer.com/' + result.data.buildShortcutUrl;
    console.log('\nInstall app by link or qrcode: ' + colors.green(url) + '\n');
    qrcode(url);
} else {
    try {
        console.error(colors.red('\nError: ' + result.message + '\n'));
    } catch (e) {
        console.error('\nError: ' + colors.red(args._[0]) + '\n');
    }
    process.exit(1);
}
