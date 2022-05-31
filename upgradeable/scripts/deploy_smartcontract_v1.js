const { ethers, upgrades } = require("hardhat");

const SmartContract = await ethers.getContractFactory("SmartContract");

const smartcontract = await upgrades.deployProxy(
  SmartContract,
  _Coin,
  _adminAddress,
  amount,
  { initializer: "initialize" }
);

await smartcontract.deployed();

console.log("SmartContract deployed to:", smartcontract.address);

main();
