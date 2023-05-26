<template>
<!-- WHITEPAGE -->
<header v-if="whitepaperMode" class="h-full">
        <div class="content px-8 pt-4 pb-2 blackBG" id="top">
            <!-- SEARCH RESULT PAGE NAV -->
            <nav class="flex items-center justify-between mt-1 mb-2 text-4xl font-extrabold leading-none tracking-tight md:text-3xl lg:text-4xl text-white">
                Kinic SNS DAO Whitepaper
            </nav>
        </div>

        <div class="w-full px-8 pt-4">
            <div class="mb-4 rounded-t-1">
                <div section-trigger class="p-4 sm:mx-1 lg:mx-8 leading-normal text-lg">
                    <h2 class="mb-2 pb-2 relative flex items-center w-full text-2xl font-semibold text-left border-b border-solid">
                        Table of Contents
                    </h2>
                    <nav class="space-y-2">
                    <a href="#executive-summary" class="block text-blue-600 font-medium hover:underline">1. Executive Summary</a>
                    <a href="#the-kinic-vision-and-product" class="block text-blue-600 font-medium hover:underline">2. The Kinic Vision and Product</a>
                    <a href="#kinic-dao" class="block text-blue-600 font-medium hover:underline">3. Kinic DAO Launch and Governance</a>
                    <a href="#kinic-token-and-revenue" class="block text-blue-600 font-medium hover:underline">4. Kinic DAO Treasury and Token Utility</a>
                    <a href="#kinic-dao-tokenomics" class="block text-blue-600 font-medium hover:underline">5. Kinic DAO Tokenomics</a>
                    <a href="#launch-allocations-and-mechanics" class="block text-blue-600 font-medium hover:underline">6. Launch Allocations and Mechanics</a>
                    <a href="#legal-disclaimers" class="block text-blue-600 font-medium hover:underline">7. Token Holder Rights and Limitations</a>
                    </nav>
                    <div section-content class="overflow-hidden transition-all ease-soft-in-out duration-350">
                </div>
            </div>
        </div>

        <div class="mb-4 rounded-t-1">
            <div id="executive-summary" section-content class="overflow-hidden transition-all ease-soft-in-out duration-350">
                <div class="p-4 sm:mx-1 lg:mx-12 leading-normal text-lg opacity-80 ">

                <h2 section-trigger class="mb-2 relative flex items-center w-full p-4 text-2xl font-semibold text-left border-b border-solid">
                    1. Executive Summary
                    <a href="#top" class="hidden sm:block absolute right-4 text-sm cursor-pointer text-gray-800">Back to top</a>
                </h2>

                <p class="mb-3">Kinic is the first and only search engine for web3 content that runs on blockchain. </p>
                <p class="mb-3">Kinic the answer to Google and other search engines that are operated by a centralized entity, undermine data privacy, favor established players, and ignore the emerging world of web3 content.</p>
                <p class="mb-3">Currently, Kinic allows you to search all frontend canisters on the Internet Computer blockchain. Kinic’s roadmap includes adding content hosted on other blockchains and decentralized storage networks. Kinic’s SEO module will involve unprecedented transparency backed by zero-knowledge machine learning (ZKML) technology. All users will be able to trust that they are getting the best results as determined by Kinic’s algorithms, and are not being served ad based content other than which is clearly transparent.</p>
                <p class="mb-3">Kinic’s vision will be fulfilled by decentralizing its governance using an on-chain, decentralized autonomous organization (DAO). The DAO will operate using the IC’s unique service nervous system. The Kinic DAO will manage and improve the Kinic software service by voting on proposals.</p>
                <p class="mb-3">To submit proposals and vote, KINIC token holders must lock (“stake”) their tokens into neurons. To incentivize KINIC token holders to stake their tokens into neurons and vote, neurons receive rewards for voting that can be converted to KINIC tokens.</p>
                <p class="mb-3">The treasury controlled by the Kinic DAO will hold KINIC tokens and ICP tokens. KINIC tokens can be used to pay for Kinic's current and upcoming products and services. The Kinic DAO earns ICP as revenue when users purchase KINIC tokens from the DAO. ICP tokens in the DAO’s treasury can be used to fund expenses.</p>
                <p class="mb-3">Tokenomics refers to the initial set up and rules that drive the supply and trading of tokens. The total supply of KINIC tokens upon launch will be 6 million tokens. Minting tokens increases the total supply and burning tokens decreases them. KINIC tokens can only be burned by proposal. A reward rate of 2.5% of the total annual supply will be minted to pay voting rewards. KINIC tokens that are locked in a neuron are not part of the liquid supply.</p>
                <p class="mb-3">The Kinic DAO will launch with a total supply of 6 million KINIC tokens. 25% will be available for open sale in exchange for ICP tokens. 50% of the tokens will remain in the DAO’s treasury. 10% will be allocated to the Kinic development organization and 10% allocated to seed funders. The maximum ICP that can be earned in the sale of the KINIC tokens is 1.5 million ICP. The minimum is 500,000 ICP. 1 KINIC token may be worth between 0.33 and 1 ICP tokens based on the DAO earning between 500,000 and 1.5 million ICP tokens in the decentralization sale.</p>
                </div>
            </div>
        </div>

        <div class="mb-4 rounded-t-1">
            <div section-content class="overflow-hidden transition-all ease-soft-in-out duration-350">
                <div class="p-4 sm:mx-1 lg:mx-8 leading-normal text-lg">

                    <h2 section-trigger id="the-kinic-vision-and-product"
                    class="relative flex items-center w-full p-4 mb-2 text-2xl font-semibold text-left border-b border-solid">
                    2. The Kinic Vision and Product
                    <a href="#top" class="hidden sm:block absolute right-4 text-sm cursor-pointer text-gray-800">Back to top</a>
                    </h2>

                    <p class="mb-3 font-semibold text-xl">Summary</p>
                    <ol class="list-disc list-inside mb-3">
                    <li>Kinic is the first and only search engine for web3 content that runs on blockchain.</li>
                    <li>Kinic is fully functional and runs entirely on blockchain on the smart contract canister located at <a class="blueText" href="https://74iy7-xqaaa-aaaaf-qagra-cai.raw.ic0.app/">https://74iy7-xqaaa-aaaaf-qagra-cai.raw.ic0.app/</a>.</li>
                    <li>Currently, Kinic allows you to search all frontend canisters on the Internet Computer blockchain.</li>
                    <li>Kinic’s proposed roadmap includes adding content hosted on other blockchains and decentralized storage networks, using large language models for advanced web3 search queries.</li>
                    <li>Kinic’s development will focus on the emerging field of ZKML. Not only will our powerful search models run entirely on-chain, they will also be verifiable with zero-knowledge proofs.</li>
                    </ol>
                    <hr class="mb-3"/>

                    <p class="mb-3 font-semibold text-xl">A New Vision for Search</p>
                    <p class="mb-3">The Internet revolution was ushered in by search services making nearly all human knowledge available to anyone in numerous forms of online content. Google has dominated searching for that content for nearly two decades. But because it is operated by a centralized corporation, it has done so by undermining data privacy, favoring established players, and all but ignoring the emerging world of web3 content.</p>
                    <p class="mb-3">In 2021, the Dfinity Foundation launched the Internet Computer (IC) blockchain. The IC is a full-stack, decentralized replacement for traditional corporate cloud servers. Like other public, open-source blockchains, the IC operates on the basis of computational consensus among node computers without any centralized authority. Likewise, the IC is powered by computational units called cycles (similar to gas on Ethereum) that are produced when converted from the IC’s native utility token, ICP.</p>
                    <p class="mb-3">Several unique features, however, arguably make the IC the world’s most powerful blockchain and in many ways the truest embodiment of web3 to date. These features include the following:</p>
                    <ol class="list-decimal list-inside mb-3">
                    <li>
                        IC smart contracts not only execute on-chain transactions but also store content files and other forms of data entirely on chain 
                        <a class="blueText" href="https://internetcomputer.org/how-it-works/smart-contracts-serve-the-web/" target="_blank">(52 gigabytes per smart contract)</a>.
                        These smart contracts are referred to as “canisters”. A primary benefit is that web browsers can directly interact with canister smart contracts.
                    </li>
                    <li>
                        The IC blockchain operates at the 
                        <a class="blueText" href="https://wiki.internetcomputer.org/wiki/Web_Speed" target="_blank">speed of the standard web</a> 
                        and in principle can scale infinitely with the addition of more nodes.
                    </li>
                    <li>
                        Any web browser 
                        <a class="blueText" href="https://wiki.internetcomputer.org/wiki/Web_Serving" target="_blank">can be used</a> 
                        to view content stored on the IC, including websites and the front-end graphics that run inside smart contract canisters.
                    </li>
                    <li>
                        Publishing content to a smart contract can be done anonymously using login credentials such as the IC’s Webauthn-based 
                        <a class="blueText" target="_blank" href="https://wiki.internetcomputer.org/wiki/Internet_Computer_wiki#Internet_Identity_Introduction">Internet Identity</a>.
                    </li>
                    <li>
                        Content can be 
                        <a class="blueText" target="_blank" href="https://internetcomputer.org/docs/current/concepts/trust-in-canisters#complete-immutability">made immutable</a> 
                        (i.e., not deletable) if a smart contract canister is locked.
                    </li>
                    </ol>
                    <p class="mb-3">
                    As a result, the IC is an end-to-end decentralized compute platform and content network where everything takes place, is stored, and published on chain. More information about the IC is available 
                    <a class="blueText" href="https://internetcomputer.org/" target="_blank">here</a>. 
                    Other parts of the web3 ecosystem include decentralized content storage networks that complement the IC by specializing in long-term storage of files that are not frequently accessed. These networks include the Interplanetary File System (IPFS) and Arweave.
                    </p>
                    <p class="mb-3">Content that is hosted on web3 needs a new vision for search. And Kinic provides a profound new vision: search that is fully private, user centric, and built on and for web3. The name Kinic comes from the word kin from kinship.</p>
                    
                    <p class="mb-3 font-bold">Kinic is unlike any other product for several reasons</p>
                    <ol class="list-decimal list-inside mb-3">
                    <li>
                        <b>Runs on chain.</b> Kinic is the only search engine that runs <b>entirely on chain</b> to benefit from the privacy, security, and immutability features of blockchain. Unlike privacy-focused search engines like DuckDuckGo that trust a centralized corporation to maintain user privacy, Kinic must operate according to the privacy-protecting 
                        <a class="blueText" target="_blank" href="https://medium.com/dfinity/the-internet-computer-blockchains-privacy-advantages-73340c6c42db">protocol rules</a> 
                        of the Internet Computer blockchain and its anonymous
                        <a class="blueText" target="_blank" href="https://internetcomputer.org/docs/current/tokenomics/identity-auth/what-is-ic-identity"> login methods</a>.
                    </li>
                    <li>
                        <b>Searches content on web3.</b> Kinic is the only search engine dedicated to searching frontend content <b>on web3</b> as opposed to content about web3 that is on web2 such as 
                        <a class="blueText" href="https://www.kaito.ai/" target="_blank">Kaito</a>.
                    </li>
                    <li>
                        <b>Searches all of web3.</b> Kinic is the only search engine dedicated to searching <b>all</b> frontend content on web3 and not focused only on one web3 network such as 
                        <a class="blueText" href="https://ipfs-search.com/#/" target="_blank">IPFS Search</a>.
                    </li>
                    <li>
                        <b>Searches frontend</b>. Kinic is the only <b>frontend</b> search engine for web3. This is in contrast to backend blockchain and NFT data explorers and indexing protocols such as 
                        <a class="blueText" href="https://thegraph.com/en/" target="_blank">The Graph</a>.
                    </li>
                    </ol>
                    <hr class="mb-3"/>

                    <p class="mb-3 font-semibold text-xl">How Kinic Works</p>
                    <p class="mb-3">Kinic is a dedicated web3 search engine running entirely on blockchain.</p>
                    <p class="mb-3">
                    Kinic is fully functional and averages thousands of unique monthly searches. It is available to use for free at 
                    <a class="blueText" href="https://kinic.io/" target="_blank">https://kinic.io/</a> 
                    (which points to this smart contract canister: 
                    <a class="blueText" href="https://74iy7-xqaaa-aaaaf-qagra-cai.raw.ic0.app/" target="_blank">https://74iy7-xqaaa-aaaaf-qagra-cai.raw.ic0.app/</a>).
                    </p>
                    <p class="mb-3">
                    Users can search for content on the IC for free without logging in. Users can also search by category. If users log in, they will be able to see the most recent indexed sites. Kinic’s login methods are anonymous. Searches cannot be connected to real-world identities.
                    <img class="w-full sm:max-w-xs my-3" style="max-width:830px;" src="./assets/image7.png" alt="">
                    </p>
                    <p class="mb-3">Kinic makes front-end content hosted on-chain searchable. Currently, Kinic allows you to search all of the frontend canisters on the Internet Computer blockchain. Other blockchains and decentralized content storage will be added, including IPFS and Aarweave. See the proposed Kinic Roadmap below.</p>
                    <p class="mb-3">When frontend canisters (i.e., websites) are deployed to the IC, it normally takes about 7 days to appear in a Kinic search as we reindex subnets once per 7 days. Sites that are “claimed” by their builder rank higher in the search results. This is to differentiate claimed versus staging sites that are preliminary.</p>
                    <p class="mb-3">
                    Creators can claim a site via the Twitter @kinic_app. Claiming sites can also be done by comparing the canister owner principal ID by what is given to us in a DFX command. Motoko does not have an 'info' method call yet so this comparison is done with DFX for now. See 
                    <a class="blueText" href="https://forum.dfinity.org/t/getting-a-canisters-controller-on-chain/7531" target="_blank">here</a> 
                    for more details.
                    </p>
                    <p class="mb-3">Kinic’s search categories are taken from the keywords or h1 or h2 of an app that runs on the IC. Kinic also creates a general set of keywords based on all text of an app.</p>
                    <p class="mb-3">Kinic has processes set up for indexing using scripts that anyone can run.The frontend, auction and site claiming code are canisters. The search database will operate on CanDB. Creators can also claim sites to make them have an SEO push to differentiate between staging and production sites.</p>
                    <p class="mb-3">Kinic uses traits of the IC discovered in the Rust source code to gather all canister IDs on the IC’s blockchain subnets. By using other “smart-code” Kinic identifies keywords for each app and app type. We then prioritize 'claimed sites' over WIP or staging sites, creating a new basis for web3 SEO. The frontend app is built using Vue.js. We A/B tested a few variants to find a simple and sleek design.</p>
                    <hr class="mb-3"/>

                    <p class="mb-3 font-semibold text-xl">Kinic Roadmap</p>
                    <p class="mb-3">The following nonbinding roadmap can guide the development of the Kinic app:</p>
                    <ol class="list-disc list-inside mb-3">
                    <li>API work (data analytics, social app connections, & in-site search API usable by other web3 projects).</li>
                    <li>Supporting ad sales (decentralize and targeted ads for categories and search terms).</li>
                    <li>Automate highlighting of new and interesting web3 content.</li>
                    <li>Add more chains and decentralized storage networks into the Kinic indexing process such as IPFS and Arweave.</li>
                    <li>Explore on-chain large language models for advanced web3 search queries.</li>
                    <li>Improve indexing process to create syntactical structure of backends and frontends across chains.</li>
                    <li>ZKML will be used to ensure that Kinic not only has the best search and API, but all the most trustless. </li>
                    </ol>

                    <h2 id="kinic-dao" section-trigger class="relative flex items-center w-full mt-5 mb-2 p-4 text-2xl font-semibold text-left border-b border-solid">
                        3. Kinic DAO Launch and Governance
                        <a href="#top" class="hidden sm:block absolute right-4 text-sm cursor-pointer text-gray-800">Back to top</a>
                    </h2>

                    <p class="mb-3 font-semibold text-xl">Summary</p>
                    <ol class="list-disc list-inside mb-3">
                        <li>Kinic’s vision will be fulfilled by decentralizing its governance using an on-chain, decentralized autonomous organization (DAO).</li>
                        <li>The Kinic DAO will manage and improve the Kinic software service by voting on proposals.</li>
                        <li>To submit proposals and vote, KINIC token holders must lock (“stake”) their tokens into neurons.  </li>
                        <li>To incentivize KINIC token holders to stake their tokens into neurons and vote, neurons receive voting rewards (that are ultimately redeemable for ICP tokens) each time they vote.</li>
                        <li>Voting rewards are greater the longer tokens have been staked (higher age) and the longer they are locked (a higher dissolve delay).</li>
                        <li>Each neuron can only vote once per proposal.</li>
                        <li>Neurons can directly vote on proposals or delegate their votes to another voting member. </li>
                    </ol>
                    <hr class="mb-3"/>

                    <p class="mb-3 font-semibold text-xl">Launching the DAO</p>
                    <p class="mb-3">The Internet Computer (IC) provides a system for on-chain governance by token holders for decentralized autonomous organizations (DAOs). DAOs on the IC exist at the protocol level for the entire blockchain and also at the level of individual apps.</p>
                    <p class="mb-3">
                        At the protocol level, the IC is governed on-chain by a DAO known as the 
                        <a class="blueText" href="https://internetcomputer.org/how-it-works/network-nervous-system-nns/" target="_blank">
                        Network Nervous System
                        </a>. 
                        The NNS accepts votes from holders of locked (staked) ICP. Staked ICP are called neurons. At the app level, a 
                        <a class="blueText" href="https://internetcomputer.org/sns" target="_blank">Service Nervous System (SNS)</a> 
                        DAO is the means for decentralized, on-chain governance.
                    </p>
                    <p class="mb-3">The Kinic SNS DAO will be officially launched when the smart contract canisters controlled by the founding team are transferred to and thereafter fully controlled by the DAO. The DAO will be formed with an initial governance, tokenomics, and technical configuration. Once made public, the initial configuration is permanent until launch. After launch, the initial configuration parameters can be changed by vote.</p>
                    <p class="mb-3">Creation of the Kinic DAO will take place as follows:</p>
                    <ol class="list-disc list-inside mb-3">
                        <li>The Kinic development organization will submit a proposal to the NNS with details (parameters) about the decentralization sale such as the initial token allocation, voting rules and rewards, and tokenomics. </li>
                        <li>If the proposal is approved by the NNS, the decentralization sale of KINIC tokens will begin to take place.</li>
                        <li>The ICP raised in the sale will be placed into the smart contract canister owned and controlled by the Kinic DAO. </li>
                    </ol>
                    <p class="mb-3">The sale will take place at some point in the second quarter of 2023 (April through June). To participate in the sale during the sale period, prospective KINIC token buyers must log into the NNS app (https://nns.ic0.app/), transfer ICP into their NNS account, and then go to the Launchpad section inside the NNS app.</p>
                    <p class="mb-3">In the Launchpad, prospective buyers should deposit ICP tokens in the Kinic sale section. When the sale is complete, buyers will receive the number of KINIC tokens in the same proportion as their deposited ICP is to the total amount of the sale. For example, if their deposited ICP is 1% of the total ICP deposited during the sale, the buyer will receive 1% of the KINIC tokens sold.</p>
                    <p class="mb-3">The ICP received from the sale will be controlled by an ICP ledger account owned by the Kinic DAO governance canister.</p>
                    <p class="mb-3">Once the decentralization sale is complete, the Kinic DAO will have now been created and running entirely on chain with decentralized governance.</p>
                    <hr class="mb-3"/>

                    <p class="mb-3 font-semibold text-xl">Governance of the DAO</p>
                    <p class="mb-3">Once the Kinic DAO is launched, it will be completely controlled by its DAO. Only the DAO will be able to upgrade or otherwise change the smart contract canister code and be able to engage in transactions with the treasury. This means, for example, that only the DAO can choose to disburse funds, change governance rules, or hire third party developers.</p>
                    
                    <p class="mb-3 font-semibold underline">Action by Voting on Proposals</p>
                    <p class="mb-3">The Kinic DAO acts through proposals that are voted on by holders of staked KINIC tokens (i.e., KINIC neurons). Each neuron is entitled to one vote per proposal. Proposals can be submitted by any staked neuron holder and relate to any topic.</p>
                    <p class="mb-3">Nonbinding motions can also be made to communicate or clarify ideas without committing the DAO to any particular action. Examples of nonbinding proposals include proposals for roadmap development or changes.</p>
                    
                    <p class="mb-3 font-semibold text-lg">The following types of proposals can be made to the DAO to be approved by voting neurons:</p>
                    <ol class="list-decimal list-inside mb-3">
                        <li><b>Canister upgrade proposals.</b> Upgrades canisters of the dapp or canisters of the DAO itself. These proposals contain a canister Id and a wasm module.</li>
                        <li><b>SNS config change proposals.</b> Changes the DAO’s initial parameters (see below).</li>
                        <li><b>Token transfer proposals.</b> Transfer KINIC, ICP, or other IC-native tokens between the DAO and an external account. </li>
                        <li><b>Burn token proposals.</b> Burn KINIC tokens and reduce their total supply.</li>
                        <li><b>Custom function proposals.</b> Enable the DAO’s governance canister to perform any operation on a canister such as rolling upgrades, adding a new DAO to sync proposals with, and expanding the Kinic service to operate in additional canisters.</li>
                    </ol>

                    <p class="mb-3 font-semibold text-lg">A proposal is adopted when the following conditions are met:</p>
                    <ol class="list-decimal list-inside mb-3">
                        <li>Within 4 days, the total voting power “adopt” votes is greater that “reject” votes or after a period of quiet, and</li>
                        <li>“Adopt” votes constitute at least 3% of the voting power, or</li>
                        <li>Voting power of “adopt” or “reject” votes exceeds 50%.</li>
                    </ol>
                    <p class="mb-3">Neurons that vote within the 4 day period will still earn voting rewards even if the decision about whether to adopt was already resolved.</p>
                    
                    <p class="mb-3 font-semibold underline">Voting Rewards Come in the Form of Maturity</p>
                    <p class="mb-3">To incentivize KINIC holders to vote, voters receive voting rewards each time they vote.</p>
                    <p class="mb-3">To qualify for voting rewards, KINIC holders must first stake their tokens and set the neuron’s dissolve delay to at least one month long. The dissolve delay is the length of time that a neuron is locked. One year is the maximum dissolve delay.</p>
                    <p class="mb-3">Staked KINIC tokens (neurons) cannot be traded. To unlock staked KINIC tokens, they must be dissolved. When the dissolve delay has ended, the KINIC tokens can be dissolved and then traded.</p>
                    <p class="mb-3">Voting rewards are larger for longer dissolve delays. This helps to align voting with the long-term interests of Kinic. A minimum dissolve delay of one month is required to qualify to vote on proposals.</p>
                    <p class="mb-3">When neurons vote, voting rewards are earned by the neurons in the form of a maturity. Maturity is an attribute of a neuron and not a tradable asset. The more a neuron votes, the more maturity their neuron obtains. Voting rewards (maturity) are earned daily based on all of the votes of the DAO that ended on that day.</p>
                    <p class="mb-3">To generate income from maturity, the KINIC token holder must convert (disburse) the maturity into new KINIC tokens. This process will consume (or “burn”) the converted maturity. By default, units of maturity are converted into KINIC tokens on a 1:1 basis. For example, disbursing a neuron that 100 has maturity will convert to 100 KINIC tokens. These new KINIC tokens will be provided to the token holder’s main account.</p>
                    <p class="mb-3">As an alternative to converting maturity into KINIC tokens, a voting member can also stake their maturity to earn additional voting rewards.</p>

                    <p class="mb-3 font-semibold underline">Voting Power: Dissolve Delay Bonus and Age Bonus</p>
                    <p class="mb-3">Although each neuron can only vote once per proposal, a neuron may have relatively higher voting power when they vote. Neurons that have been staked for a longer period of time have more voting power. This aligns incentives towards longer-term staking.</p>
                    <p class="mb-3">Being staked for a longer time means that the neuron has a higher dissolve delay and/or the time for which the neuron has already been staked (its age). Neuron voting power is accordingly calculated according to the following formula: number of tokens times dissolve delay bonus times age bonus.</p>
                    <ol class="list-disc list-inside mb-3">
                        <li>The dissolve delay bonus is 1x for neurons with no dissolve delay. It increases linearly to 2x for neurons that have the maximum 1 year dissolve delay.</li>
                        <li>The age bonus is 1x for new neurons and increases linearly to 1.25x for neurons that have been staked for 6 months or longer.</li>
                    </ol>
                    <p class="mb-3">Accordingly, a neuron with a 1 year dissolve delay that is at least 6 months old will have 2.5x the voting power of a new neuron that only has a 1 month dissolve delay.</p>

                    <p class="mb-3 font-semibold underline">Delegated Voting</p>
                    <p class="mb-3">
                        Neurons can directly vote on individual proposals using the Kinic section inside the NNS app 
                        <a class="blueText" href="https://nns.ic0.app/" target="_blank">here</a>. 
                        Neurons can also delegate their votes to another voting member.
                    </p>
                    <p class="mb-3">Vote delegation is accomplished by setting a neuron to follow another neuron; that is, to vote along with the votes of another neuron (per proposal type). For example, neurons can follow the Kinic development organization voting neuron The follower neuron will vote for a proposal if a majority of the Kinic development organization agrees. This way, neurons will follow the Kinic development organization’s votes. An advantage of following the Kinic development organization’s neuron is that the Kinic development organization votes on every proposal. This enables followers to maximize voting rewards for voting on every proposal as well.</p>
                    <p class="mb-3">Voting neurons may effectively gain disproportionate voting power if they have a large number of followers. This is similar to representative democracy.</p>

                    <h2 id="kinic-token-and-revenue" section-trigger 
                        class="relative flex items-center w-full mt-5 mb-2 p-4 text-2xl font-semibold text-left border-b border-solid">
                        4. Kinic DAO Treasury and Token Utility
                        <a href="#top" class="hidden sm:block absolute right-4 text-sm cursor-pointer text-gray-800">Back to top</a>
                    </h2>

                    <p class="mb-3 font-semibold text-xl">Summary</p>
                    <ol class="list-disc list-inside mb-3">
                        <li>The treasury controlled by the Kinic DAO will hold KINIC tokens and ICP tokens.</li>
                        <li>It would be very difficult for the DAO to be taken over by a single party that effectively steals the treasury.</li>
                        <li>KINIC tokens can be used to pay for Kinic's current and upcoming products and services.</li>
                        <li>The Kinic DAO earns ICP as revenue when users purchase KINIC tokens from the DAO. ICP tokens in the DAO’s treasury can be used to fund expenses.</li>
                        <li>Expenses will most likely exceed revenue for the first few years of the DAO but revenue is expected to eventually exceed DAO expenses. </li>
                    </ol>

                    <p class="mb-3 font-semibold underline">The Kinic DAO Treasury</p>
                    <p class="mb-3">The treasury controlled by the Kinic DAO will hold KINIC tokens and ICP tokens.</p>
                    <p class="mb-3">After the decentralization sale, the DAO will have an ICP ledger account containing the ICP raised in the sale. It will also have a KINIC ledger account with KINIC tokens controlled by the treasury. As discussed in further detail in the Launch Allocations and Mechanics section, the Kinic DAO will retain approximately 50% of the KINIC tokens created upon launch.</p>
                    <p class="mb-3">To enable the trading of KINIC, proposals will be made soon after the decentralization sale to transfer KINIC and ICP to decentralized exchange liquidity pools. The purpose of enabling trading in KINIC tokens is to enable people to join in or exit from Kinic DAO governance. The purpose is not to enable or encourage investment or speculation in KINIC tokens.</p>
                    <p class="mb-3">ICP tokens in the DAO’s treasury can be used to fund expenses such as paying cycles for hosting, third-party services, and paying developers. Infrequent proposals will be made to transfer ICP from the treasury to Kinic’s cycle dispenser canister. The purpose is for the canister to pay for cycles other Kinic canisters.</p>
                    
                    <p class="mb-3">Kinic is an on-chain service. It currently has the following off-chain dependencies:</p>
                    <ol class="list-disc list-inside mb-3">
                        <li>Ownership of the https://kinic.io/ domain name that has been pre-paid up to May 2024. Kinic will transfer to an alternative on-chain solution as soon as practical. </li>
                        <li>Scripts used for finding new sites and ranking them. Ranking is based on various factors such as meta data, social handles, and reputation. There are some subjective ranking values that can be given to token holders to determine in a democratic way.</li>
                    </ol>

                    <p class="mb-3 font-semibold underline">Likelihood of a Malicious DAO Takeover is Low</p>
                    <p class="mb-3">In theory, the DAO can be taken over by a single party that effectively steals the treasury. For example, in a so-called 51% attack, a single party gains control of a majority of the voting power and pushes through a vote to transfer the entire treasury to themselves. In addition to being extremely costly, the purchase of a significant portion of KINIC tokens by the Community Fund in the decentralization sale mitigates this risk. This is because the Community Fund acts as a single, benevolent voting block that would prevent a malicious actor.</p>
                    <p class="mb-3">For example, even in the unlikely event that a malicious actor purchased 65% of the tokens being offered in the decentralization sale and then increased the dissolve delay of all their neurons to the max (to maximize their voting power), the following chart shows the attacker would still only own 47.9%. This would be significantly less voting power required than necessary to execute a 51% attack.</p>
                    <img class="w-full sm:max-w-xs" style="max-width:830px;" src="./assets/image3.png" alt="">
                    <img class="w-full sm:max-w-xs" style="max-width:830px;" src="./assets/image2.png" alt="">
                    
                    <p class="mb-3 font-semibold underline">Token Utility and DAO Revenue and Expenses</p>
                    <p class="mb-3">In addition to being used for governance as described above, the KINIC token has utility because it can be used to pay for Kinic's current and upcoming products and services.</p>
                    <p class="mb-3">These products and services include:</p>
                    <ol class="list-disc list-inside mb-3">
                        <li><b>API calls.</b> Third parties can purchase the ability to call the Kinic search API with KINIC tokens.</li>
                        <li><b>Ad purchases.</b> Buyers of ad space can pay using KINIC tokens. We used the Ledger canister to allow for bidding on Ad categories. The highest bidder cannot revoke their bid. Other bidders can reclaim their bid, and bid again if they desire. After the auction closes, the highest bid is decided as the winner and gets a two-week ad spot. The ads appear on category pages on the right side. The ads can be images, videos, or gifs and have links.</li>
                        <li><b>Data analytics.</b> Site owners can view relevant click counts and other information such as search terms that are resolved to a click on their URL. Moreover, site owners can use an internal version of Kinic for search within their project.</li>
                        <li><b>Zero knowledge machine learning (ZKML).</b> The IC can hold a lot of data very cheaply. This makes it an ideal solution for fully on-chain data models. However it is difficult to assess the output of AI models on any current platform. Kinic will use novel approaches to zero-knowledge based floating points backed by a folding ZKP scheme to make this possible, not only on the IC, but for non-IC users. The work from this is applicable for models outside of search; Kinic will open access for these solutions as a service running on KINIC tokens.</li>
                        <li><b>Early adoption incentives.</b> This will be aimed at growing Kinic’s market share via viral marketing strategy. It may include meme campaigns, 3rd party writings and videos, but is loosely defined here as incentives for growth. </li>
                    </ol>
                    <p class="mb-3">In some cases, using KINIC token to purchase products and services may burn tokens and serve as a deflationary mechanism.</p>
                    <p class="mb-3">The Kinic DAO earns ICP as revenue when users purchase KINIC tokens from the DAO with ICP tokens. The Kinic DAO also earns ICP if the DAO stakes its ICP into a neuron on the NNS and earns voting rewards.</p>
                    <p class="mb-3">The Kinic DAO’s expenses will come from spending ICP to buy cycles for hosting costs, third party services, and the Kinic development organization.</p>
                    <p class="mb-3">Expenses will most likely exceed revenue for the first few years of the DAO but revenue is expected to eventually exceed DAO expenses.</p>
                    
                    <h2 id="kinic-dao-tokenomics" section-trigger 
                        class="relative flex items-center w-full mt-5 mb-2 p-4 text-2xl font-semibold text-left border-b border-solid">
                        5. Kinic DAO Tokenomics
                        <a href="#top" class="hidden sm:block absolute right-4 text-sm cursor-pointer text-gray-800">Back to top</a>
                    </h2>

                    <p class="mb-3 font-semibold text-xl">Summary</p>
                    <ol class="list-disc list-inside mb-3">
                        <li>Tokenomics refers to the initial set up and rules that drive the supply and trading of tokens.</li>
                        <li>The total supply of KINIC tokens upon launch will be 6 million tokens.</li>
                        <li>Minting tokens increases the total supply and burning tokens decreases them. KINIC tokens can only be burned by proposal. </li>
                        <li>A reward rate of 2.5% of the total annual supply will be minted to pay voting rewards.</li>
                        <li>Liquid supply refers to the total number of KINIC tokens that are available to trade. </li>
                        <li>KINIC tokens that are locked in a neuron are not part of the liquid supply.</li>
                        <li>Several factors relating to voting rewards and mechanics influence the portion of total KINIC tokens that are liquid. </li>
                    </ol>

                    <p class="mb-3">Tokenomics refers to the initial set up and rules that drive the supply and trading of tokens. The goals of healthy tokenomics are to foster stability and long-run increase in token price, paying DAO contributors, user growth, and facilitating liquidity.</p>
                    <p class="mb-3">The total supply of KINIC tokens upon launch will be 6 million tokens. Minting tokens increases the total supply and burning tokens decreases them. The primary mechanism of inflation is voting rewards.</p>
                    <p class="mb-3">Voting rewards incentivize token holders to keep them locked up and not be part of the liquid supply. A reward rate of 2.5% of the total annual supply will be minted to pay voting rewards to neurons that vote. As discussed in the Kinic DAO: Launch and Governance section, these rewards are given in the form of maturity. The DAO’s initial voting reward rate of 2.5% can be changed by vote.</p>
                    <p class="mb-3">A neuron’s maturity is burned when it is disbursed to provide KINIC tokens to the token holder’s main account. At that time, the DAO will mint the corresponding value of KINIC tokens. Converting maturity into KINIC tokens is the primary inflationary mechanism for KINIC tokens.The Kinic DAO will launch with a total supply of 6 million KINIC tokens. 25% will be available for open sale in exchange for ICP tokens.</p>
                    <p class="mb-3">KINIC tokens can only be burned by proposal. Usage of KINIC will be given back into the DAO treasury. The DAO can make a proposal to burn or otherwise utilize the tokens.</p>
                    <p class="mb-3">When the Kinic DAO is launched, the DAO’s treasury will consist of ICP from the decentralization sale and about half of the total supply of KINIC tokens.</p>
                    <p class="mb-3">The following chart shows a projection of the total supply of KINIC tokens over time. The projection assumes that the reward rate will remain at a constant 2.5% and that the burn rate will start at 0.125% until it becomes greater than the reward rate (increasing by a factor of 1.37 each year). Accordingly, it is expected that eventually more KINIC tokens will be burned than minted.</p>
                    <img class="w-full sm:max-w-xs" style="max-width:830px;" src="./assets/image5.png" alt="">
                    
                    <p class="mb-3 font-semibold underline">Liquid Token Supply</p>
                    <p class="mb-3">Liquid supply refers to the total number of KINIC tokens that are available to trade at any given time.</p>
                    <p class="mb-3">KINIC tokens that are locked in a neuron are not part of the liquid supply.</p>
                    <p class="mb-3">However, when a neuron dissolves, the formerly-locked KINIC tokens are added to the liquid supply. Longer dissolve delays prevent staked tokens from becoming liquid. Accordingly, larger dissolve delay and age bonuses (that incentivize locking up tokens for longer) have the effect of reducing the liquid supply. In addition, KINIC token holders that are subject to vesting cannot disburse their neurons into KINIC tokens until the vesting period is complete.</p>
                    <p class="mb-3">KINIC tokens held by the DAO treasury are considered liquid but are not necessarily part of the market. This is because only a portion of KINIC tokens held in the DAO treasury will be transferred to the community as rewards or to pay for , and only a portion of those will be sold on exchanges. The same applies to the KINIC tokens held in the NNS that are purchased by the Community Fund.</p>
                    
                    <p class="mb-3">The following parameters relating to voting rewards and mechanics influence the portion of total KINIC tokens that are liquid:</p>
                    <ol class="list-disc list-inside mb-3">
                        <li>Max dissolve delay</li>
                        <li>Dissolve delay bonus</li>
                        <li>Minimum dissolve delay to vote</li>
                        <li>Max age</li>
                        <li>Max age bonus</li>
                        <li>Voting reward rate</li>
                    </ol>

                    <p class="mb-3 font-semibold underline">Initial DAO Tokenomics</p>
                    <p class="mb-3">The values for all of the KINIC DAO’s initial parameters are in the table below. These parameters may be changed by vote.</p>
                    <p class="mb-3">The purpose of these initial values is to find the right balance between incentivizing KINIC token holders to lock their tokens while also incentivizing them to purchase in the first place for liquidity.</p>
                    <div class="grid grid-cols-2 gap-4 border border-gray-400 rounded">
                        <div class="border-b border-r px-4 py-2 font-medium bg-gray-100">Transaction fee in KINIC tokens that must be paid for ledger transfers</div>
                        <div class="border-b px-4 py-2">0.001</div>
                        <div class="border-b border-r px-4 py-2 font-medium bg-gray-100">Number of KINIC tokens that a rejected proposal costs the proposer</div>
                        <div class="border-b px-4 py-2">5</div>
                        <div class="border-b border-r px-4 py-2 font-medium bg-gray-100">Minimum number of KINIC tokens that can be staked in a neuron</div>
                        <div class="border-b px-4 py-2">0.1</div>
                        <div class="border-b border-r px-4 py-2 font-medium bg-gray-100">Maximum voting period for a proposal</div>
                        <div class="border-b px-4 py-2">4 days</div>
                        <div class="border-b border-r px-4 py-2 font-medium bg-gray-100">Proportion of voting power needed for a proposal to be accepted</div>
                        <div class="border-b px-4 py-2">3%</div>
                        <div class="border-b border-r px-4 py-2 font-medium bg-gray-100">Minimum neuron dissolve delay to vote</div>
                        <div class="border-b px-4 py-2">1 month</div>
                        <div class="border-b border-r px-4 py-2 font-medium bg-gray-100">Maximum neuron dissolve delay</div>
                        <div class="border-b px-4 py-2">1 year</div>
                        <div class="border-b border-r px-4 py-2 font-medium bg-gray-100">Maximum age for age bonus</div>
                        <div class="border-b px-4 py-2">6 months</div>
                        <div class="border-b border-r px-4 py-2 font-medium bg-gray-100">Maximum age bonus</div>
                        <div class="border-b px-4 py-2">1.25x</div>
                        <div class="border-r px-4 py-2 font-medium bg-gray-100">Percentage of total supply that will be generated annually for rewards</div>
                        <div class="px-4 py-2">2.5%</div>
                    </div>

                    <h2 id="launch-allocations-and-mechanics" section-trigger 
                        class="relative flex items-center w-full mt-5 mb-2 p-4 text-2xl font-semibold text-left border-b border-solid">
                        6. Launch Allocations and Mechanics
                        <a href="#top" class="hidden sm:block absolute right-4 text-sm cursor-pointer text-gray-800">Back to top</a>
                    </h2>

                    <p class="mb-3 font-semibold text-xl">Summary</p>
                    <ol class="list-disc list-inside mb-3">
                        <li>The Kinic DAO will launch with a total supply of 6 million KINIC tokens. 25% will be available for open sale in exchange for ICP tokens.</li>
                        <li>50% of the tokens will remain in the DAO’s treasury. 10% will be allocated to the Kinic development organization, 10% allocated to seed funders, and 4% will be allocated to Kinic NFT holders via airdrop.</li>
                        <li>The maximum ICP that can be earned in the sale of the KINIC tokens is 1.5 million ICP, and the minimum is 500,000 ICP.</li>
                        <li>1 KINIC token may be worth between 0.33 and 1.33 ICP tokens based on earning between 500,000 and 1.5 million ICP tokens</li>
                    </ol>

                    <p class="mb-3 font-semibold underline">Initial token allocation</p>
                    <p class="mb-3">The purpose of the decentralization sale is to decentralize the governance of the Kinic DAO. The Kinic DAO will launch with a total supply of 6 million KINIC tokens.</p>
                    <p class="mb-3">Out of the total 6 million supply of KINIC tokens, 25% (1,500,000) will be available for open sale in exchange for ICP tokens. The maximum ICP that can be earned in the sale of the 1,500,000 KINIC is 1,500,000 million ICP, and the minimum is 500,000 ICP.</p>
                    <p class="mb-3">The Kinic DAO’s two million ICP funding target is based on comparable funding rounds:</p>
                    <ol class="list-disc list-inside mb-3">
                        <li>Privacy-focused search engine DuckDuckGo <a class="blueText" target="_blank" href="https://www.crunchbase.com/organization/duck-duck-go">has raised</a> a total of $172 million across four funding rounds, the most recent of which was <a href="https://spreadprivacy.com/duckduckgrowing/">$100 million</a> in late 2020.</li>
                        <li>In January 2022, The Graph Foundation <a class="blueText" target="_blank" href="https://thegraph.com/blog/graph-raise/">raised</a> $50 million to build an indexing protocol for querying data on networks like Ethereum and IPFS.</li>
                        <li>In March 2023, Kaito <a class="blueText" target="_blank" href="https://www.linkedin.com/pulse/kaito-ai-raises-53m-transform-crypto-search-chatgpt-kaitoai/?trackingId=1QyGZzaTRYMOo0rKhm0F2w%3D%3D">raised</a> $5.3 million to transform crypto search with ChatGPT.</li>
                    </ol>
                    <p class="mb-3">From the 1,500,000 KINIC tokens available as part of the open sale, Kinic will seek to sell 4.2% (250,000) to the Internet Computer’s Community Fund and the remaining 20.8% (1,250,000) KINIC to the community more generally. If the target maximum ICP is earned in the sale, the amount of ICP earned from the Community Fund will be 252,000 ICP.</p>
                    <p class="mb-3">50% (3,000,000) will remain in the DAO’s treasury. 10% will be allocated to the Kinic development organization and funders. 4% (240,000) will be allocated to Kinic NFT holders via airdrop.</p>
                    <p class="mb-3">1% (60,000) of the KINIC tokens will be used to create liquidity pools on exchanges for trading. The tokens available for trade will be backed by ICP earned from the decentralization sale. Proposals will be required to be made and approved to transfer KINIC tokens and ICP to an exchange.</p>
                    <p class="mb-3">The initial target KINIC token allocation is shown in the following chart (assuming the maximum ICP sale target is met):</p>
                    <img class="w-full sm:max-w-xs" style="max-width:830px;" src="./assets/image6.png" alt="">
                    
                    <p class="mb-3 font-semibold underline">Decentralization Sale Mechanics</p>
                    <p class="mb-3">All parties that participate in the decentralization sale will receive an amount of KINIC tokens that equals the amount of ICP they pay divided by the total ICP that is earned in the sale.</p>
                    <p class="mb-3">Buyers will receive their amount of KINIC tokens in the form of 5 neurons that are equally divided in the amount of staked KINIC they contain. Each of the 5 neurons will have a different dissolve delay according to the following schedule:</p>
                    <div class="mb-2">
                        <div>Neuron 1 dissolve delay: 0 months</div>
                        <div>Neuron 2 dissolve delay: 3 months</div>
                        <div>Neuron 3 dissolve delay: 6 months</div>
                        <div>Neuron 4 dissolve delay: 9 months</div>
                        <div>Neuron 5 dissolve delay: 12 months</div>
                    </div>
                    <p class="mb-3">The neuron with 0 months dissolve delay can immediately be released into liquid KINIC tokens. Accordingly, 20% of the neurons for buyers in the decentralization sale will be immediately liquid.</p>
                    
                    <p class="mb-3 font-semibold underline">Allocation to Kinic Development Organization and Seed Funders</p>
                    <p class="mb-3">The founding Kinic development organization will receive 10% (600,000) of the KINIC tokens in the form of 3 neurons that have a 1 month dissolve delay.</p>
                    <p class="mb-3">These three neurons have the following vesting schedule:</p>
                    <ol class="list-disc list-inside mb-3">
                        <li>25% (150,000) vested for 1 year</li>
                        <li>25% (150,000) vested for 2 years</li>
                        <li>50% (300,000) vested for 3 years</li>
                    </ol>
                    <p class="mb-3">During the vesting period, neurons cannot be disbursed into tokens or otherwise changed. The 1 month dissolve delay reduces the relative voting power of the KINIC tokens owned by the Kinic development organization.</p>
                    <p class="mb-3">Likewise, Kinic seed funders will receive 10% (600,000) of the KINIC tokens in the form of 2 neurons that have a 1 month dissolve delay. These neurons have the following vesting schedule:</p>
                    <ol class="list-disc list-inside mb-3">
                        <li>25% (150,000) no vesting</li>
                        <li>25% (150,000) vested for 1 year</li>
                        <li>50% (300,000) vested for 2 years</li>
                    </ol>

                    <p class="mb-3 font-semibold underline">Allocation to Kinic NFT Holders</p>
                    <p class="mb-3">4% of KINIC tokens (240,000) will be given to Kinic NFT holders. NFT holders will receive their KINIC tokens in the form of three neurons. These three neurons will have the same dissolve delay and vesting schedule as the seed funders.</p>
                    <p class="mb-3">The process to disburse Kinic NFT holders will require a snapshot on April 17th 8PM JST, owners at this time will be recorded and set into the sns.yml file. Any pending transfer of an NFT, sale, or alteration of ownership after this point in time will not be recorded. Please make sure to hold your NFT at the time of the snapshot. *Please note that if you purchase a Kinic NFT after this time it will not be included in the snapshot.</p>
                    <p class="mb-3">The Kinic NFT is available on 
                        <a class="blueText" target="_blank" href="https://entrepot.app/marketplace/kinic">Entrepot</a>.
                    </p>

                    <p class="mb-3 font-semibold underline">Allocation to DAO Treasury</p>
                    <p class="mb-3">The Kinic DAO will initially retain 50% of the initial supply of KINIC tokens (plus the 1% of KINIC tokens used to provide exchange liquidity). These tokens will be used to incentivize developers to contribute to the development of Kinic and its ecosystem. They can also be used to incentivize users, for marketing, and other initiatives that improve the standing of Kinic as the world’s first decentralized search engine.</p>
                    <p class="mb-3">The initial values for the decentralization sale are summarized as follows:</p>
                    <div class="grid grid-cols-2 gap-4 border border-gray-400 rounded mb-2">
                        <div class="border-b border-r px-4 py-2 font-medium bg-gray-100">The total number of KINIC tokens to be sold</div>
                        <div class="border-b px-4 py-2">1,500,000 (25% of total)</div>
                        <div class="border-b border-r px-4 py-2 font-medium bg-gray-100">The maximum ICP to be raised</div>
                        <div class="border-b px-4 py-2">1,500,000</div>
                        <div class="border-b border-r px-4 py-2 font-medium bg-gray-100">The minimum ICP to be raised (otherwise sale fails and ICP returned)</div>
                        <div class="border-b px-4 py-2">500,000</div>
                        <div class="border-b border-r px-4 py-2 font-medium bg-gray-100">End date of sale (unless maximum ICP raised sooner)</div>
                        <div class="border-b px-4 py-2">31st May 2023 at 12:00 (noon) GMT (TBC)</div>
                        <div class="border-b border-r px-4 py-2 font-medium bg-gray-100">Minimum number of sale participants</div>
                        <div class="border-b px-4 py-2">300</div>
                        <div class="border-b border-r px-4 py-2 font-medium bg-gray-100">Minimum ICP per buyer</div>
                        <div class="border-b px-4 py-2">1</div>
                        <div class="border-r px-4 py-2 font-medium bg-gray-100">Maximum ICP per buyer</div>
                        <div class="px-4 py-2">100,000</div>
                    </div>

                    <p class="mb-3 font-semibold underline">Valuation Range and Token Price</p>
                    <p class="mb-3">The value (in ICP) of KINIC tokens upon launch is based upon how many ICP tokens are raised in the decentralization sale.</p>
                    <p class="mb-3">The more ICP tokens that are exchanged for 1.5 million KINIC tokens, the higher the value of a single KINIC token. This is because the price of 1 KINIC equals the amount of ICP earned (between 500,000 and 1.5 million) divided by the number of KINIC tokens sold (1.5 million).</p>
                    <p class="mb-3">Accordingly, 1 KINIC token may be worth between 0.33 and 1 ICP tokens based on earning between 500,000 and 1.5 million ICP tokens, respectively, as shown in the following chart.</p>
                    <img class="w-full sm:max-w-xs" style="max-width:830px;" src="./assets/image4.png" alt="">
                    <p class="mb-3">Ultimately, the price for the KINIC token is influenced by several factors including total and liquid supply, demand, DAO revenue and expenses, and projections about the future.</p>

                    <p class="mb-3 font-semibold underline">Relative Voting Power Upon Launch</p>
                    <p class="mb-3">The relative voting power upon launch of the Kinic DAO is as follows:</p>
                    <img class="w-full sm:max-w-xs" style="max-width:830px;" src="./assets/image1.png" alt="">

                    <h2 id="launch-allocations-and-mechanics" section-trigger 
                        class="relative flex items-center w-full mt-5 mb-2 p-4 text-2xl font-semibold text-left border-b border-solid">
                        7. Token Holder Rights and Limitations
                        <a href="#top" class="hidden sm:block absolute right-4 text-sm cursor-pointer text-gray-800">Back to top</a>
                    </h2>

                    <p class="mb-3">Any person that purchases, holds, owns, or otherwise directly or indirectly controls or benefits from one or more KINIC tokens (a “Tokenholder”) agrees and acknowledges the following terms and conditions:</p>
                    <ol id="legal-disclaimers" class="list-decimal list-inside mb-6">
                        <li>The purpose of the Tokenholder’s interest is not for investment, trading, speculation, or any other financial purpose.</li>
                        <li>Each Tokenholder is a natural person acting on its own behalf and not for the benefit of any other person.</li>
                        <li>The Tokenholder is not a United States citizen and is not physically present inside the United States, except for the Kinic development organization and some seed funders.</li>
                        <li>The Kinic DAO, and nothing in this whitepaper, is intended to, or shall be deemed to, establish any partnership or joint venture between any of the Tokenholders, or authorize any Tokenholder to make or enter into any commitments for or on behalf of any other party. </li>
                        <li>To the maximum extent permitted by law, each Token holder absolutely and irrevocably waives any and all claims, actions, causes of action, loss, damage and expense including any and all attorneys’ fees and other costs of enforcement arising out of or in connection with any breach or alleged breach of any fiduciary duty by any other Tokenholders or the Kinic DAO. It is the express intent of the Tokenholders that each Tokenholder and the Kinic DAO shall be and hereby are relieved of any and all fiduciary duties which might otherwise be applicable.</li>
                        <li>In no event shall any Tokenholder or the Kinic DAO be liable to any other Tokenholder for any loss of anticipated profits or other consequential, special or indirect loss or damage of any nature arising at any time, whether arising under contract, tort (including negligence), strict liability or for any other cause whatsoever.</li>
                        <li>No Tokenholder shall bring any legal claim, action, or proceeding against any other Tokenholder on any basis.</li>
                        <li>No Tokenholder is relying upon any statement or representation made by the founding Kinic development organization, the Kinic DAO, or any other Tokenholder.</li>
                        <li>No Tokenholder, the founding Kinic development organization, nor the Kinic DAO, makes any express or implied warranty, any disclaims all such express or implied warranties, including any warranties of merchantability or fitness for a particular purpose.</li>
                        <li>Tokenholders that fail to stake their KINIC tokens and engage in voting for a reasonable time are subject to having their tokens repurchased by the DAO.</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
</header>
</template>

<script>
  export default {
    name: 'Whitepaper',
    components: {
    },
    props: {
        whitepaperMode: {
            type: Function,
            required: true,
        },
    },
    data() {
        return {
        }
    }
}
</script>