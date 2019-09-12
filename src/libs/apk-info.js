const fs = require('fs');
const AppInfoParser = require('app-info-parser');
const colors = require('colors');
const minimist = require('minimist');

const args = minimist(process.argv.slice(2));

new AppInfoParser(args._[0]).parse().then((result) => {
    let iconPath = '';

    if (result.icon) {
        iconPath = '/tmp/icon-android-apk-' + Math.random();
        fs.writeFileSync(
            iconPath,
            Buffer.from(result.icon.split(',')[1], 'base64')
        );
    }

    console.log(`
        android_icon=${iconPath}
        android_name=${result.application.label[0]}
        android_code=${result.versionCode}
        android_version=${result.versionName}
        android_bundle=${result.package}
    `);
}).catch((error) => {
    console.error(colors.red('Error: ' + error.message));
    process.exit(1);
});
