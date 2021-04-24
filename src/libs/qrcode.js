const qrcode = require('qrcode-terminal');
const minimist = require('minimist');
const args = minimist(process.argv.slice(2));

const create = (url) => {
    // L -> M -> Q -> H
    qrcode.setErrorLevel('L');
    qrcode.generate(url, { small: true });
};

args.url && create(args.url);
module.exports = create;
