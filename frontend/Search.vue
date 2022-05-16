<template>
  <div @click="dropdownOn = false" style="background: #4182d8;">
    <div class="max-w-7xl mx-auto py-3 px-2">
      <div class="flex items-center justify-between flex-wrap">
        <div class="w-0 flex-1 flex items-center">
          <p class="ml-3 font-light text-white truncate">
            <span v-if="!searchMode">Kinic allows you to search all of the frontend canisters on the IC. Enter a canister ID or search text to find great content on web3.</span>
            <span v-else>☝Advertisers can bid ICP to put Ads at the top of categories. This revenue is shared with content site owners.</span>
          </p>
        </div>
        <div class="order-3 mt-2 flex-shrink-0 w-full sm:order-2 sm:mt-0 sm:w-auto">
          <a href="https://twitter.com/kinic_app" target="_blank" class="flex items-center justify-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-yellow-500 bg-white hover:bg-indigo-50 addFont"> Built for #SUPERNOVA </a>
        </div>
      </div>
    </div>
  </div>

  <!-- HEADER FOR RESULTS PAGE -->
  <header v-if="searchMode" class="h-full" style="border-bottom: 1px solid #eee">
        <div class="content px-8 py-2">
            <!-- MOBILE NAV -->
            <nav class="block xl:hidden flex items-center justify-between mb-4">
              <h2 @click="reset" style="font-family: 'Bowlby One SC'; color:#7F321A;" class="font-bold text-2xl cursor-pointer">Kinic</h2>
              <div class="auth flex items-center">
                  <button v-if="!principal" @click="logIn()" class="bg-gray-800 text-gray-200 py-2 px-3 rounded hover:bg-gray-700 hover:text-gray-100">Login</button>
                  <div v-else class="relative inline-block">
                     <button @click="toggleDD" class="relative z-10 flex items-center p-2 text-sm text-gray-600 bg-white border border-transparent rounded-md focus:border-blue-500 focus:ring-opacity-40 focus:ring focus:outline-none">
                         <span class="mx-1">User-{{principal.substring(0, 5)}}</span>
                         <svg class="w-5 h-5 mx-1" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                             <path d="M12 15.713L18.01 9.70299L16.597 8.28799L12 12.888L7.40399 8.28799L5.98999 9.70199L12 15.713Z" fill="currentColor"></path>
                         </svg>
                     </button>
                     <div :class="dropdownOn ? 'block' : 'hidden'" class="absolute right-0 z-20 w-56 py-2 mt-2 overflow-hidden bg-white rounded-md shadow-xl text-sm">

                       <a class="block px-4 py-3 capitalize transition-colors duration-200 transform hover:bg-gray-100 cursor-pointer">
                           Create Ad
                       </a>

                       <a class="block px-4 py-3 capitalize transition-colors duration-200 transform hover:bg-gray-100 cursor-pointer">
                           Claim Site
                       </a>

                       <hr class="border-gray-200">

                       <a @click="logOut()" class="block px-4 py-3 capitalize transition-colors duration-200 transform hover:bg-gray-100 cursor-pointer">
                           Logout
                       </a>
                     </div>
                 </div>
              </div>
            </nav>
            <!-- SEARCH RESULT PAGE NAV -->
            <nav class="flex items-center justify-between">
                <h2 @click="reset" style="font-family: 'Bowlby One SC'; color:#7F321A;" class="hidden xl:block font-bold text-2xl cursor-pointer">Kinic</h2>
                <div class="hidden xl:block pt-2 relative mx-auto text-gray-600 w-9/12 xl:w-5/12">
                   <input style="border-width: 1px;" class="border-gray-200 bg-white h-12 px-5 pl-12 rounded-xl text-sm focus:outline-none w-full custom-hover text-lg"
                     type="search" name="search" placeholder="" v-model="search" @keyup.enter="termSearch('in')">
                   <i class="absolute left-4 top-1 mt-5 mr-4">
                     <svg class="text-gray-400 h-4 w-4 fill-current" xmlns="http://www.w3.org/2000/svg"
                       xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="Capa_1" x="0px" y="0px"
                       viewBox="0 0 56.966 56.966" style="enable-background:new 0 0 56.966 56.966;" xml:space="preserve"
                       width="512px" height="512px">
                       <path
                         d="M55.146,51.887L41.588,37.786c3.486-4.144,5.396-9.358,5.396-14.786c0-12.682-10.318-23-23-23s-23,10.318-23,23  s10.318,23,23,23c4.761,0,9.298-1.436,13.177-4.162l13.661,14.208c0.571,0.593,1.339,0.92,2.162,0.92  c0.779,0,1.518-0.297,2.079-0.837C56.255,54.982,56.293,53.08,55.146,51.887z M23.984,6c9.374,0,17,7.626,17,17s-7.626,17-17,17  s-17-7.626-17-17S14.61,6,23.984,6z" />
                     </svg>
                   </i>
                 </div>
                 <input style="border-width: 1px;" class="block xl:hidden border-gray-200 bg-white h-12 px-5 pl-6 rounded-xl text-sm focus:outline-none w-full custom-hover text-lg"
                   type="search" name="search" placeholder="" v-model="search" @keyup.enter="termSearch('in')">
                 <div class="hidden xl:block auth flex items-center text-sm">
                      <button v-if="!principal" @click="logIn()" class="bg-gray-800 text-gray-200 py-2 px-3 rounded hover:bg-gray-700 hover:text-gray-100">Login</button>

                      <div v-else class="relative inline-block">
                         <button @click="toggleDD" class="relative z-10 flex items-center p-2 text-sm text-gray-600 bg-white border border-transparent rounded-md focus:border-blue-500 focus:ring-opacity-40 focus:ring focus:outline-none">
                             <span class="mx-1">User-{{principal.substring(0, 5)}}</span>
                             <svg class="w-5 h-5 mx-1" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                 <path d="M12 15.713L18.01 9.70299L16.597 8.28799L12 12.888L7.40399 8.28799L5.98999 9.70199L12 15.713Z" fill="currentColor"></path>
                             </svg>
                         </button>
                         <div :class="dropdownOn ? 'block' : 'hidden'" class="absolute right-0 z-20 w-56 py-2 mt-2 overflow-hidden bg-white rounded-md shadow-xl text-sm">

                           <a class="block px-4 py-3 capitalize transition-colors duration-200 transform hover:bg-gray-100 cursor-pointer">
                               Create Ad
                           </a>

                           <a class="block px-4 py-3 capitalize transition-colors duration-200 transform hover:bg-gray-100 cursor-pointer">
                               Claim Site
                           </a>

                           <hr class="border-gray-200">

                           <a @click="logOut()" class="block px-4 py-3 capitalize transition-colors duration-200 transform hover:bg-gray-100 cursor-pointer">
                               Logout
                           </a>
                         </div>
                     </div>
                  </div>

            </nav>
        </div>
    </header>

    <header v-if="!searchMode" class="h-full">
          <div class="content px-8 py-2">
              <!-- LANDING NAV -->
              <nav class="flex items-center justify-between mb-4">
                <h2 class="font-bold text-2xl"></h2>
                <div class="auth flex items-center">
                    <button v-if="!principal" @click="logIn()" class="bg-gray-200 text-gray-800 py-2 px-3 rounded hover:bg-gray-100 hover:text-gray-700">Login</button>
                    <div v-else class="relative inline-block">
                       <button @click="toggleDD" class="relative z-10 flex items-center p-2 text-sm text-gray-600 bg-white border border-transparent rounded-md focus:border-blue-500 focus:ring-opacity-40 focus:ring focus:outline-none">
                           <span class="mx-1">User-{{principal.substring(0, 5)}}</span>
                           <svg class="w-5 h-5 mx-1" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                               <path d="M12 15.713L18.01 9.70299L16.597 8.28799L12 12.888L7.40399 8.28799L5.98999 9.70199L12 15.713Z" fill="currentColor"></path>
                           </svg>
                       </button>
                       <div :class="dropdownOn ? 'block' : 'hidden'" class="absolute right-0 z-20 w-56 py-2 mt-2 overflow-hidden bg-white rounded-md shadow-xl text-sm">

                         <a class="block px-4 py-3 capitalize transition-colors duration-200 transform hover:bg-gray-100 cursor-pointer">
                             Create Ad
                         </a>

                         <a class="block px-4 py-3 capitalize transition-colors duration-200 transform hover:bg-gray-100 cursor-pointer">
                             Claim Site
                         </a>

                         <hr class="border-gray-200">

                         <a @click="logOut()" class="block px-4 py-3 capitalize transition-colors duration-200 transform hover:bg-gray-100 cursor-pointer">
                             Logout
                         </a>
                       </div>
                   </div>
                </div>
              </nav>
          </div>
    </header>


    <!-- SEARCH RESULTS -->
    <section v-if="searchMode" class="mx-auto w-full px-3 sm:pl-[5%] md:pl-[14%] lg:pl-52 mt-6">
      <div v-for="item in results[page]" :key="item.Canisterid" className="max-w-xl mb-8">
        <div className="group">
          <b style="color:#7F321A;" className="text-xs addFont">
            https://{{item.Canisterid}}.raw.ic0.app/
          </b>
          <a v-if="item.Title" :href="'https://' + item.Canisterid + '.raw.ic0.app/'">
            <h2 style="color: #4182d8;" className="truncate text-xl group-hover:underline">
              {{item.Title}}
            </h2>
          </a>
          <a v-else :href="'https://' + item.Canisterid + '.raw.ic0.app/'">
            <h2 style="color: #4182d8;" className="truncate text-xl group-hover:underline">
              No Title
            </h2>
          </a>
        </div>
        <p className="line-clamp-2 text-gray-900">
          {{item.Subtitle}}
        </p>
        <p className="line-clamp-2 text-gray-900 text-sm font-light">
          ID: {{item.Canisterid}}
        </p>
        <p className="line-clamp-2 text-gray-900 text-sm font-light">
          Subnet: {{item.Subnetid}}
        </p>
        <span v-if="item.Status && item.Status === 'official'" class="bg-blue-100 text-blue-800 text-xs font-semibold mr-2 px-2.5 py-0.5 rounded dark:bg-blue-200 dark:text-blue-800">OFFICIAL</span>
        <a v-if="item.Note && item.Note === 'ICME'"  target="_blank" href="https://www.icme.io">
          <span class="bg-gray-100 text-gray-800 text-xs font-semibold mr-2 px-2.5 py-0.5 rounded dark:bg-gray-700 dark:text-gray-300 ml-1">BUILT ON ICME.IO</span>
        </a>
        <a v-if="item.Note && item.Note.indexOf('github') > -1"  target="_blank" :href="item.Note">
          <span class="bg-gray-100 text-gray-800 text-xs font-semibold mr-2 px-2.5 py-0.5 rounded dark:bg-gray-700 dark:text-gray-300 ml-1">OPEN SOURCE</span>
        </a>
        <a v-if="item.Note && item.Note.indexOf('twitter') > -1"  target="_blank" :href="item.Note">
          <svg
            style="display:inline;"
            class="w-5 h-5 text-blue-300 fill-current ml-1 pointer"
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24">
            <path
              d="M23.953 4.57a10 10 0 01-2.825.775 4.958 4.958 0 002.163-2.723c-.951.555-2.005.959-3.127 1.184a4.92 4.92 0 00-8.384 4.482C7.69 8.095 4.067 6.13 1.64 3.162a4.822 4.822 0 00-.666 2.475c0 1.71.87 3.213 2.188 4.096a4.904 4.904 0 01-2.228-.616v.06a4.923 4.923 0 003.946 4.827 4.996 4.996 0 01-2.212.085 4.936 4.936 0 004.604 3.417 9.867 9.867 0 01-6.102 2.105c-.39 0-.779-.023-1.17-.067a13.995 13.995 0 007.557 2.209c9.053 0 13.998-7.496 13.998-13.985 0-.21 0-.42-.015-.63A9.935 9.935 0 0024 4.59z"
            />
          </svg>
        </a>
      </div>
      <div v-if="results.length === 0" class="max-w-xl mb-8 animate-pulse">
        ...
      </div>
    </section>

    <!-- AD SPACE -->
    <div @click="dropdownOn = false" v-if="searchMode" class="hidden xl:block w-full mx-auto rounded-lg bg-white shadow-lg px-5 pt-5 pb-10 text-gray-800 fixed top-52 right-24" style="max-width: 500px">
        <div class="w-full pt-1 pb-5">
            <div class="overflow-hidden w-60 -mt-16 mx-auto shadow-lg">
                <img src="./assets/default.png" alt="">
            </div>
        </div>
        <div class="w-full mb-10">
            <div class="text-3xl text-indigo-500 text-center leading-tight addFont">Your AD</div>
            <p class="text-gray-600 text-center px-5">
              Login and make a bid on your category. The winner of the auction will have their Ad shown under the category for a two week duration.
              During this time the next auction will take place! Contact <a target="_blank" href="https://twitter.com/kinic_app">@kinic_app</a> on Twitter for support.
            </p>
        </div>
        <div class="w-full">
            <p class="text-lg text-indigo-500 text-center addFont">Category | {{category || 'N/A'}}</p>
            <a target="_blank" href="https://www.icme.io/"><p class="text-sm text-center">Visit icme.io for no-code content creation on web3.</p></a>
        </div>
    </div>

    <!-- PAGINATION -->
    <div v-if="searchMode && pages > 1" class="flex flex-col items-center my-12">
      <div class="flex text-gray-700">
          <div @click="backPage()" class="h-12 w-12 mr-1 flex justify-center items-center rounded-full bg-gray-200 cursor-pointer">
              <svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-chevron-left w-6 h-6">
                  <polyline points="15 18 9 12 15 6"></polyline>
              </svg>
          </div>
          <div class="flex h-12 font-medium rounded-full bg-gray-200">
              <div v-for="i in pages" :key="i" @click="changePage(i)" :class="i == (page + 1) ? 'bg-gray-100' : ''" class="w-12 md:flex justify-center items-center hidden cursor-pointer leading-5 transition duration-150 ease-in rounded-full">{{i}}</div>
          </div>
          <div @click="nextPage()" class="h-12 w-12 ml-1 flex justify-center items-center rounded-full bg-gray-200 cursor-pointer">
              <svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-chevron-right w-6 h-6">
                  <polyline points="9 18 15 12 9 6"></polyline>
              </svg>
          </div>
      </div>
    </div>

    <!-- SEARCH AND TITLE PAGE -->
    <section @click="dropdownOn = false" v-if="!searchMode" class="w-full mt-48">
      <div class="flex justify-center">
        <h1 style="font-family: 'Bowlby One SC'; color:#7F321A;" class="text-8xl">
          Kinic.
        </h1>
      </div>
    </section>

    <section @click="dropdownOn = false" v-if="!searchMode" style="margin-bottom:6%;" class="w-full">
        <div class="p-4 w-full">
            <div class="flex justify-center">
                <div class="pt-2 relative mx-auto text-gray-600 w-9/12 xl:w-5/12">
                   <input style="border-width: 1px;" class="border-gray-200 bg-white h-12 px-5 pl-12 rounded-xl text-sm focus:outline-none w-full custom-hover text-lg"
                     type="search" name="search" placeholder="" v-model="search" @keyup.enter="termSearch('in')">
                   <i class="absolute left-4 top-1 mt-5 mr-4">
                     <svg class="text-gray-400 h-4 w-4 fill-current" xmlns="http://www.w3.org/2000/svg"
                       xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="Capa_1" x="0px" y="0px"
                       viewBox="0 0 56.966 56.966" style="enable-background:new 0 0 56.966 56.966;" xml:space="preserve"
                       width="512px" height="512px">
                       <path
                         d="M55.146,51.887L41.588,37.786c3.486-4.144,5.396-9.358,5.396-14.786c0-12.682-10.318-23-23-23s-23,10.318-23,23  s10.318,23,23,23c4.761,0,9.298-1.436,13.177-4.162l13.661,14.208c0.571,0.593,1.339,0.92,2.162,0.92  c0.779,0,1.518-0.297,2.079-0.837C56.255,54.982,56.293,53.08,55.146,51.887z M23.984,6c9.374,0,17,7.626,17,17s-7.626,17-17,17  s-17-7.626-17-17S14.61,6,23.984,6z" />
                     </svg>
                   </i>
                 </div>
              </div>
            <div class="flex justify-center mt-10">
              <button @click="termSearch('in')" class="text-white font-light py-2 px-8 rounded srchIt addFont">Search Web 3.0</button>
            </div>
        </div>
    </section>

    <!-- CATEGORY Footer -->
    <div @click="dropdownOn = false" v-if="!searchMode" class="h-5 border-b-2 border-gray-400 text-xl addFont">
        <span class="bg-white px-2 ml-8 font-bold">Category Search</span>
    </div>

    <div @click="dropdownOn = false" v-if="!searchMode" class="mt-4 mx-2 ml-8 mb-2">
      <a @click="categorySearch('blog')" class="mr-6 text-gray-500 hover:text-yellow-500 font-light cursor-pointer">
        Blog
      </a>
      <a @click="categorySearch('communication')" class="mr-6 text-gray-500 hover:text-yellow-500 font-light cursor-pointer">
        Communication
      </a>
      <a @click="categorySearch('dao')" class="mr-6 text-gray-500 hover:text-yellow-500 font-light cursor-pointer">
        DAO
      </a>
      <a @click="categorySearch('defi')" class="mr-6 text-gray-500 hover:text-yellow-500 font-light cursor-pointer">
        Defi
      </a>
      <a @click="categorySearch('docs')" class="mr-6 text-gray-500 hover:text-yellow-500 font-light cursor-pointer">
        Docs
      </a>
      <a @click="categorySearch('funny')" class="mr-6 text-gray-500 hover:text-yellow-500 font-light cursor-pointer">
        Funny
      </a>
      <a @click="categorySearch('game')" class="mr-6 text-gray-500 hover:text-yellow-500 font-light cursor-pointer">
        Games
      </a>
      <a @click="categorySearch('interesting')" class="mr-6 text-gray-500 hover:text-yellow-500 font-light cursor-pointer">
        Interesting
      </a>
      <a @click="categorySearch('investor')" class="mr-6 text-gray-500 hover:text-yellow-500 font-light cursor-pointer">
        Investor
      </a>
    </div>
    <div @click="dropdownOn = false" v-if="!searchMode" class="mt-2 mb-10 ml-8">
      <a @click="categorySearch('portfolio')" class="mr-6 text-gray-500 hover:text-yellow-500 font-light cursor-pointer">
        Portfolio
      </a>
      <a @click="categorySearch('landing')" class="mr-6 text-gray-500 hover:text-yellow-500 font-light cursor-pointer">
        Landing
      </a>
      <a @click="categorySearch('learning')" class="mr-6 text-gray-500 hover:text-yellow-500 font-light cursor-pointer">
        Learning
      </a>
      <a @click="categorySearch('music')" class="mr-6 text-gray-500 hover:text-yellow-500 font-light cursor-pointer">
        Music
      </a>
      <a @click="categorySearch('nft')" class="mr-6 text-gray-500 hover:text-yellow-500 font-light cursor-pointer">
        NFT
      </a>
      <a @click="categorySearch('social')" class="mr-6 text-gray-500 hover:text-yellow-500 font-light cursor-pointer">
        Social
      </a>
      <a @click="categorySearch('utility')" class="mr-6 text-gray-500 hover:text-yellow-500 font-light cursor-pointer">
        Utility
      </a>
      <a @click="categorySearch('video')" class="mr-6 text-gray-500 hover:text-yellow-500 font-light cursor-pointer">
        Video
      </a>
      <a @click="categorySearch('wip')" class="mr-6 text-gray-500 hover:text-yellow-500 font-light cursor-pointer">
        Work In Progress
      </a>
    </div>

