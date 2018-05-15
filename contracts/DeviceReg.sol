pragma solidity ^0.4.23;
pragma experimental ABIEncoderV2;

import {DeviceStorage} from "./DeviceStorage.sol";
import {Ownable} from "./Ownable.sol";


/// @title Node Registration
contract DeviceReg is Ownable, DeviceStorage() {
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
        address _device_id,
        uint8 _priority,
        string _MAC
    ) public {
        require(msg.sender != 0x0);
        require(!isRegistered(_device_id));
        Device memory newDevice = makeDeviceObject(
            _device_id,
            _priority,
            _MAC 
        );
        storeDevice(newDevice);
        assert(isRegistered(_device_id));
    }

    function getDeviceInfo(
        address device_id
    ) public view returns (
        uint8 priority,
        string MAC
    ) {
        require(device_id != address(0));
        Device memory d = getDeviceObject(device_id);
        return (d.priority, d.MAC);
    }

    // Is this device registered
    /// @param _of bytes32
    /// @return boolean
    function isRegistered(
        address _of
    ) public view returns (bool) {
        require(_of != address(0));
        Device memory d = getDeviceObject(_of);
        return d.isRegistered;
    }

    // Is this device registered
    /// @param _of bytes32
    /// @return boolean
    function isBlocked(
        address _of
    ) public view returns (bool) {
        require(_of != address(0));
        Device memory d = getDeviceObject(_of);
        return d.isBlocked;
    }

}
