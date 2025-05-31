
# 🛍️ Blokkat Shop

A decentralized e-commerce platform where users can shop using cryptocurrencies like ETH. Powered by smart contracts and deployed on the Scroll Sepolia testnet, this project demonstrates secure, transparent, and fast payments using blockchain technology.
```
![localhost_3000_ (1)](https://github.com/user-attachments/assets/5a056165-ab13-483b-baa6-0f52cbdc2fcc)
## 📂 About This Project

### 🚀 Project Description

Blokkat Shop is a full-stack DApp allowing users to:
- Browse and purchase digital products.
- View product stock in real-time.
- Make secure blockchain transactions from the frontend.



### 📁 Directory Structure


#### Backend (Smart Contracts - Foundry)
```
```
Backend/
├── src/             # Solidity contracts
├── script/          # Deployment & interaction scripts
├── test/            # Unit and integration tests
├── lib/             # External libraries (e.g., OpenZeppelin)
├── foundry.toml     # Foundry config
└── README.md        # Backend documentation
```
```

#### Frontend (Next.js + Wagmi + Ethers)
```
```
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
````

---

## 🎨 Design Patterns

### ✅ Inheritance and Interfaces
- Used `Ownable` from OpenZeppelin in `src/BlokkatShop.sol` to manage ownership of the contract.
```solidity
import "@openzeppelin/contracts/access/Ownable.sol";
````

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

* Ensured safety checks with `require()` across all functions, e.g.:

```solidity
require(msg.value >= product.price * quantity, "Insufficient ETH sent");
require(product.quantity >= quantity, "Not enough stock available");
```

---

## 🔗 Important Links & Addresses

### 🧾 Verified Contracts (Scroll Sepolia)

@@@

### 💡 Contract Addresses

@@@

### 🌐 Frontend DApp Hosted At

@@@

---

## 🧪 How to Run Tests

From the `Backend/` directory:

```bash
forge install
forge build
forge test
```

Make sure Foundry is installed. You can install it from: [https://book.getfoundry.sh/getting-started/](https://book.getfoundry.sh/getting-started/)

---

## ▶️ How to Run the Program

### 🧩 Backend

```bash
cd Backend
forge build
forge script script/Deploy.s.sol:Deploy --rpc-url <SCROLL_SEPOLIA_RPC> --private-key <YOUR_PRIVATE_KEY> --broadcast --verify
```

### 💻 Frontend

```bash
cd Frontend
npm install
npm run dev
```

### 🔐 Environment Variables

Create a `.env` file in the `Frontend/` directory:

```
NEXT_PUBLIC_CONTRACT_ADDRESS=0xYOUR_DEPLOYED_CONTRACT
NEXT_PUBLIC_CHAIN_ID=534351
NEXT_PUBLIC_SCROLL_SEPOLIA_RPC=https://sepolia-rpc.scroll.io/
```

---

## 🎥 Demo

@@@
The demo includes:

* Navigating the storefront.
* Adding items to the cart.
* Checking out with ETH.
* Verifying transaction on Scroll Sepolia explorer.
* Reading updated data directly from the smart contract.

---

> Built with ❤️ by Saba Fadhl

```

---

Let me know if you want the `.md` file itself or want to add the actual deployed contract address and video link — I’ll include them.
```
