import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre;
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  const argumentValues = [
    "Base Hackathon @ ETH Bucharest 2024",
    "BHETHB24",
    "Qmb1DbfbdENi3ctourKLu3mSZucAbPMANsNLUhFKpR15ea",
    "Hackathon participant NFT for the Base Hackathon @ ETH Bucharest 2024.",
  ];

  const ETHBucharest24 = await deploy("EthBucharest24", {
    from: deployer,
    contract: "HackathonMinter",
    args: argumentValues,
  });

  await hre.run("verify:verify", {
    address: ETHBucharest24.address,
    constructorArguments: argumentValues,
    contract: "contracts/HackathonMinter.sol:HackathonMinter",
  });
};
export default func;
