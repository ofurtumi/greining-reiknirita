const { default: mdToPdf } = require('md-to-pdf');
const { argv } = require('node:process');

const render = async (fileIn, fileOut) => {
	console.log('fileIn --> ', fileIn);
	console.log('fileOut --> ', fileOut);
	await mdToPdf({ path: fileIn }, { dest: fileOut });
};

if (argv[2]) {
	let fileIn = `${argv[2]}/readme.md`;
	let fileOut = argv[3]
		? argv[3]
		: `skil/${fileIn
				.replace('.md', '.pdf')
				.replace('/readme', '')
				.replace('/', '_')}`;
	render(fileIn, fileOut);
} else {
	console.log('vantar input skrá');
}
