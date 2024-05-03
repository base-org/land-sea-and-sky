import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";
import { ethers } from "hardhat";

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre;
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  const argumentValues = [
    "Singapore Base Frames Hackathon 2024", // Name
    "SBFJ24", // Symbol
    "QmbyUzL8DW37TDoU6K3eNPSLxdqYzk15R9TpWDgYvuqwWk", // IPFS Hash
    "Singapore Base Frames Hackathon 2024", // Description
  ];

  const DeployedContract = await deploy("SingaporeBaseFrames24", {
    from: deployer,
    contract: "HackathonMinter",
    args: argumentValues,
  });

  const deployedContract = await ethers.getContractAt(
    "HackathonMinter",
    DeployedContract.address
  );

  await deployedContract.addAllowed(
    "0x4d120d7d8019c7616d4e14249fb696c6a5fe0b6b"
  ); // Qi Wu

  await hre.run("verify:verify", {
    address: DeployedContract.address,
    constructorArguments: argumentValues,
    contract: "contracts/HackathonMinter.sol:HackathonMinter",
  });
};
export default func;
