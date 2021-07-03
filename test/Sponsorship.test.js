const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');
const web3 = new Web3(ganache.provider());

const { abi, evm } = require('../ethereum/build/Sponsorship.json');

let accounts;
let gas;

const sponsorName = 'Awesome Test Sponsor';

let sponsorshipContract;
let sponsorAddress;

beforeEach(async () => {
    accounts = await web3.eth.getAccounts();
    sponsorAddress = accounts[0];

    gas = await new web3.eth.Contract(abi)
        .deploy({
            data: evm.bytecode.object,
            arguments: [sponsorName],
        }).estimateGas({
            from: sponsorAddress,
        });

    sponsorshipContract = await new web3.eth.Contract(abi)
        .deploy({
            data: evm.bytecode.object,
            arguments: [sponsorName],
        }).send({
            from: sponsorAddress,
            gas,
        });
});

describe('Sponsorship Contract', () => {
    it('deploys a Sponsorship contract', () => {
        assert.ok(sponsorshipContract.options.address);
    });
});