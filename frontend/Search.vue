<template>
  <div class="bg-blue-600">
    <div class="max-w-7xl mx-auto py-3 px-2">
      <div class="flex items-center justify-between flex-wrap">
        <div class="w-0 flex-1 flex items-center">
          <p class="ml-3 font-medium text-white truncate">
            <span> 👉 Kinic allows you to search all of the frontend canisters on the IC. Enter a canister ID or search text to find great content on web3.</span>
          </p>
        </div>
        <div class="order-3 mt-2 flex-shrink-0 w-full sm:order-2 sm:mt-0 sm:w-auto">
          <a href="https://dfinity.org/supernova/" target="_blank" class="flex items-center justify-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-blue-600 bg-white hover:bg-indigo-50"> #SUPERNOVA </a>
        </div>
      </div>
    </div>
  </div>
  <section class="w-full mt-48 text-7xl">
    <div class="flex justify-center">
      <h1 class="text-gray-800">
        Kinic Search
      </h1>
    </div>
  </section>
  <section style="margin-bottom:10%;" class="w-full">
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
            <button class="bg-blue-500 hover:bg-blue-700 text-white font-light py-2 px-8 rounded">Search Web 3.0</button>
          </div>
      </div>
  </section>

<div class="h-5 border-b-2 border-gray-400 text-xl">
    <span class="bg-white px-2 ml-8 font-bold">Category Search</span>
</div>

<div class="mt-4 mx-2 ml-8 border-r-2">
  <a href="#!" class="mr-6 text-gray-500 hover:underline font-light">
    Blog
  </a>
  <a href="#!" class="mr-6 text-gray-500 hover:underline font-light">
    Communication
  </a>
  <a href="#!" class="mr-6 text-gray-500 hover:underline font-light">
    DAO
  </a>
  <a href="#!" class="mr-6 text-gray-500 hover:underline font-light">
    Docs
  </a>
  <a href="#!" class="mr-6 text-gray-500 hover:underline font-light">
    Funny
  </a>
  <a href="#!" class="mr-6 text-gray-500 hover:underline font-light">
    Games
  </a>
  <a href="#!" class="mr-6 text-gray-500 hover:underline font-light">
    Interesting
  </a>
  <a href="#!" class="mr-6 text-gray-500 hover:underline font-light">
    Investors
  </a>
</div>
<div class="mt-2 mb-4 ml-8 border-r-2">
  <a href="#!" class="mr-6 text-gray-500 hover:underline font-light">
    Landing
  </a>
  <a href="#!" class="mr-6 text-gray-500 hover:underline font-light">
    Learning
  </a>
  <a href="#!" class="mr-6 text-gray-500 hover:underline font-light">
    Music
  </a>
  <a href="#!" class="mr-6 text-gray-500 hover:underline font-light">
    NFT
  </a>
  <a href="#!" class="mr-6 text-gray-500 hover:underline font-light">
    Social
  </a>
  <a href="#!" class="mr-6 text-gray-500 hover:underline font-light">
    Utility
  </a>
  <a href="#!" class="mr-6 text-gray-500 hover:underline font-light">
    Video
  </a>
  <a href="#!" class="mr-6 text-gray-500 hover:underline font-light">
    Work In Progress
  </a>
</div>


</template>

<script>
import { ref, onMounted } from "vue"
import { main } from "canisters/main"

export default {
  name: "Intro",
  setup: () => {
    const count = ref(0)

    const refreshCounter = async () => {
      const res = await main.getValue()
      count.value = res.toString()
    }

    const increment = async () => {
      await main.increment()
      refreshCounter()
    }

    onMounted(refreshCounter)

    return { increment, count }
  },
}
</script>
<style>
  .custom-hover:hover {
    box-shadow: rgb(0 0 0 / 15%) 0px 6px 15px -3px, rgb(0 0 0 / 15%) 0px -3px 6px -4px;
  }
</style>
