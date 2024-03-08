import {HardhatRuntimeEnvironment} from 'hardhat/types';
import {DeployFunction} from 'hardhat-deploy/types';

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre;
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
    
  const argumentValues = [
    "0x83957ef9df51257bD59743FcBde02f2752d6498D",
    2222,
    "Test Token, Please Ignore",
    "TST",
    "Qmaj9pFQJpsaLjRE2t6PmWEm78ogniDg9ZDPTCGLn8tkBi",
    "This is only a test!",
  ]
    
  const LimitedAirdropMinter = await deploy("LimitedAirdropMinter", {
    from: deployer,
    args: argumentValues
  });

  await hre.run("verify:verify", {
    address: LimitedAirdropMinter.address,
    constructorArguments: argumentValues,
    contract: "contracts/LimitedAirdropMinter.sol:LimitedAirdropMinter"
  });
};
export default func;
