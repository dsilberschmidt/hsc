require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
require("dotenv").config();

module.exports = {
  solidity: "0.8.12",
  etherscan: {
    apiKey:process.env.ETHERSCAN_KEY
  },
  networks: {
    kovan: {
      url: process.env.KOVAN_URL,
      accounts: [process.env.PRIVATE_KEY]
    },
  }
};
