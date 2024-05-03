import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre;
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  const argumentValues = [
    "Base Bootcamp Mentor", // Name
    "BBM", // Symbol
    "QmWQh28UdFUyKd7fRPbTN8ieeVfW7Dz9Qn6XdExP3DnUzU", // IPFS Hash
    "Thank you for serving as a mentor for Base Bootcamp!", // Description
  ];

  const DeployedContract = await deploy("BaseBootcampMentor", {
    from: deployer,
    contract: "HackathonMinter",
    args: argumentValues,
  });

  await hre.run("verify:verify", {
    address: DeployedContract.address,
    constructorArguments: argumentValues,
    contract: "contracts/HackathonMinter.sol:HackathonMinter",
  });
};
export default func;
