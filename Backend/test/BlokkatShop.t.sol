// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "forge-std/Test.sol";
import "../src/BlokkatShop.sol";

contract MockBlokkatShop is BlokkatShop {
    function exposePriceFeed() external view returns (AggregatorV3Interface) {
        return priceFeed;
    }
}

contract BlokkatShopTest is Test {
    MockBlokkatShop shop;
    address user = address(0xBEEF);
    address owner = address(this);

    // Allow this test contract to receive ETH via transfer()
    receive() external payable {}

    function setUp() public {
        vm.deal(owner, 10 ether);
        vm.deal(user, 10 ether);
        shop = new MockBlokkatShop();

        // Mock the Chainlink price feed to always return $2000/ETH
        vm.mockCall(
            address(shop.exposePriceFeed()),
            abi.encodeWithSelector(AggregatorV3Interface.latestRoundData.selector),
            abi.encode(uint80(0), int256(2000 * 10**8), uint256(0), uint256(0), uint80(0))
        );
    }

    // Test 1: initial product details are correct after deployment
    function testInitialProductDetails() public {
        (
            uint256 id,
            string memory name,
            string memory image,
            uint256 fiatPrice,
            uint256 quantity
        ) = shop.products(1);
        assertEq(id, 1, "Product ID should be 1");
        assertEq(name, "Premium Wireless Headphones", "Product name mismatch");
        assertEq(image, "/img/headphones.jpg", "Product image mismatch");
        assertEq(fiatPrice, 200, "Product fiat price mismatch");
        assertEq(quantity, 50, "Product initial quantity mismatch");
    }

    // Test 2: buying multiple products reduces stock correctly
    function testBuyMultipleProducts() public {
        uint256[] memory ids = new uint256[](2);
        uint256[] memory qtys = new uint256[](2);
        ids[0] = 1; ids[1] = 2;
        qtys[0] = 1; qtys[1] = 2;

        uint256 totalUsd = 200 * 1 + 150 * 2;
        uint256 requiredEth = shop.convertUsdToEth(totalUsd);

        vm.prank(user);
        shop.buyProducts{ value: requiredEth }(ids, qtys);

        (, , , , uint256 q1) = shop.products(1);
        (, , , , uint256 q2) = shop.products(2);
        assertEq(q1, 49, "Quantity of product 1 should decrement by 1");
        assertEq(q2, 48, "Quantity of product 2 should decrement by 2");
    }

    // Test 3: revert when sent ETH is insufficient
    function testInsufficientEthRevert() public {
        uint256[] memory ids = new uint256[](1);
        uint256[] memory qtys = new uint256[](1);
        ids[0] = 1; qtys[0] = 1;

        uint256 requiredEth = shop.convertUsdToEth(200);
        vm.expectRevert("Insufficient ETH sent");
        vm.prank(user);
        shop.buyProducts{ value: requiredEth - 1 }(ids, qtys);
    }

    // Test 4: revert when requested quantity exceeds stock
    function testInsufficientQuantityRevert() public {
        uint256[] memory ids = new uint256[](1);
        uint256[] memory qtys = new uint256[](1);
        ids[0] = 1; qtys[0] = 51;

        uint256 requiredEth = shop.convertUsdToEth(200 * 51);
        vm.expectRevert("Insufficient quantity");
        vm.prank(user);
        shop.buyProducts{ value: requiredEth }(ids, qtys);
    }

    // Test 5: owner can withdraw the full contract balance
    function testWithdraw() public {
        uint256[] memory ids = new uint256[](1);
        uint256[] memory qtys = new uint256[](1);
        ids[0] = 1; qtys[0] = 1;

        uint256 requiredEth = shop.convertUsdToEth(200);
        vm.prank(user);
        shop.buyProducts{ value: requiredEth }(ids, qtys);

        uint256 before = owner.balance;
        uint256 bal = address(shop).balance;

        // Call withdraw as the owner
        shop.withdraw(bal);

        assertEq(owner.balance, before + bal, "Owner balance should increase by withdrawn amount");
        assertEq(address(shop).balance, 0, "Contract balance should be zero after withdrawal");
    }
}