# Historical Stable Coin (HSC)

Prototype of a Solidity/Chainlink system designed to bring historical USD inflation data on-chain.

This repository explores a simple idea: if a smart contract can query accumulated inflation from an arbitrary historical start date, it becomes possible to reason more explicitly about inflation-adjusted value, historical purchasing power, and stable-value mechanisms.

This project was originally developed and submitted as **“Oracle for an historical stable coin”** in the **Chainlink Spring 2022 Hackathon**.

## What this repository contains

This repo includes two related experiments:

- `contracts/Inflation.sol`: a contract that requests U.S. inflation data from Nasdaq Data Link through Chainlink.
- `contracts/InflationEA.sol`: a contract that requests **accumulated inflation from a configurable historical start date** through a custom external adapter.

The second path is the more important one for the project idea: instead of querying a single inflation datapoint, it computes inflation accumulated since a chosen date and makes that value available on-chain.

## Main idea

The contract `InflationEA.sol` stores a `startDate` and sends a Chainlink request to an external adapter endpoint.

Example flow:

1. choose a historical start date, such as `2004-01-01`
2. request accumulated USD inflation from that date onward
3. receive the result on-chain in `accumulatedInflation`

This was part of a broader exploration around a possible **historical stable coin** or inflation-aware economic logic in Web3.

## Architecture

Smart contract (`InflationEA.sol`)
→ Chainlink request
→ external adapter
→ Nasdaq inflation dataset
→ accumulated inflation calculation
→ result returned on-chain

## Repository structure

- `contracts/Inflation.sol` — direct Chainlink request for inflation data
- `contracts/InflationEA.sol` — Chainlink + external adapter version
- `scripts/` — deployment scripts for the prototype
- `test/` — currently incomplete and still contains sample Hardhat material
- `ExternalAdapterInflation` — separate repository for the custom external adapter used by this prototype

## Tech stack

- Solidity
- Hardhat
- Chainlink
- JavaScript / Node.js
- Nasdaq Data Link
- Heroku (historical deployment used in the prototype)

## Historical context

This project was built in an earlier Chainlink/Kovan-era setup.

Because of that, some implementation details are now historical rather than production-ready, including:

- Kovan-specific configuration
- legacy oracle/job setup
- a Heroku endpoint used by the adapter flow

So this repository should be read as a **prototype / research artifact**, not as a current production deployment.

## Why it is interesting

Even in prototype form, the project captures a useful design direction:

- connecting off-chain macroeconomic data to smart contracts
- computing historical accumulated inflation instead of reading only a spot value
- experimenting with inflation-aware economic primitives in Web3

## Current status

This repository is preserved as a technical prototype.

It still needs cleanup to become a polished public demo, especially:

- removal of leftover Hardhat sample files
- proper tests for the inflation contracts
- fuller documentation of the adapter flow
- migration to current networks and tooling

## Related repository

The external adapter used by this project lives in a separate repository:

- `ExternalAdapterInflation`: https://github.com/dsilberschmidt/ExternalAdapterInflation

## Hackathon submission

Public submission page:

- https://devpost.com/software/oracle-for-an-historical-stable-coin

## Author

Daniel Silberschmidt