var DeviceStorage = artifacts.require("./DeviceStorage.sol");
var DeviceReg = artifacts.require("./DeviceReg.sol");

module.exports = function(deployer) {
  deployer.deploy(DeviceStorage);
  deployer.deploy(DeviceReg);
};
