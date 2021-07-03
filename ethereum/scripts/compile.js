const path = require('path');
const fs = require('fs-extra');
const solc = require('solc');

const buildPath = path.resolve(__dirname, '../build');
fs.removeSync(buildPath);

const sourcePath = path.resolve(__dirname, '../contracts');
const sourceFiles = fs.readdirSync(sourcePath, { encoding: 'utf8' });

for (let file of sourceFiles) {
    const sourcePath = path.resolve(__dirname, '../contracts', file);
    const source = fs.readFileSync(sourcePath, 'utf8');

    const solcInput = JSON.stringify({
        language: "Solidity",
        sources: {
            contract: {
                content: source
            }
        },
        settings: {
            optimizer: {
                enabled: true
            },
            evmVersion: "istanbul",
            outputSelection: {
                "*": {
                    "": [
                        "legacyAST",
                        "ast"
                    ],
                    "*": [
                        "abi",
                        "evm.bytecode.object",
                        "evm.bytecode.sourceMap",
                        "evm.deployedBytecode.object",
                        "evm.deployedBytecode.sourceMap",
                        "evm.gasEstimates"
                    ]
                },
            }
        }
    });

    const output = JSON.parse(solc.compile(solcInput)).contracts.contract;

    fs.ensureDirSync(buildPath);

    for (let contract in output) {
        const contractPath = path.resolve(buildPath, `${contract}.json`);
        fs.outputJsonSync(contractPath, output[contract]);
    }
}