<template>
  <div style="background: #4182d8;">
    <div class="max-w-7xl mx-auto py-3 px-2">
      <div class="flex items-center justify-between flex-wrap">
        <div class="w-0 flex-1 flex items-center">
          <p class="ml-3 font-light text-white truncate">
            <span v-if="!searchMode">Kinic allows you to search all of the frontend canisters on the IC. Enter a canister ID or search text to find great content on web3.</span>
            <span v-else>☝Advertisers can bid ICP to put Ads at the top of categories. These profits are shared with content sites by % of clicks.</span>
          </p>
        </div>
        <div class="order-3 mt-2 flex-shrink-0 w-full sm:order-2 sm:mt-0 sm:w-auto">
          <a href="https://dfinity.org/supernova/" target="_blank" class="flex items-center justify-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-yellow-500 bg-white hover:bg-indigo-50 addFont"> Built for #SUPERNOVA </a>
        </div>
      </div>
    </div>
  </div>

  <!-- HEADER FOR RESULTS PAGE -->
  <header v-if="searchMode" class="h-full" style="border-bottom: 1px solid #eee">
        <div class="content px-8 py-2">
            <nav class="flex items-center justify-between">
                <h2 @click="reset" style="font-family: 'Bowlby One SC'; color:#7F321A;" class="font-bold text-2xl cursor-pointer">Kinic</h2>
                <div class="pt-2 relative mx-auto text-gray-600 w-9/12 xl:w-5/12">
                   <input style="border-width: 1px;" class="border-gray-200 bg-white h-12 px-5 pl-12 rounded-xl text-sm focus:outline-none w-full custom-hover text-lg"
                     type="search" name="search" placeholder="">
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
                <div class="auth flex items-center">
                    <!-- <b class="text-gray-500 p-2 mr-4 font-light">Sign in</b> -->
                    <button class="bg-gray-900 text-gray-200  py-2 px-3 rounded  hover:bg-gray-800 hover:text-gray-100">Login</button>
                </div>
            </nav>
        </div>
    </header>

    <!-- SEARCH RESULTS -->
    <section v-if="searchMode" class="mx-auto w-full px-3 sm:pl-[5%] md:pl-[14%] lg:pl-52 mt-6">
      <div v-for="item in results" :key="item.Canisterid" className="max-w-xl mb-8">
        <div className="group">
          <b style="color:#7F321A;" className="text-sm addFont">
            https://{{item.Canisterid}}.raw.ic0.app/
          </b>
          <a :href="'https://' + item.Canisterid + '.raw.ic0.app/'">
            <h2 style="color: #4182d8;" className="truncate text-xl group-hover:underline">
              {{item.Title}}
            </h2>
          </a>
        </div>
        <p className="line-clamp-2 text-gray-900">
          {{item.Subtitle}}
        </p>
      </div>
    </section>

    <!-- AD SPACE -->
    <div v-if="searchMode" class="hidden xl:block w-full mx-auto rounded-lg bg-white shadow-lg px-5 pt-5 pb-10 text-gray-800 fixed top-52 right-24" style="max-width: 500px">
        <div class="w-full pt-1 pb-5">
            <div class="overflow-hidden w-60 -mt-16 mx-auto shadow-lg">
                <img src="./assets/default.png" alt="">
            </div>
        </div>
        <div class="w-full mb-10">
            <div class="text-3xl text-indigo-500 text-center leading-tight addFont">Your AD</div>
            <p class="text-gray-600 text-center px-5">
              Login and make a bid on your category. The winner of the auction will have their Ad shown under the category for a two week duration.
              During this time the next auction will take place! Contact <a target="_blank" href="https://twitter.com/icme_app">@kinic</a> on Twitter for support.
            </p>
        </div>
        <div class="w-full">
            <p class="text-lg text-indigo-500 text-center addFont">Category | {{category}}</p>
            <a target="_blank" href="https://www.icme.io/"><p class="text-sm text-center">Visit icme.io</p></a>
        </div>
    </div>

    <!-- SEARCH AND TITLE PAGE -->
    <section v-if="!searchMode" class="w-full mt-48">
      <div class="flex justify-center">
        <h1 style="font-family: 'Bowlby One SC'; color:#7F321A;" class="text-8xl">
          Kinic.
        </h1>
      </div>
    </section>

    <section v-if="!searchMode" style="margin-bottom:6%;" class="w-full">
        <div class="p-4 w-full">
            <div class="flex justify-center">
                <div class="pt-2 relative mx-auto text-gray-600 w-9/12 xl:w-5/12">
                   <input style="border-width: 1px;" class="border-gray-200 bg-white h-12 px-5 pl-12 rounded-xl text-sm focus:outline-none w-full custom-hover text-lg"
                     type="search" name="search" placeholder="">
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
              <button class="text-white font-light py-2 px-8 rounded srchIt addFont">Search Web 3.0</button>
            </div>
        </div>
    </section>

    <!-- CATEGORY Footer -->
    <div v-if="!searchMode" class="h-5 border-b-2 border-gray-400 text-xl addFont">
        <span class="bg-white px-2 ml-8 font-bold">Category Search</span>
    </div>

    <div v-if="!searchMode" class="mt-4 mx-2 ml-8">
      <a @click="categorySearch('blog')" class="mr-6 text-gray-500 hover:text-yellow-500 font-light cursor-pointer">
        Blog
      </a>
      <a @click="categorySearch('communication')" class="mr-6 text-gray-500 hover:text-yellow-500 font-light cursor-pointer">
        Communication
      </a>
      <a @click="categorySearch('dao')" class="mr-6 text-gray-500 hover:text-yellow-500 font-light cursor-pointer">
        DAO
      </a>
      <a @click="categorySearch('docs')" class="mr-6 text-gray-500 hover:text-yellow-500 font-light cursor-pointer">
        Docs
      </a>
      <a @click="categorySearch('funny')" class="mr-6 text-gray-500 hover:text-yellow-500 font-light cursor-pointer">
        Funny
      </a>
      <a @click="categorySearch('games')" class="mr-6 text-gray-500 hover:text-yellow-500 font-light cursor-pointer">
        Games
      </a>
      <a @click="categorySearch('interesting')" class="mr-6 text-gray-500 hover:text-yellow-500 font-light cursor-pointer">
        Interesting
      </a>
      <a @click="categorySearch('investor')" class="mr-6 text-gray-500 hover:text-yellow-500 font-light cursor-pointer">
        Investor
      </a>
    </div>
    <div v-if="!searchMode" class="mt-2 mb-4 ml-8">
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

export default {
  name: "Intro",
  methods: {
    reset () {
      let newUrlIS =  window.location.origin + '/'
      history.pushState({}, null, newUrlIS)
      this.searchMode = false
      this.results = []
      this.category = ''
    },
    setSearch () {
      if (window.location.pathname.split('/')[1] === 'category') {
        this.categorySearch(window.location.pathname.split('/')[2])
      } else {
        this.reset();
      }
    },
    categorySearch (txt) {
      let newUrlIS =  window.location.origin + '/category/' + txt
      history.pushState({}, null, newUrlIS)
      this.searchMode = true
      this.category = txt

      axios.post(this.host, {
        "action": "searchCategory",
        "category": txt
      }).then((response) => {
          if (response.data) {
            this.results = response.data
          }
      });
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
      host: '',
      searchMode: false,
      results: [],
      category: ''
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
