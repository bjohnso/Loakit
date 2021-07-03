const HDWalletProvider = require('@truffle/hdwallet-provider');
const Web3 = require('web3');
const {mnemonic, infuraUrl} = require('../config/deploy_config.json')

const compiledSponsorship = require('../build/Sponsorship.json');

const provider = new HDWalletProvider(
    mnemonic, infuraUrl
);

const web3 = new Web3(provider);

const sponsorName = 'Awesome Test Sponsor';

let sponsorAddress;

const deploy = async () => {
    const accounts = await web3.eth.getAccounts();
    sponsorAddress = accounts[0];

    console.log('deploying from account', sponsorAddress);

    gas = await new web3.eth.Contract(compiledSponsorship.abi)
        .deploy({
            data: compiledSponsorship.evm.bytecode.object,
            arguments: [sponsorName],
        }).estimateGas({
            from: sponsorAddress,
        });

    const deployResult = await new web3.eth.Contract(compiledSponsorship.abi)
        .deploy({
            data: compiledSponsorship.evm.bytecode.object,
            arguments: [sponsorName],
        }).send({
            from: sponsorAddress,
            gas
        });

    console.log('contract deployed to', deployResult.options.address);
};

deploy().then();