// async function deployFunc(hre) {
//     hre.getNamedAccounts
//      hre.deployments
// }
// module.exports.default = deployFunc

module.exports = async ({ getNamedAccounts, deployments }) => {
    const { deploy, log } = deployments
    const { deployer } = await getNamedAccounts()
    const chainId = network.config.chainId
}
