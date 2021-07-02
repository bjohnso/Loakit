pragma solidity >=0.5.4;

contract Promise {
    string public pinkyPromise;

    constructor(string memory _pinkyPromise) public {
        pinkyPromise = _pinkyPromise;
    }

    function setPinkyPromise(string memory _pinkyPromise) public {
        pinkyPromise = _pinkyPromise;
    }
}