// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Staker.sol";
import {ERC721Holder} from "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";

// Run anvil, then deply and mint
// anvil
// forge script script/QAStaker.s.sol:QAStakerScript --broadcast -vvvv
contract QAStakerScript is Script, ERC721Holder {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        Staker token = new Staker();
        token.mint{value: token.price()}();
        token.mint{value: token.price()}();
        token.mint{value: token.price()}();

        console.log(token.tokenURI(3));

        vm.stopBroadcast();
    }
}
