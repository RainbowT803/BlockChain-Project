import React, { useState } from "react";
import { ethers } from "ethers";
import contractAbi from "./contract-abi.json";
import "./App.css";

// 替換為你自己的 contract address
const contractAddress = "0xa596045F3d2567cE60765E7305fA1d1c1e091185";

function App() {
  const [name, setName] = useState("");
  const [sent, setSent] = useState(null);
  const [recieved, setRecieved] = useState(null);
  const [buyer, setBuyer] = useState("");
  const [chainId, setChainId] = useState("");
  const [account, setAccount] = useState("");
  const [status, setStatus] = useState("Not connected");
  const [price, setPrice] = useState("");
  
  async function connectWallet() {
    if (!window.ethereum) {
      alert("Please install MetaMask!");
      return;
    }
    try {
      const accounts = await window.ethereum.request({ method: "eth_requestAccounts" });
      setAccount(accounts[0]);
      const curChainId = await window.ethereum.request({ method: 'eth_chainId' });
      setChainId(curChainId);
      setStatus("Connected");
    } catch (e) {
      setStatus("Wallet connection denied");
    }
  }

  async function fetchContractInfo() {
    setStatus("Querying contract...");
    try {
      if (!window.ethereum) {
        alert("Please install MetaMask!");
        return;
      }
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const contract = new ethers.Contract(contractAddress, contractAbi, provider);

      setName(await contract.getName());
      setPrice(await contract.getPrice());
      setSent(await contract.isSent());
      setRecieved(await contract.isRecieved());

      try {
        setBuyer(await contract.getBuyer());
      } catch (e) {
        setBuyer("Not sold yet");
      }
      setStatus("Done");
    } catch (err) {
      setStatus("Error: " + (err && err.message ? err.message : err));
    }
  }

  return (
    <div className="container">
      <div className="card">

        <h1>Listing Contract Viewer</h1>

        <div className="status-bar">
          <span className={status.startsWith("Connected") ? "status-success" : "status-error"}>
            {status}
          </span>
          <span className="status-net">
            {chainId ? `Chain ID: ${chainId}` : null}
          </span>
          <span className="status-account">
            {account ? `Account: ${account}` : null}
          </span>
        </div>

        <div className="actions">
          <button className="btn" onClick={connectWallet}>Connect Wallet</button>
          <button className="btn primary" onClick={fetchContractInfo}>View Contract Info</button>
        </div>

        <div className="result">
          <div>
            <span className="label">Item Name:</span>
            <span>{name}</span>
          </div>
          <div>
            <span className="label">Listing Price:</span>
            <span>{price.toString()}</span>
          </div>
          <div>
            <span className="label">Sent:</span>
            <span>{sent === null ? "-" : sent ? "✅ Yes" : "❌ No"}</span>
          </div>
          <div>
            <span className="label">Received:</span>
            <span>{recieved === null ? "-" : recieved ? "✅ Yes" : "❌ No"}</span>
          </div>
          <div>
            <span className="label">Buyer Address:</span>
            <span>{buyer}</span>
          </div>

        </div>

      </div>

    </div>
  );
}

export default App;