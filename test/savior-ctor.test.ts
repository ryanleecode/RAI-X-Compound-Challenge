import { ethers } from 'hardhat'
import { test } from 'mocha'
import { expect, assert, default as chai } from 'chai'
import chaiAsPromised from 'chai-as-promised'
import { CompoundReserveSafeSaviourFactory } from '../typechain'
import * as fc from 'fast-check'

const zeroOrOneEthAddr = fc
  .bigUintN(1)
  .map(ethers.BigNumber.from)
  .map((t) => t.toHexString().padEnd(42, '0'))
  .map(ethers.utils.getAddress)

describe('CompoundReserveSafeSaviourCtor', () => {
  let compoundReserveSafeSaviourFactory: CompoundReserveSafeSaviourFactory

  beforeEach(async () => {
    chai.use(chaiAsPromised)

    const signers = await ethers.getSigners()
    const [deployer, ..._] = signers
    assert(deployer)

    compoundReserveSafeSaviourFactory = new CompoundReserveSafeSaviourFactory(
      deployer,
    )
  })

  test('constructor parameter null sanitization', async () => {
    await fc.assert(
      fc.asyncProperty(
        zeroOrOneEthAddr,
        zeroOrOneEthAddr,
        zeroOrOneEthAddr,
        zeroOrOneEthAddr,
        zeroOrOneEthAddr,
        zeroOrOneEthAddr,
        async (
          collateralJoin,
          liquidationEngine,
          oracleRelayer,
          safeEngine,
          safeManager,
          saviourRegistry,
        ) => {
          const contractAddresses = new Set([
            collateralJoin,
            liquidationEngine,
            oracleRelayer,
            safeEngine,
            safeManager,
            saviourRegistry,
          ])

          if (
            contractAddresses.has('0x0000000000000000000000000000000000000000')
          ) {
            await expect(
              compoundReserveSafeSaviourFactory.deploy(
                collateralJoin,
                liquidationEngine,
                oracleRelayer,
                safeEngine,
                safeManager,
                saviourRegistry,
                '10',
                '10',
                '10',
                '10',
              ),
            ).to.eventually.be.rejectedWith(
              /GeneralTokenReserveSafeSaviour\/null-/,
            )
          }
        },
      ),
    )
  })
})
