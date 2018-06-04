pragma solidity ^0.4.24;
pragma experimental ABIEncoderV2;

import {RequestStorage} from "./RequestStorage.sol";
import {DeviceAccessControl} from "./DeviceAccessControl.sol";


/// @title Node Registration
contract BehaviorManagement is RequestStorage {
    /*
    * @author Austin Hester
    * @dev For use in the Registration Dapp
    */

    constructor() public {
        require(msg.sender != 0x0);
    }

    function getBehaviorsByDevice(
        address _device_id
    ) public view returns (Request[]) {

    }

    function getBehaviorByRequestID(
        address _request_id
    ) public view returns (Request) {
        
    }

}
