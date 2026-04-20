# Historical Stable Coin

Historical Stable Coin is a 2022 Web3 prototype exploring how a smart contract could reason about inflation-adjusted value across time rather than only spot prices.

The project originated in the context of a Celo hackathon as the idea of a coin that would preserve purchasing power by tracking accumulated inflation. It later evolved into a Chainlink-based prototype submitted to the **Chainlink Spring 2022 Hackathon** as **“Oracle for an historical stable coin”**.

## Core idea

Instead of asking only for a current price, the project asks a different question:

**Can a smart contract query accumulated inflation from an arbitrary historical start date and use that value on-chain?**

That idea led to two related contract experiments:

- `contracts/Inflation.sol` — direct Chainlink request to retrieve inflation data from the original prototype path
- `contracts/InflationEA.sol` — Chainlink request to a custom external adapter that computes accumulated inflation from a configurable `startDate`

The second contract is the more representative one for the project.

## Architecture

`InflationEA.sol` follows this flow:

smart contract → Chainlink request → external adapter → inflation source → accumulated inflation calculation → result stored on-chain

The contract keeps a configurable historical date such as `2004-01-01`, sends that date to the adapter, and receives a cumulative inflation value in `accumulatedInflation`.

## Repository contents

- `contracts/Inflation.sol` — direct inflation-data request contract
- `contracts/InflationEA.sol` — accumulated-inflation contract using an external adapter
- `scripts/deploy.js` — deployment script kept as part of the prototype
- `data` — sample dataset response used during development
- `hardhat.config.js` — deployment / verification configuration
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
- Sepolia
- Render

## Current state

This repository has been cleaned to preserve the actual project logic and remove Hardhat boilerplate.

It currently:
- keeps only the contracts and scripts relevant to the project
- compiles successfully
- points `InflationEA.sol` to a live external adapter deployment
- includes a Sepolia deployment of `InflationEA`
- includes a verified Sepolia contract
- has real on-chain read and write interactions already tested

It does **not** represent a current production deployment.

The original Chainlink oracle/job flow used by the 2022 prototype remains historically relevant, but is not yet fully migrated to a current Sepolia Chainlink request/fulfillment setup.

## Why it matters

Even as a prototype, the project captures a useful design direction for Web3:

- bringing macroeconomic historical data on-chain
- computing accumulated inflation rather than a single datapoint
- exploring monetary logic aimed at preserving purchasing power across time

## Historical note

This project is best understood as an early prototype and conceptual artifact from 2022 rather than a maintained product. Its value today is mainly as a documented technical experiment and as the seed of the broader Historical Stable Coin idea.

Historically, earlier versions of the project used:
- Kovan-era Chainlink configuration
- legacy oracle/job setup
- Nasdaq Data Link
- Heroku deployment paths

Those elements belong to the original prototype history and should not be read as the current live setup.

## Author

dsilberschmidt

## Live endpoints

- External adapter (Render): `https://external-adapter-inflation.onrender.com`
- Sepolia `InflationEA`: `0x1f49F011C08AcCeD9Eea56B029FC00F194e7AE29`
- Sepolia Etherscan: `https://sepolia.etherscan.io/address/0x1f49F011C08AcCeD9Eea56B029FC00F194e7AE29#code`
