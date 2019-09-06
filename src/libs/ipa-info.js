const fs = require('fs');
const AppInfoParser = require('app-info-parser');
const colors = require('colors');
const minimist = require('minimist');

const args = minimist(process.argv.slice(2));

new AppInfoParser(args._[0]).parse().then((result) => {
    let iconPath = '';

    if (result.icon) {
        iconPath = '/tmp/icon-ios-ipa-' + Math.random();
        fs.writeFileSync(
            iconPath,
            Buffer.from(result.icon.split(',')[1], 'base64'),
        );
    }

    console.log(`
        ios_icon=${iconPath}
        ios_name=${result.CFBundleDisplayName}
        ios_code=${result.CFBundleVersion}
        ios_version=${result.CFBundleShortVersionString}
        ios_bundle=${result.CFBundleIdentifier}
    `);
}).catch((error) => {
    console.error(colors.red('Error: ' + error.message));
    process.exit(1);
});
