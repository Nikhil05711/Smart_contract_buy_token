const { ethers, upgrades } = require("hardhat");

const Token = await ethers.getContractFactory("Token");

const token = await upgrades.deployProxy(Token, { initializer: "initialize" });

await token.deployed();

console.log("Token deployed to:", token.address);

main();
