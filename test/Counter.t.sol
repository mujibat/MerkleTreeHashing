// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2, stdJson} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";
import {MerkleTree} from "../src/MerkleTree.sol";

contract MerkleTreeTest is Test {
    MerkleTree public merkletree;
    using stdJson for string;

     struct Merkle {
        bytes32 leaf;
        bytes32[] proof;
    }
     
    bytes32 root =
        0x36aa3b65c321d69df189e026faa86d44b415330c17ac0e26045ead2284c63a6b;

    address user1 = 0xEB7A41D324ee4859E3cbFAd4b3820B82FCCe6658;
    address randomaddr = 0x0c404F55595ab844D519a084fF1B8cB36AAAD1d1;
    uint user1Amt = 45000000000000;

    Merkle public merkle;

    function setUp() public {
        merkletree = new MerkleTree(root);
        string memory _root = vm.projectRoot();
        string memory path = string.concat(_root, "/merkle_tree.json");
        string memory json = vm.readFile(path);

        bytes memory res = json.parseRaw(
            string.concat(".", vm.toString(user1))
        );

        merkle = abi.decode(res, (Merkle));
        console2.logBytes32(merkle.leaf);
    }


    function testUserCantClaimTwice() public {
        vm.prank(user1);
        testClaim();
        vm.expectRevert("You have already claimed!");
        // testClaim();
    }

    // function testClaim() public {
    //     bool success = _claim();
    //     assertEq(merkletree.balanceOf(user1), user1Amt);

    //     assertTrue(success);
    // }
    // function testHasClaimed() public {
    //     vm.prank(randomaddr);
    //     assertEq(merkletree.whitelistClaimed(randomaddr), true);
    //     vm.expectRevert("You have already claimed!");
    //     //  testClaim();
    // }
    function testClaim() public {
        vm.prank(user1);
        merkletree.checkInWhitelist(merkle.proof);
    }

    // function testcheckInWhitelist() public {
    //     vm.expectRevert(merkletree.checkInWhitelist(merkle.proof));
    // }

    
}
