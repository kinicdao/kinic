# Kinic
## Search re-imagined for web3.

Web3 is all about ownership. We believe that content creators should be rewarded for their contributions to web3.

- Big tech eats most of web2 Ad revenue, even though it is not their content!
- We use 'smart-code' to map all of the frontend canisters on the Internet Computer.
- This allows us to do ✨Magic ✨ with that data.

## Features

- Search engine for text and canister IDs. (Frontend canisters only *for now.)
- Advertiser space for each category. Bid on with ICP.
- Profit sharing with content site owners. *WIP: still working on making this tamper proof. Potentially could work with an SNS token and user votes.

## Tech

Kinic uses a number of open source projects to work properly:

- Motoko - IC backend programming language.
- Vue.js - Javascript framework.
- Tailwind.css - Beautiful designs fast.
- DFX - developer tool for the IC.


## Installation

Kinic requires [Node.js](https://nodejs.org/) v16.7+ to run.

Install the dependencies and start the server.

```sh
npm i // install dependencies
dfx deploy // deploy to your local dfx
vite serve // serves locally
```
## Limitations

Motoko does not have a canister info method which shows the canisters' owner.
Due to this we need to check ownership for 'claimed' sites using an API.
```
dfx canister --no-wallet --network ic info
```
Search and indexing are also done via API.

## SEO

Sites are indexed for keywords that have the best match. An example would be `blog bulgaria ICP`. When a user searches the results with keywords or text matches are returned. Categories are also applied to each site. 

Sites that are 'claimed' show near the top of results. This is to push staging and other WIP sites down in the search results. 

Sites with more content generally show higher in search results. 

## License

To Be Determined.. please change branding if you spin up a copy and want to market it. 

**Free Software: created for Dfinity Hackathon! Feel free to use parts or the whole portion of this codebase as an example for our work.**
