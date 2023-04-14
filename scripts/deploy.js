const main = async () => {
  // Here <hre< is injected automatically by hardhat, no need to import it explicitly.
  const DevToken = await hre.ethers.getContractFactory("AOTTokens");
  // Any value passed to deploy() will be passed to contructor of our contract as parameters.

  const devToken = await DevToken.deploy();

  // <deploy()< in previous line deploys the contract.
  // <deployed() in next line checks if contract is deployed.
  await devToken.deployed();

  // Once deployed (in 20-30 seconds) you will see the contract address in console. You can also check the transaction on etherscan goerli network.
  console.log("Contract deployed to: ", devToken.address);
};

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
