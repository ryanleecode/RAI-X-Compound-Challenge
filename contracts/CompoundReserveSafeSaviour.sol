// SPDX-License-Identifier: MIT
pragma solidity 0.6.7;

import "../submodules/geb-safe-saviours/src/interfaces/SafeSaviourLike.sol";

contract CompoundReserveSafeSaviour is SafeSaviourLike {
    constructor() public {}

    function saveSAFE(
        address,
        bytes32,
        address
    )
        external
        virtual
        override
        returns (
            bool,
            uint256,
            uint256
        )
    {
        // TODO: Not Implemented
    }

    function getKeeperPayoutValue() public override returns (uint256) {
        // TODO: Not Implemented
    }

    function keeperPayoutExceedsMinValue() public override returns (bool) {
        // TODO: Not Implemented
    }

    function canSave(address) external override returns (bool) {
        // TODO: Not Implemented
    }

    function tokenAmountUsedToSave(address) public override returns (uint256) {
        // TODO: Not Implemented
    }
}
