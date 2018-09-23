var ZombieOwnership = artifacts.require("./basictoken.sol");

module.exports = function(deployer) {
  deployer.deploy(ZombieOwnership, 1000);
};
