PROJECT OVERVIEW
This project implements a decentralized second-hand trading platform using blockchain technology. The system consists of a Solidity smart contract that handles the core trading logic and a React-based frontend application that provides user interaction with the contract. The platform enables secure peer-to-peer trading of items with built-in escrow functionality, ensuring that both buyers and sellers are protected throughout the transaction process.

PROJECT STRUCTURE

Smart Contract: Listing.sol - Handles item listing, bidding, and escrow logic

Frontend Application: React app with Web3 integration

ABI File: contract-abi.json - Interface for frontend-contract communication

PREREQUISITES

Node.js and npm installed

MetaMask browser extension installed

Basic knowledge of Ethereum and React

SMART CONTRACT FEATURES

Item listing with minimum price

Secure bidding system with automatic refunds

Escrow payment system

Delivery tracking (sent/received status)

Seller and buyer access controls

FRONTEND FEATURES

Wallet connection via MetaMask

Contract state viewing

Real-time status updates

User-friendly interface

SETUP INSTRUCTIONS

SMART CONTRACT DEPLOYMENT:

Compile Listing.sol using Remix IDE or Hardhat

Deploy to Ethereum testnet (Goerli, Sepolia, etc.)

Note the deployed contract address

FRONTEND SETUP:

Navigate to project directory

Install dependencies: npm install

Update contract address in App.js

Ensure contract-abi.json is in src directory

Start development server: npm start

CONFIGURATION:

Update contractAddress in App.js with your deployed contract address

Ensure MetaMask is connected to the correct network

Verify contract ABI matches your deployed contract
