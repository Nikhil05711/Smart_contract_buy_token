// require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-ethers");
require("@openzeppelin/hardhat-upgrades");
require("@nomiclabs/hardhat-etherscan");

module.exports = {
  solidity: "^0.8.13",
  networks: {
    BSC: {
      url: `https://speedy-nodes-nyc.moralis.io/4c56762bf045c4500b62c77f/bsc/testnet`,
      accounts:
        "5327af6faff4eb16e52c95b0e27873627807e875c4a1039d41c159d868afdec6",
    },
    bscscan: {
      APIKEY: "9PHMQNXDC4PK8XVIVVC6WMCZGQ35R7RPDW",
    },
  },
};
