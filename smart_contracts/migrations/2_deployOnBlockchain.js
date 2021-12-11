const MarriageContract = artifacts.require("MarriageContract");
const CertCoin = artifacts.require("CertCoin");
const RewardToken = artifacts.require("RewardToken");

module.exports = async function (deployer, network, accounts) {
    await deployer.deploy(MarriageContract);

    await deployer.deploy(CertCoin);
    const certCoin = await CertCoin.deployed();
    certCoin.mint(accounts[0], '100000000000000000000');

    await deployer.deploy(RewardToken, certCoin.address);
    const rewardToken = await RewardToken.deployed();
};
