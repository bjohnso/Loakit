pragma solidity >=0.5.4;

contract Promise {
    string public pinkyPromise;

    constructor(string memory initialPinkyPromise) public {
        pinkyPromise = initialPinkyPromise;
    }
}