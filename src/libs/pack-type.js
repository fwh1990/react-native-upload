const minimist = require('minimist');

const args = minimist(process.argv.slice(2));

if (!args.variant || typeof args.variant !== 'string') {
    args.variant = 'release';
}

// path is case-insensitive on macos
const packVariant = args.variant.toLowerCase();

console.log(
    `
    pack_variant=${packVariant}
    pack_output_path=${packVariant.replace(/^(.*)(release|debug)$/, '$1/$2')}
    `
);