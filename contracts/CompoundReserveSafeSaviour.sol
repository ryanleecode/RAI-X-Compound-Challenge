// SPDX-License-Identifier: MIT

pragma solidity 0.6.7;

import "../submodules/geb-safe-saviours/src/interfaces/SafeSaviourLike.sol";

contract CompoundReserveSafeSaviour is SafeSaviourLike {
    // Amount of collateral deposited to cover each SAFE
    mapping(address => uint256) public collateralTokenCover;
    // The collateral join contract for adding collateral in the system
    CollateralJoinLike public collateralJoin;
    // The collateral token
    ERC20Like public collateralToken;

    constructor(
        address collateralJoin_,
        address liquidationEngine_,
        address oracleRelayer_,
        address safeEngine_,
        address safeManager_,
        address saviourRegistry_,
        uint256 keeperPayout_,
        uint256 minKeeperPayoutValue_,
        uint256 payoutToSAFESize_,
        uint256 defaultDesiredCollateralizationRatio_
    ) public {
        require(
            collateralJoin_ != address(0),
            "GeneralTokenReserveSafeSaviour/null-collateral-join"
        );
        require(
            liquidationEngine_ != address(0),
            "GeneralTokenReserveSafeSaviour/null-liquidation-engine"
        );
        require(
            oracleRelayer_ != address(0),
            "GeneralTokenReserveSafeSaviour/null-oracle-relayer"
        );
        require(
            safeEngine_ != address(0),
            "GeneralTokenReserveSafeSaviour/null-safe-engine"
        );
        require(
            safeManager_ != address(0),
            "GeneralTokenReserveSafeSaviour/null-safe-manager"
        );
        require(
            saviourRegistry_ != address(0),
            "GeneralTokenReserveSafeSaviour/null-saviour-registry"
        );
        require(
            keeperPayout_ > 0,
            "GeneralTokenReserveSafeSaviour/invalid-keeper-payout"
        );
        require(
            defaultDesiredCollateralizationRatio_ > 0,
            "GeneralTokenReserveSafeSaviour/invalid-default-cratio"
        );
        require(
            payoutToSAFESize_ > 1,
            "GeneralTokenReserveSafeSaviour/invalid-payout-to-safe-size"
        );
        require(
            minKeeperPayoutValue_ > 0,
            "GeneralTokenReserveSafeSaviour/invalid-min-payout-value"
        );

        keeperPayout = keeperPayout_;
        payoutToSAFESize = payoutToSAFESize_;
        minKeeperPayoutValue = minKeeperPayoutValue_;

        liquidationEngine = LiquidationEngineLike(liquidationEngine_);
        collateralJoin = CollateralJoinLike(collateralJoin_);
        oracleRelayer = OracleRelayerLike(oracleRelayer_);
        safeEngine = SAFEEngineLike(safeEngine_);
        safeManager = GebSafeManagerLike(safeManager_);
        saviourRegistry = SAFESaviourRegistryLike(saviourRegistry_);
        collateralToken = ERC20Like(collateralJoin.collateral());

        uint256 scaledLiquidationRatio =
            oracleRelayer.liquidationCRatio(collateralJoin.collateralType()) /
                CRATIO_SCALE_DOWN;

        require(
            scaledLiquidationRatio > 0,
            "GeneralTokenReserveSafeSaviour/invalid-scaled-liq-ratio"
        );
        require(
            both(
                defaultDesiredCollateralizationRatio_ > scaledLiquidationRatio,
                defaultDesiredCollateralizationRatio_ <= MAX_CRATIO
            ),
            "GeneralTokenReserveSafeSaviour/invalid-default-desired-cratio"
        );
        require(
            collateralJoin.decimals() == 18,
            "GeneralTokenReserveSafeSaviour/invalid-join-decimals"
        );
        require(
            collateralJoin.contractEnabled() == 1,
            "GeneralTokenReserveSafeSaviour/join-disabled"
        );

        defaultDesiredCollateralizationRatio = defaultDesiredCollateralizationRatio_;
    }

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
