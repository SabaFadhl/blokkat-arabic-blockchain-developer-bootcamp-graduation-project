// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

// Inheriting from Ownable to restrict access to owner-only functions
import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

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

    event ProductPurchased(uint256 indexed id, address buyer, uint256 quantity);

    constructor() Ownable(msg.sender){

        // Add initial static products (6 products)
        products[1] = Product(1, "Premium Wireless Headphones", "/img/headphones.jpg", 200, 50);
        products[2] = Product(2, "Smart Watch Pro", "/img/smartwatch.jpg", 150, 50);
        products[3] = Product(3, "Drone X Pro", "/img/drone.jpg", 300, 30);
        products[4] = Product(4, "VR Headset Elite", "/img/vr-headset.jpg", 400, 40);
        products[5] = Product(5, "Mechanical Keyboard", "/img/keyboard.jpg", 250, 60);
        products[6] = Product(6, "Portable SSD 1TB", "/img/ssd.jpg", 170, 35);
        nextProductId = 7;
    }
    function convertUsdToEth(uint256 usdAmount) public view returns (uint256) {
    (, int256 ethUsdPrice, , , ) = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).latestRoundData();
    require(ethUsdPrice > 0, "Invalid price");

    // Convert USD to ETH in wei with higher precision
    uint256 ethAmount = (usdAmount * 1e36) / uint256(ethUsdPrice);
    return ethAmount / 1e18; // Convert back to wei
}
    function getBalance() internal  view returns (uint256) {
        return msg.value;
    }
    // Buy a product by ID
    function buyProduct(uint256 productId, uint256 quantity) external payable {
        Product storage product = products[productId];

        require(product.id != 0, "Product does not exist");
        require(quantity > 0, "Invalid quantity");
        require(product.quantity >= quantity, "Not enough quantity");
        uint256 totalPrice = product.fiatPrice * quantity;
        convertUsdToEth(totalPrice);

        product.quantity -= quantity;

        emit ProductPurchased(productId, msg.sender, quantity);
    }

    // Return all products
    function getAllProducts() external view returns (Product[] memory) {
        Product[] memory allProducts = new Product[](nextProductId - 1);
        for (uint256 i = 1; i < nextProductId; i++) {
            allProducts[i - 1] = products[i];
        }
        return allProducts;
    }
      // Withdraw a specific amount (in wei) to the owner
    function withdraw(uint256 amount) public onlyOwner{
        require(address(this).balance >= amount, "Insufficient balance");
        payable(owner()).transfer(amount);
    }
}
