var EternalStorage = artifacts.require("./EternalStorage.sol");
var DeviceStorage = artifacts.require("./DeviceStorage.sol");
var DeviceReg = artifacts.require("./DeviceReg.sol");

module.exports = function(deployer) {
  return deployer.deploy(EternalStorage).then(function() {
	return EternalStorage.deployed().then((i) => {
		console.log(i.address);
	  return deployer.deploy(DeviceStorage, i.address)
  	});

  })
};
