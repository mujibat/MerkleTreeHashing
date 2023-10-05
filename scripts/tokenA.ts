import { ethers } from "hardhat";


async function main() { 

  const TokenContract = await ethers.deployContract("TokenA", [1]);

  await TokenContract.waitForDeployment();

  console.log(
    `TokenContract with deployed to ${TokenContract.target}`
  );
  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});