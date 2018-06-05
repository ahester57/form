pragma solidity ^0.4.24;
pragma experimental ABIEncoderV2; 

import {DeviceStorage} from "./DeviceStorage.sol";
import {Ownable} from "./Ownable.sol";


/// @title Node Registration
contract DeviceReg is Ownable {
    /*
    * @author Austin Hester
    * @dev For use in the Registration Dapp
    */

    address _deviceStorage;

    constructor(address _ds) public {
        require(msg.sender != 0x0);
        _deviceStorage = _ds;
    }

    // Register user with given info
    // Revert o alredy registered
    function registerDevice(
        address _device_id,
        uint8 _priority,
        string _MAC
    ) public {
        require(msg.sender != 0x0);
        DeviceStorage ds = DeviceStorage(_deviceStorage);
        require(!ds.isRegistered(_device_id));
        /*DeviceStorage.Device memory newDevice = ds.makeDeviceObject(
            _device_id,
            _priority,
            _MAC 
        );*/
        //ds.storeDevice(newDevice);
       // assert(ds.isRegistered(_device_id));
    }

}
