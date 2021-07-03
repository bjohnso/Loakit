const path = require('path');
const fs = require('fs');
const solc = require('solc');

const promiseContractPath = path.resolve(__dirname, 'contracts', 'Sponsorship.sol');
const source = fs.readFileSync(promiseContractPath, 'utf8');

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

module.exports = JSON.parse(solc.compile(solcInput))
    .contracts.contract.Promise;