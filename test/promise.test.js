const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');
const web3 = new Web3(ganache.provider());
const { abi, evm } = require('../compile');

let accounts;
let promise;

beforeEach(async () => {
    accounts = await web3.eth.getAccounts();

    promise = await new web3.eth.Contract(abi)
        .deploy({
            data: evm.bytecode.object,
            arguments: ['Get 50%'] }
        )
        .send({
            from: accounts[0],
            gas: '1000000' }
        );
});

describe('Promise', () => {
    it('deploys a contract', () => {
        console.log(promise);
    });
});