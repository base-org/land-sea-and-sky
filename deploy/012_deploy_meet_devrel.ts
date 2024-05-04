import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";
import { ethers } from "hardhat";

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre;
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  const argumentValues = [
    "Meet Base DevRel", // Name
    "MBD", // Symbol
    "QmRsQCyTEALYnHvBupEcs2ofzeeswDEEGNt9uoBL7wHnKQ", // IPFS Hash
    "Thanks for connecting with us!", // Description
  ];

  const DeployedContract = await deploy("MeetBaseDevRel", {
    from: deployer,
    contract: "SoulboundSignatureMint",
    args: argumentValues,
  });

  const deployedContract = await ethers.getContractAt(
    "SoulboundSignatureMint",
    DeployedContract.address
  );


  await hre.run("verify:verify", {
    address: DeployedContract.address,
    constructorArguments: argumentValues,
    contract: "contracts/SoulboundSignatureMint.sol:SoulboundSignatureMint",
  });
};
export default func;
