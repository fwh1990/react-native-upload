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
short_url=${result.short}
icon_key=${result.cert.icon.key}
icon_token=${result.cert.icon.token}
icon_upload_url=${result.cert.icon.upload_url}
binary_key=${result.cert.binary.key}
binary_token=${result.cert.binary.token}
binary_upload_url=${result.cert.binary.upload_url}
`);
