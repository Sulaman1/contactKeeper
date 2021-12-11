const RewardToken = artifacts.require('RewardToken')

module.exports = async function (callback) {

    let rewardToken = await RewardToken.deployed()
    await rewardToken.issueToken()
    // Code goes here...
    console.log("Tokens issued")
    callback()
}