</template>

<script>
import { main } from "canisters/main"
import axios from 'axios'
import { AuthClient } from "@dfinity/auth-client"
import { Principal } from "@dfinity/principal";

export default {
  name: "Intro",
  async mounted () {
    const client = await AuthClient.create()
    const isAuthenticated = await client.isAuthenticated()

    if (isAuthenticated) {
      this.identity = client.getIdentity()
      this.principal = this.identity.getPrincipal().toString()
      // Force close.
      setTimeout(() => {
        this.dropdownOn = false
      }, 200)
    }
  },
  methods: {
    async logIn () {
      const authClient = await AuthClient.create();
      authClient.login({
        identityProvider: "https://identity.ic0.app",
        onSuccess: async () => {
          this.identity = authClient.getIdentity()
          this.principal = this.identity.getPrincipal().toString()
          // Force close.
          setTimeout(() => {
            this.dropdownOn = false
          }, 200)
        }
      })
    },
    async logOut () {
      const authClient = await AuthClient.create();
      await authClient.logout()
      this.identity = null
      this.principal = null
    },
    addPageToHistory () {
      this.dropdownOn = false
      if (this.category && !this.search) {
        let newUrlIS = window.location.origin + '/category/' + this.category + '/' + (this.page + 1)
        history.pushState({}, null, newUrlIS)
      } else if (this.search) {
        let newUrlIS = window.location.origin + '/search/' + this.search + '/' + (this.page + 1)
        history.pushState({}, null, newUrlIS)
      }
    },
    changePage (page) {
      this.page = page - 1
      window.scrollTo({ top: 0, behavior: 'smooth' })
      this.addPageToHistory()
    },
    backPage () {
      if (this.page !== 0) {
        this.page = this.page - 1
        window.scrollTo({ top: 0, behavior: 'smooth' })
        this.addPageToHistory()
      }
    },
    nextPage () {
      if (this.page !== (this.pages - 1)) {
        this.page = this.page + 1
        window.scrollTo({ top: 0, behavior: 'smooth' })
        this.addPageToHistory()
      }
    },
    reset () {
      this.dropdownOn = false
      let newUrlIS =  window.location.origin + '/'
      history.pushState({}, null, newUrlIS)
      this.searchMode = false
      this.results = []
      this.category = ''
      this.page = 0
      this.pages = 0
      this.search = ''
    },
    setSearch () {
      if (window.location.pathname && window.location.pathname.split('/')[3]) {
        this.page = (window.location.pathname.split('/')[3] - 1)
      }
      if (window.location.pathname.split('/')[1] === 'category') {
        this.categorySearch(window.location.pathname.split('/')[2])
      } else if (window.location.pathname.split('/')[1] === 'search') {
        this.search = decodeURI(window.location.pathname.split('/')[2])
        this.termSearch()
      } else {
        this.reset();
      }
    },
    paginate (data) {
      this.dropdownOn = false
      this.results = []

      // Sort results
      data.sort(function(a, b) {
        if (a.Datalength < b.Datalength) {
            return 1;
        } else if (a.Datalength > b.Datalength) {
            return -1;
        }
        return 0;
      });

      let top = [];
      // for Vue.js. Needs new array.
      let newData = [];
      for (let i = 0; i < data.length; i++) {
        if (data[i].Status === 'official') {
          top.push(data[i])
        } else {
          newData.push(data[i])
        }
      }

      top.sort(function(a, b) {
        if (a.Datalength < b.Datalength) {
            return 1;
        } else if (a.Datalength > b.Datalength) {
            return -1;
        }
        return 0;
      });

      data = top.concat(newData)

      // Set category for Ads
      if (!this.category) {
        let mainCategory = data.map(function(value, index) {return value['Apptype']}),
          distribution = {},
          max = 0,
          result = [];

        mainCategory.forEach(function (a) {
            distribution[a] = (distribution[a] || 0) + 1;
            if (distribution[a] > max) {
                max = distribution[a];
                result = [a];
                return;
            }
            if (distribution[a] === max) {
                result.push(a);
            }
        });
        this.category = result[0]
      }

      this.pages = Math.ceil(data.length / 20)
      let total = 0
      for (let k = 0; k < this.pages; k++) {
        let page = []
        for (let i = 0; page.length < 20; i++) {
          if (data[total]) {
            page.push(data[total])
            total++
          } else {
            break
          }
        }
        this.results.push(page)
      }
    },
    termSearch (txt) {
      this.results = []
      this.category = ''
      if (txt === 'in') {
        this.page = 0
        this.pages = 0
      }
      let newUrlIS =  window.location.origin + '/search/' + this.search
      if (this.page !== 0) {
        newUrlIS = window.location.origin + '/search/' + this.search + '/' + (this.page + 1)
      }
      history.pushState({}, null, newUrlIS)
      this.searchMode = true

      let isIdSearch = false
      if (this.search.length === 27) {
        let temp = this.search.split('-')
        if (temp.length === 5) {
          if (temp[4] === 'cai') {
            isIdSearch = true
          }
        }
      }

      if (isIdSearch) {
        axios.post(this.host, {
          "action": "searchID",
          "category": this.search
        }).then((response) => {
            if (response.data) {
              this.paginate(response.data)
            }
        });
      } else {
        axios.post(this.host, {
          "action": "searchTerm",
          "category": this.search
        }).then((response) => {
            if (response.data && response.data.message !== 'No action defined.') {

              this.paginate(response.data)
            }
        });
      }
    },
    categorySearch (txt) {
      this.results = []
      let newUrlIS =  window.location.origin + '/category/' + txt
      if (this.page !== 0) {
        newUrlIS = window.location.origin + '/category/' + txt + '/' + (this.page + 1)
      }
      history.pushState({}, null, newUrlIS)
      this.searchMode = true
      this.category = txt

      axios.post(this.host, {
        "action": "searchCategory",
        "category": txt
      }).then((response) => {
          if (response.data && response.data.message !== 'No action defined.') {
            this.paginate(response.data)
          }
      });
    },
    toggleDD () {
      this.dropdownOn = !this.dropdownOn
    }
  },
  beforeMount () {
    const self = this;
    if (location.port === '3000' || location.port === '8000') {
      this.host = 'http://localhost:4000/search'
    }
    window.onpopstate = function () {
      self.setSearch();
    }
    self.setSearch();
  },
  data () {
    return {
      search: '',
      host: '',
      searchMode: false,
      results: [],
      category: '',
      page: 0,
      principal: null,
      identity: null,
      dropdownOn: false
    }
  }
}
</script>
<style>
  .addFont {
    font-family: 'Bowlby One SC';
  }
  .srchIt {
    background-color: #4182d8;
  }
  .srchIt:hover {
    background-color: #235da9;
  }
  .custom-hover:hover {
    box-shadow: rgb(0 0 0 / 15%) 0px 6px 15px -3px, rgb(0 0 0 / 15%) 0px -3px 6px -4px;
  }
</style>
