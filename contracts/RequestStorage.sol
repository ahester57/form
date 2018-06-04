pragma solidity ^0.4.24;
pragma experimental ABIEncoderV2;

import {ResourceTypes} from "./ResourceTypes.sol";
import {Ownable} from "./Ownable.sol";


contract RequestStorage is Ownable {

	struct Request {
		address request_id;
		address device_id;
		ResourceTypes.ResourceRanges resource_ranges;
		uint256 received_timestamp;
		uint256 authorized_timestamp;	
		bool isHandledByEdge;
		address prev_request_id;
		bool isAccepted;
		bool exists;
	}

	// map device address to request.
	//mapping
	// Actually, we need a db like storage which we can query 
	// and filter. I'll look into this.
	uint256 num_requests;

	mapping(address => Request) mRequests;
	mapping(address => address[]) mMapDeviceToRequests;
	address[] mDeviceRequests;	

	constructor() public {
		num_requests = 0;
	}

	function getRequestObject(
		address _request_id
	) public view returns (Request) {
		require(mRequests[_request_id].exists);
		return mRequests[_request_id];
	}

	function makeRequestObject(

	) public pure returns (Request) {
		// uint256 timestamp = block.timestamp
	}

	function updateRequestObject(
		Request _new_request
	) public {
		// update	
	}

	function storeRequestObject(
		Request _new_request
	) public {

		num_requests += 1;
	}

}
