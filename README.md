# Blokkat Shop

A decentralized e-commerce platform where users can shop using cryptocurrencies like ETH. Powered by smart contracts and deployed on the Scroll Sepolia testnet, this project demonstrates secure, transparent, and fast payments using blockchain technology.

![localhost\_3000\_ (1)](https://github.com/user-attachments/assets/5a056165-ab13-483b-baa6-0f52cbdc2fcc)

---

## 📂 About This Project

### 🚀 Project Description

Blokkat Shop is a full-stack DApp developed as part of the graduation requirements for the **Blokkat Smart Contract Developer Bootcamp**.

It allows users to:

* Browse and purchase digital products.
* View product stock in real-time.
* Make secure blockchain transactions from the frontend.

### 💡 Project Idea

The idea behind this project is to simulate a real-world online store where all payments are made in crypto. The prices are displayed in USD but converted dynamically to ETH using **Chainlink Price Feeds**, allowing users to pay an equivalent amount in ETH on the **Sepolia network**. This creates a bridge between traditional e-commerce and blockchain-based payments.

### 📁 Directory Structure

#### Backend (Smart Contracts - Foundry)

```bash
Backend/
├── src/             # Solidity contracts
├── script/          # Deployment & interaction scripts
├── test/            # Unit and integration tests
├── lib/             # External libraries (e.g., OpenZeppelin)
├── foundry.toml     # Foundry config
└── README.md        # Backend documentation
```

#### Frontend (Next.js + Wagmi + Ethers)

```bash
Frontend/
├── app/             # App routes and pages
├── components/      # Reusable React components
├── config/          # Config files (e.g., contracts addresses)
├── context/         # React context (WalletProvider etc.)
├── lib/             # Blockchain utility functions
├── public/          # Static assets
├── .env             # Environment variables (user-specific)
└── README.md        # Frontend documentation
```

---

## 🎨 Design Patterns

### ✅ Inheritance and Interfaces

* Used `Ownable` from OpenZeppelin in `src/BlokkatShop.sol` to manage ownership of the contract.

```solidity
import "@openzeppelin/contracts/access/Ownable.sol";
```

### ✅ Access Control Design Patterns

* Restricted sensitive functions using `onlyOwner` modifier in `BlokkatShop.sol`.

```solidity
function withdraw() public onlyOwner {
    payable(owner()).transfer(address(this).balance);
}
```

---

## 🔐 Security Measures

### ✅ Using Specific Compiler Pragma

```solidity
pragma solidity 0.8.20;
```

### ✅ Proper Use of Require

Ensured safety checks with `require()` across all functions:

```solidity
require(msg.value >= product.price * quantity, "Insufficient ETH sent");
require(product.quantity >= quantity, "Not enough stock available");
```

---

## 🔗 Important Links & Addresses

### 📜 Verified Contract (Scroll Sepolia)

[Etherscan - Contract](https://sepolia.etherscan.io/address/0xb4d7e62C39fe0Bc41290E6eB5cC056e1e58cB55D)

### 📊 Contract Address

```
0xb4d7e62C39fe0Bc41290E6eB5cC056e1e58cB55D
```

### 🌐 Frontend DApp Hosted At

[https://blokkat-store-kama.vercel.app/](https://blokkat-store-kama.vercel.app/)

---

## 🧪 How to Run Tests

From the `Backend/` directory:

```bash
forge install
forge build
forge test
```

Make sure Foundry is installed: [https://book.getfoundry.sh/getting-started/](https://book.getfoundry.sh/getting-started/)

---

## 🚀 How to Run the Program

### 🔹 Backend

```bash
cd Backend
forge build
forge script script/BlokkatShop.s.sol:BlokkatShop --rpc-url https://sepolia-rpc.scroll.io/ --private-key <YOUR_PRIVATE_KEY> --broadcast --verify
```

### 💻 Frontend

```bash
cd Frontend
npm install
npm run dev
```

### 🔐 Environment Variables

Create a `.env` file in the `Frontend/` directory:

```env
NEXT_PUBLIC_PROJECT_ID=0xb4d7e62C39fe0Bc41290E6eB5cC056e1e58cB55D
```

Create a `.env` file in the `Backend/` directory:
```env
PRIVATE_KEY=<YOUR_PRIVATE_KEY>
RPC_URL=https://sepolia-rpc.scroll.io/
```

---

## 🎥 Demo

[Watch Demo on YouTube](https://youtu.be/KGlBNauD3X8)

The demo includes:

* Navigating the storefront.
* Connecting a wallet.
* Viewing balance.
* Adding items to the cart.
* Checking out with ETH.
* Verifying transaction on Scroll Sepolia explorer.
* Reading updated data from the smart contract.

---

> Built with ❤️ by Saba Fadhl
