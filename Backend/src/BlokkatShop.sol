// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract BlokkatShop is Ownable {
    struct Product {
        uint256 id;
        string name;
        string image;
        uint256 fiatPrice;
        uint256 quantity;
    }

    uint256 public nextProductId = 1;
    mapping(uint256 => Product) public products;

    AggregatorV3Interface internal priceFeed;

    event ProductPurchased(uint256 indexed id, address buyer, uint256 quantity);
    event MultipleProductsPurchased(address buyer, uint256 totalUsd, uint256 totalEth);

    constructor() Ownable(msg.sender) {
        priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);

        // Initial products
        products[1] = Product(1, "Premium Wireless Headphones", "/img/headphones.jpg", 200, 50);
        products[2] = Product(2, "Smart Watch Pro", "/img/smartwatch.jpg", 150, 50);
        products[3] = Product(3, "Drone X Pro", "/img/drone.jpg", 300, 30);
        products[4] = Product(4, "VR Headset Elite", "/img/vr-headset.jpg", 400, 40);
        products[5] = Product(5, "Mechanical Keyboard", "/img/keyboard.jpg", 250, 60);
        products[6] = Product(6, "Portable SSD 1TB", "/img/ssd.jpg", 170, 35);
        nextProductId = 7;
    }

    function convertUsdToEth(uint256 usdAmount) public view returns (uint256) {
        (, int256 ethUsdPrice, , , ) = priceFeed.latestRoundData();
        require(ethUsdPrice > 0, "Invalid price");
        return (usdAmount * 1e18) / uint256(ethUsdPrice);
    }

    function buyProducts(uint256[] calldata productIds, uint256[] calldata quantities) external payable {
        require(productIds.length == quantities.length, "Mismatched inputs");
        uint256 totalUsd = 0;

        // 1. Calculate total USD and check quantities
        for (uint256 i = 0; i < productIds.length; i++) {
            Product storage product = products[productIds[i]];
            require(product.id != 0, "Invalid product");
            require(product.quantity >= quantities[i], "Insufficient quantity");

            totalUsd += product.fiatPrice * quantities[i];
        }

        // 2. Convert USD to ETH
        uint256 requiredEth = convertUsdToEth(totalUsd);
        require(msg.value >= requiredEth, "Insufficient ETH sent");

        // 3. Update quantities
        for (uint256 i = 0; i < productIds.length; i++) {
            products[productIds[i]].quantity -= quantities[i];
            emit ProductPurchased(productIds[i], msg.sender, quantities[i]);
        }

        emit MultipleProductsPurchased(msg.sender, totalUsd, msg.value);
    }

    function withdraw(uint256 amount) public onlyOwner {
        require(address(this).balance >= amount, "Not enough balance");
        payable(owner()).transfer(amount);
    }

    function getAllProducts() external view returns (Product[] memory) {
        Product[] memory all = new Product[](nextProductId - 1);
        for (uint256 i = 1; i < nextProductId; i++) {
            all[i - 1] = products[i];
        }
        return all;
    }
}
