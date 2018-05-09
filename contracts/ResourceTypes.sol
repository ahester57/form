pragma soldity ^0.4.23;


library ResourceTypes {

    struct ResourceRanges {
        // Hardware Info
        uint256 cpu_min;
        uint256 cpu_max;
        uint256 memory_min;
        uint256 memory_max;
        uint256 storage_min;
        uint256 storage_max;
        uint256 bandwith_min;  
        uint256 bandwith_max;
    }

}