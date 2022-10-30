const Lands = artifacts.require("Lands");

module.exports = async function (deployer) {
  await deployer.deploy(Lands);
};
