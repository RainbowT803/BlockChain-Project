The contract to be deployed can be found in the file Listing.sol and can be deployed with for example remix ide.
Usage flow is illustrated in the figure usage.png

The React application allows you to interact with an Ethereum smart contract to view listing information.

PREREQUISITES:
1. Node.js (version 14 or higher)
2. npm (Node Package Manager)
3. MetaMask browser extension installed

INSTALLATION:
1. Download or clone the project files
2. Ensure you have these files in your project directory:
   - App.js
   - contract-abi.json
   - App.css (optional for styling)
   - package.json


3. Install dependencies by running in the terminal:
   npm install

4. If you get an error about "react-scripts", also install it:
   npm install react-scripts

USAGE:
1. Start the development server:
   npm start

2. Open your browser and navigate to:
   http://localhost:3000

3. Make sure MetaMask is:
   - Installed in your browser
   - Connected to the same network where your contract is deployed
   - Unlocked with an account

4. In the web application:
   a. Click "Connect Wallet" to connect MetaMask
   b. Click "View Contract Info" to fetch contract data
   c. View the displayed information:
      - Item Name
      - Listing Price
      - Sent Status
      - Received Status
      - Buyer Address

NOTES:
- The contract address in App.js is currently set to: 0xa596045F3d2567cE60765E7305fA1d1c1e091185
- Update this address in App.js if you want to interact with a different contract
- The contract could be deployed with for example remix ide
- Ensure your MetaMask is connected to the correct network (the chain where the contract is deployed)
- The ABI (Application Binary Interface) is already provided in contract-abi.json

TROUBLESHOOTING:
1. If you see "Please install MetaMask!", install the MetaMask extension
2. If connection fails, check MetaMask is unlocked and on the correct network
3. If contract data doesn't load, verify the contract address and network
4. For build issues, ensure all dependencies are installed with correct versions
