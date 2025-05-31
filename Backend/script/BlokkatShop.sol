// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.26;

import {Script, console} from "forge-std/Script.sol";
import {BlokkatShop} from "../src/BlokkatShop.sol";

contract BlokkatShopScript is Script {
    BlokkatShop public blokkatShop;
    
    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        blokkatShop = new BlokkatShop();

        vm.stopBroadcast();
    }
}
