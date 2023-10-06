// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";


contract MerkleTree is ERC20{
    
    bytes32 public merkleRoot = 0x36aa3b65c321d69df189e026faa86d44b415330c17ac0e26045ead2284c63a6b;
    mapping(address => bool) public whitelistClaimed;

    constructor(bytes32 _merkleRoot) ERC20("MERKLE", "MRKL"){
        merkleRoot = _merkleRoot;
    }
        
    function checkInWhitelist(bytes32[] calldata proof) public {
        require(!whitelistClaimed[msg.sender], "Address already claimed");
        bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
        require(
            MerkleProof.verify(proof, merkleRoot, leaf),
            "You are not among the whitelisted Addresses"
        );
        whitelistClaimed[msg.sender] = true;
        _mint(msg.sender, 1000);
        
    }
}