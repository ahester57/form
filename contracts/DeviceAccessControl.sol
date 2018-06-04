pragma solidity ^0.4.24;
pragma experimental ABIEncoderV2;

import {DeviceStorage} from "./DeviceStorage.sol";
import {RequestStorage} from "./RequestStorage.sol";
import {Ownable} from "./Ownable.sol";


/// @title Node Registration
contract DeviceAccessControl is Ownable {
    /*
    * @author Austin Hester
    * @dev For use in the Registration Dapp
    */

    constructor() public {
        require(msg.sender != 0x0);
    }

    function authorizeRequest(
        RequestStorage.Request _request
    ) public onlyOwner {
        // 
    }

    function updateRequestInfo(
        RequestStorage.Request _request
    ) public onlyOwner {
        // 
    }

    function updateDeviceInfo(
        DeviceStorage.Device _device
    ) public onlyOwner {
        // 
    }

}
