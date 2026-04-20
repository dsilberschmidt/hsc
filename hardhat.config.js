require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
require("dotenv").config();

module.exports = {
  solidity: "0.8.12",
  etherscan: {
    apiKey: process.env.ETHERSCAN_KEY
  },
  networks: {
    sepolia: {
      url: process.env.SEPOLIA_URL,
      chainId: 11155111,
      accounts: [process.env.PRIVATE_KEY]
    }
  }
};
