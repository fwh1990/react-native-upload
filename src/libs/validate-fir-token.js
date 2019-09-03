const minimist = require('minimist');
const colors = require('colors');

const args = minimist(process.argv.slice(2));
const result = JSON.parse(args._[0]);

if (result.errors) {
    try {
        console.error(colors.red('\nError: ' + result.errors.exception[0] + '\n'));
    } catch (e) {
        console.error('\nError: ' + colors.red(args._[0]) + '\n');
    }
    process.exit(1);
}

console.log(`
SHORT_URL=${result.short}
ICON_KEY=${result.cert.icon.key}
ICON_TOKEN=${result.cert.icon.token}
ICON_UPLOAD_URL=${result.cert.icon.upload_url}
BINARY_KEY=${result.cert.binary.key}
BINARY_TOKEN=${result.cert.binary.token}
BINARY_UPLOAD_URL=${result.cert.binary.upload_url}
`);
