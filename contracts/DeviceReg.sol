pragma solidity ^0.4.23;
pragma experimental ABIEncoderV2;

import {DeviceStorage} from "./DeviceStorage.sol";


/// @title Node Registration
contract DeviceReg is DeviceStorage() {
    /*
    * @author Austin Hester
    * @dev For use in the Registration Dapp
    */

    constructor() public {
        require(msg.sender != 0x0);
    }

    // Register user with given info
    // Revert o alredy registered
    function registerDevice(
        string _address,
        uint8 _class,
        uint8 _priority,
        uint8[] _categories,
        uint8[] _req_types,
        string[] _pastBehaviors, 
        string _MAC
    ) public {
        require(msg.sender != 0x0);
        require(!isRegistered(_address));
        Device memory newDevice = makeDeviceObject(
            _address,
            _class,
            _priority,
            _categories,
            _req_types,
            _pastBehaviors,
            _MAC 
        );
        storeDevice(newDevice);
        assert(isRegistered(_address));
    }

    function getDeviceInfo(
        string _of
    ) public view returns (
        string _address,
        uint8 _class,
        uint8 _priority,
        uint8 _category,
        string _MAC
    ) {
        require(!strcmp(_of, ""));
        Device memory d = getDeviceObject(_of);
	uint8 cat;
	if (d.categories.length == 0) {
		cat = 0;
	} else {
		cat = d.categories[0];
	}
        return (d._address, d.class, d.priority, cat, d.MAC);
    }

    // Is this device registered
    /// @param _of bytes32
    /// @return boolean
    function isRegistered(
        string _of
    ) public view returns (bool) {
        require(!strcmp(_of, ""));
        Device memory d = getDeviceObject(_of);
        return d.isRegistered;
    }

}
