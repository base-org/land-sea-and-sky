import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";
import { ethers } from "hardhat";

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre;
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  const argumentValues = [
    "Base @ FarHack 2024", // Name
    "BFC24", // Symbol
    "QmQmgBTcXSrAVd1yuhuyN5hk8PfzfKihneG6nj5sKN6svk", // IPFS Hash
    "Base @ FarHack 2024", // Description
  ];

  const DeployedContract = await deploy("BaseAtFarHack", {
    from: deployer,
    contract: "HackathonMinter",
    args: argumentValues,
  });

  const deployedContract = await ethers.getContractAt(
    "HackathonMinter",
    DeployedContract.address
  );

  await deployedContract.addAllowed(
    "0x95e32ba428421a24d77ddcc882696330161963b2"
  ); // Taylor
  await deployedContract.addAllowed(
    "0x01658f5d899e03492dC832C8eE8839FFD80b7f09"
  ); // Carl
  await deployedContract.addAllowed(
    "0x836fa72d2af55d698e8767acbe88c042b8201036"
  ); // Ryan
  await deployedContract.addAllowed(
    "0x058F4718624fCC5006d89ecC8c76E5bAf5320590"
  ); // Ryan Alt

  await hre.run("verify:verify", {
    address: DeployedContract.address,
    constructorArguments: argumentValues,
    contract: "contracts/HackathonMinter.sol:HackathonMinter",
  });
};
export default func;
