import {HardhatRuntimeEnvironment} from 'hardhat/types';
import {DeployFunction} from 'hardhat-deploy/types';

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre;
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
    
  const argumentValues = [
    "0xac5b774D7a700AcDb528048B6052bc1549cd73B9",
    3333,
    "Test Token, Please Ignore",
    "TST",
    "QmNSoY62TSvLQ8hp8s1U5ShUZpeiPRrv4huMXWnCh3Euee",
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
