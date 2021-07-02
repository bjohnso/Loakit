const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');
const web3 = new Web3(ganache.provider());
const { abi, evm } = require('../compile');

let accounts;
let promise;

const initialPromise = 'Get 50%'

beforeEach(async () => {
    accounts = await web3.eth.getAccounts();

    promise = await new web3.eth.Contract(abi)
        .deploy({
            data: evm.bytecode.object,
            arguments: [initialPromise] }
        )
        .send({
            from: accounts[0],
            gas: '1000000' }
        );
});

describe('Promise', () => {
    it('deploys a Promise contract', () => {
        assert.ok(promise.options.address);
    });

    it('has a pinky promise', async () => {
        const pinkyPromise = await promise.methods.pinkyPromise().call();
        assert.strictEqual(pinkyPromise, initialPromise);
    });

    it('has set a pinky promise', async () => {
        const newPinkyPromise = 'Get 60%';
        await promise.methods.setPinkyPromise(newPinkyPromise)
            .send({ from: accounts[0] });
        const pinkyPromise = await promise.methods.pinkyPromise().call();
        assert.strictEqual(pinkyPromise, newPinkyPromise);
    });
});