import {HardhatRuntimeEnvironment} from 'hardhat/types';
import {DeployFunction} from 'hardhat-deploy/types';

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre;
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
    
  const argumentValues = [
    1710518400,
    "Frames of the Future",
    "FRAME",
    "QmWDZBzUSrM24c8v59XYhfNdtLFWndpNtqYTWCNnKgTaQ2",
    "Base celebrates the launch of transactions in Farcaster frames, unlocking the next wave of innovation in onchain experiences.",
  ];
    
  const SoulboundFreeTimedMint = await deploy("SoulboundFreeTimedMint", {
    from: deployer,
    args: argumentValues,
  });

  await hre.run("verify:verify", {
    address: SoulboundFreeTimedMint.address,
    constructorArguments: argumentValues,
    contract: "contracts/SoulboundFreeTimedMint.sol:SoulboundFreeTimedMint",
  });
};
export default func;
