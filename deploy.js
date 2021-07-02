const HDWalletProvider = require('@truffle/hdwallet-provider');
const Web3 = require('web3');
const { abi, evm } = require('./compile');
const {mnemonic, infuraUrl} = require('./config/deploy_config.json')

const provider = new HDWalletProvider(
    mnemonic, infuraUrl
);

const web3 = new Web3(provider);
const initialPromise = 'Get 50%'

const deploy = async () => {
    const accounts = await web3.eth.getAccounts();

    console.log('deploying from account', accounts[0]);

    const deployResult = await new web3.eth.Contract(abi)
        .deploy({
            data: evm.bytecode.object,
            arguments: [initialPromise]
        }).send({
            from: accounts[0],
            gas: '1000000'
        });

    console.log('contract deployed to', deployResult.options.address);
};

deploy().then();