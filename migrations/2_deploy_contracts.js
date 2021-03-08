const CompoundReserveSafeSaviour = artifacts.require(
  'CompoundReserveSafeSaviour',
)

module.exports = function (deployer) {
  deployer.deploy(CompoundReserveSafeSaviour)
}
