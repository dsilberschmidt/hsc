# Historical Stable Coin

Historical Stable Coin is a 2022 Web3 prototype exploring how a smart contract could reason about inflation-adjusted value across time rather than only spot prices.

The project originated in the context of a Celo hackathon as the idea of a coin that would preserve purchasing power by tracking accumulated inflation. It later evolved into a Chainlink-based prototype submitted to the **Chainlink Spring 2022 Hackathon** as **“Oracle for an historical stable coin”**.

## Core idea

Instead of asking only for a current price, the project asks a different question:

**Can a smart contract query accumulated inflation from an arbitrary historical start date and use that value on-chain?**

That idea led to two related contract experiments:

- `contracts/Inflation.sol` — direct Chainlink request to retrieve inflation data from Nasdaq Data Link
- `contracts/InflationEA.sol` — Chainlink request to a custom external adapter that computes accumulated inflation from a configurable `startDate`

The second contract is the more representative one for the project.

## Architecture

`InflationEA.sol` follows this flow:

smart contract → Chainlink request → external adapter → historical inflation dataset → accumulated inflation calculation → result stored on-chain

The contract keeps a configurable historical date such as `2004-01-01`, sends that date to the adapter, and receives a cumulative inflation value in `accumulatedInflation`.

## Repository contents

- `contracts/Inflation.sol` — direct inflation-data request contract
- `contracts/InflationEA.sol` — accumulated-inflation contract using an external adapter
- `scripts/deploy.js` — deployment script kept as part of the original prototype
- `data` — sample dataset response used during development
- `hardhat.config.js` — historical Hardhat/Kovan configuration
- `package.json` — minimal project metadata and compile script

## Related repository

The companion external adapter lives here:

- `ExternalAdapterInflation`: https://github.com/dsilberschmidt/ExternalAdapterInflation

## Public submission

- Devpost: https://devpost.com/software/oracle-for-an-historical-stable-coin

## Tech stack

- Solidity
- Hardhat
- Chainlink
- JavaScript / Node.js
- Nasdaq Data Link
- Heroku

## Current state

This repository has been cleaned to preserve the actual project logic and remove Hardhat boilerplate.

It currently:
- keeps only the contracts and scripts relevant to the project
- compiles successfully in its present form
- preserves the original Kovan-era setup as historical context

It does **not** represent a current production deployment.

Some parts depend on infrastructure and assumptions from 2022, including:
- Kovan-specific configuration
- legacy Chainlink oracle/job setup
- an external adapter flow tied to a historical Heroku deployment
- a data source path that is currently not reliably accessible from the present environment

## Why it matters

Even as a prototype, the project captures a useful design direction for Web3:

- bringing macroeconomic historical data on-chain
- computing accumulated inflation rather than a single datapoint
- exploring monetary logic aimed at preserving purchasing power across time

## Historical note

This project is best understood as an early prototype and conceptual artifact from 2022 rather than a maintained product. Its value today is mainly as a documented technical experiment and as the seed of the broader Historical Stable Coin idea.

## Author

dsilberschmidt
