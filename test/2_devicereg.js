var DeviceReg = artifacts.require("DeviceReg");

contract('DeviceReg', function(accounts) {
    var instance;
    DeviceReg.deployed().then((rinst) => {
        //console.log(rinst);
        instance = rinst;
    });

    // DeviceReg a new user
    it("should register a new device", function() {
        var t = [];
        return instance.registerDevice(
            "0x28",
            2,
            101,
            t,
            t,
            t,
            "MA:CA:DD:RE:SS",
            {from: accounts[0]}
        )
        .then((result) => {
            return instance.getDeviceMAC.call("0x28")
            .then((mac) => {
                assert.equal(mac, "MA:CA:DD:RE:SS",
                                "new device registration failed");
            });
        });
    });
    // This should NOT work. Sometimes your local client will not
    // like this one. Using geth works fine. Sometimes
    // ganache will throw an error and this test fails. That is normal.
    it("should not allow that device to re-register", function() {
        return instance.isRegistered.call("0x28")
        .then((result) => {
                assert.equal(result, true,
                                "new device registered again, wrongly");
        });
    });
});
