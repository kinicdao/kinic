<template>
  <!-- Header -->
  <Header :headerFunctions="headerFunctions" />

  <!-- WHITEPAGE -->
  <Whitepaper :whitepaperMode="whitepaperMode" />

  <!-- HEADER FOR RESULTS PAGE -->
  <header v-if="searchMode && !whitepaperMode" class="h-full">
        <div class="content px-8 pt-4 pb-4 blackBG">
            <!-- MOBILE NAV -->
            <nav class="block xl:hidden flex items-center justify-between mb-4">
              <img @click="reset" class="cursor-pointer" style="max-width:130px;" src="data:image/svg+xml;base64,PHN2ZyBpZD0iTGF5ZXJfMSIgZGF0YS1uYW1lPSJMYXllciAxIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAxMzIxIDM1NC44NiI+PGRlZnM+PHN0eWxlPi5jbHMtMXtmaWxsOiNmMDVjMjI7fS5jbHMtMntmaWxsOiNmYmFmMjg7fS5jbHMtM3tmaWxsOiMyM2E4ZTA7fS5jbHMtNHtmaWxsOiNlYzE5Nzg7fTwvc3R5bGU+PC9kZWZzPjxwYXRoIGNsYXNzPSJjbHMtMSIgZD0iTTEyNjcuMjEsMzQzLjIzYTE2Mi40MiwxNjIuNDIsMCwwLDEtMTQwLjI3LDYuNEExNjAuMTYsMTYwLjE2LDAsMCwxLDEwNDAsMjYyLjY5YTE2Mi4wNiwxNjIuMDYsMCwwLDEsMC0xMjYuNzdBMTYwLjE5LDE2MC4xOSwwLDAsMSwxMTI2Ljk0LDQ5YTE2Mi45MywxNjIuOTMsMCwwLDEsMTQwLjE3LDYuMiwxNjIuMTYsMTYyLjE2LDAsMCwxLDU4LjA2LDUyLjA1TDEzMzcsOTkuNTVhMTc3LjA2LDE3Ny4wNiwwLDAsMC02My4wOS01Ni43N0ExNzYuNjYsMTc2LjY2LDAsMCwwLDExMjEuNDIsMzYsMTc1LDE3NSwwLDAsMCwxMDI3LDEzMC40YTE3NS40MiwxNzUuNDIsMCwwLDAsMCwxMzcuODEsMTc0Ljk0LDE3NC45NCwwLDAsMCw5NC40Myw5NC40MywxNzYuNiwxNzYuNiwwLDAsMCwxNTIuMy02LjcsMTc3LjQyLDE3Ny40MiwwLDAsMCw2My4wOC01Ni4yOUwxMzI1LjM3LDI5MUExNjMuNzIsMTYzLjcyLDAsMCwxLDEyNjcuMjEsMzQzLjIzWiIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTE2IC0yMS44OCkiLz48cGF0aCBjbGFzcz0iY2xzLTEiIGQ9Ik0xMTkwLjMyLDEyMS4yNGE3Ny42NSw3Ny42NSwwLDAsMSw2NC42NywzNC4xbDExLjYzLTcuNjhBOTEuNTcsOTEuNTcsMCwwLDAsMTIzMy44OSwxMThhOTEuNzksOTEuNzksMCwwLDAtNzkuMzUtMy42NSw5MS4xMyw5MS4xMywwLDAsMC00OS4xOSw0OS4xOCw5MS40OCw5MS40OCwwLDAsMCwwLDcxLjU3LDkxLjE5LDkxLjE5LDAsMCwwLDQ5LjE5LDQ5LjE5LDkxLjg3LDkxLjg3LDAsMCwwLDc5LjE2LTMuNTUsOTEuNTUsOTEuNTUsMCwwLDAsMzIuNzItMjkuMzdMMTI1NSwyNDMuMDdhNzcuNTQsNzcuNTQsMCwwLDEtMjcuNywyNSw3Ni4xNyw3Ni4xNywwLDAsMS0zNyw5LjI2cS0zMi4zMywwLTU1LjItMjIuODZ0LTIyLjg2LTU1LjJxMC0zMi4zNCwyMi44Ni01NS4yVDExOTAuMzIsMTIxLjI0WiIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTE2IC0yMS44OCkiLz48cGF0aCBjbGFzcz0iY2xzLTEiIGQ9Ik0xMjkwLjA4LDEzMS40OWExMTkuNTIsMTE5LjUyLDAsMCwwLTQyLjg4LTM4LjY0LDEyMS4yNiwxMjEuMjYsMCwwLDAtMTE3LjQsMiwxMTkuNDgsMTE5LjQ4LDAsMCwwLTQ0LDQ0LDEyMS4zNCwxMjEuMzQsMCwwLDAsMCwxMjEsMTE5LjQ1LDExOS40NSwwLDAsMCw0NCw0NCwxMjEuMjIsMTIxLjIyLDAsMCwwLDExNy40LDIsMTE5LjYxLDExOS42MSwwLDAsMCw0Mi44OC0zOC42NEwxMjc4LjQ1LDI1OWExMDYuMzEsMTA2LjMxLDAsMCwxLTM3Ljg1LDM0LjExLDEwNi43MSwxMDYuNzEsMCwwLDEtMTAzLjctMS42OCwxMDYuMjIsMTA2LjIyLDAsMCwxLTM4Ljc0LTM4Ljc0LDEwNi45NSwxMDYuOTUsMCwwLDEsMC0xMDYuODUsMTA2LjM3LDEwNi4zNywwLDAsMSwzOC43NC0zOC43NCwxMDYuOTEsMTA2LjkxLDAsMCwxLDEwMy42LTEuNzcsMTA2LjI1LDEwNi4yNSwwLDAsMSwzNy43NSwzMy44MVoiIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0xNiAtMjEuODgpIi8+PHBhdGggY2xhc3M9ImNscy0xIiBkPSJNMTMxMy43NCwxMTUuNzJhMTQ5LjE5LDE0OS4xOSwwLDAsMC01My00Ny44MSwxNDkuMzcsMTQ5LjM3LDAsMCwwLTE0NS4xLDIuMzcsMTQ4LjQ2LDE0OC40NiwwLDAsMC01NC4zMiw1NC4zMSwxNDUuNywxNDUuNywwLDAsMC0yMCw3NC43MiwxNDUuNywxNDUuNywwLDAsMCwyMCw3NC43MiwxNDguNTMsMTQ4LjUzLDAsMCwwLDU0LjMyLDU0LjMxLDE0OS40OCwxNDkuNDgsMCwwLDAsMTQ0LjgsMi41NiwxNDguMjEsMTQ4LjIxLDAsMCwwLDUyLjkzLTQ3LjQxTDEzMDEuOTEsMjc1QTEzNS4xOSwxMzUuMTksMCwwLDEsMTI1NCwzMTguMThhMTMxLjE2LDEzMS4xNiwwLDAsMS02My42OCwxNiwxMzIuNzcsMTMyLjc3LDAsMCwxLTUyLjQ0LTEwLjY0LDEzMS41OCwxMzEuNTgsMCwwLDEtNzEuNzYtNzEuNzcsMTM0LjUyLDEzNC41MiwwLDAsMSwwLTEwNC44NywxMzEuNjcsMTMxLjY3LDAsMCwxLDcxLjc2LTcxLjc3LDEzNSwxMzUsMCwwLDEsMTE2LDUuMjMsMTM0LjExLDEzNC4xMSwwLDAsMSw0OCw0My4wOFoiIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0xNiAtMjEuODgpIi8+PHJlY3QgY2xhc3M9ImNscy0yIiB4PSI0MTUuMjUiIHk9IjcuNzQiIHdpZHRoPSIxNC44MSIgaGVpZ2h0PSIzNDAuNzEiLz48cmVjdCBjbGFzcz0iY2xzLTIiIHg9IjM4NS42MiIgeT0iNy43NCIgd2lkdGg9IjE0LjgxIiBoZWlnaHQ9IjM0MC43MSIvPjxyZWN0IGNsYXNzPSJjbHMtMiIgeD0iMzU2IiB5PSI3Ljc0IiB3aWR0aD0iMTQuODEiIGhlaWdodD0iMzQwLjcxIi8+PHJlY3QgY2xhc3M9ImNscy0yIiB4PSIzMjYuMzciIHk9IjcuNzQiIHdpZHRoPSIxNC44MSIgaGVpZ2h0PSIzNDAuNzEiLz48cG9seWdvbiBjbGFzcz0iY2xzLTMiIHBvaW50cz0iNTExLjYxIDM0OC40NCA1MjYuNDIgMzQ4LjQ0IDUyNi40MiA5OS4wOSA1MTEuNjEgNzMuOTggNTExLjYxIDM0OC40NCIvPjxwb2x5Z29uIGNsYXNzPSJjbHMtMyIgcG9pbnRzPSI3ODMuMTkgNy43NCA3NjguMzcgNy43NCA3NjguMzcgMjU3LjEgNzgzLjE5IDI4Mi4yIDc4My4xOSA3Ljc0Ii8+PHBvbHlnb24gY2xhc3M9ImNscy0zIiBwb2ludHM9IjcyMy45MyA3Ljc0IDcwOS4xMiA3Ljc0IDcwOS4xMiAxNTkuOTkgNzIzLjkzIDE4NC40NyA3MjMuOTMgNy43NCIvPjxwb2x5Z29uIGNsYXNzPSJjbHMtMyIgcG9pbnRzPSI3NTMuNTYgNy43NCA3MzguNzUgNy43NCA3MzguNzUgMjA4LjEzIDc1My41NiAyMzMuMDIgNzUzLjU2IDcuNzQiLz48cG9seWdvbiBjbGFzcz0iY2xzLTMiIHBvaW50cz0iNzk4IDMyNC4zNyA2MDMuNzggNy43NCA1ODYuNSA3Ljc0IDc5NS4zMiAzNDguNDQgODEyLjgxIDM0OC40NCA4MTIuODEgNy43NCA3OTggNy43NCA3OTggMzI0LjM3Ii8+PHBvbHlnb24gY2xhc3M9ImNscy0zIiBwb2ludHM9IjU0MS4yMyAzNDguNDQgNTU2LjA1IDM0OC40NCA1NTYuMDUgMTQ4LjA1IDU0MS4yMyAxMjMuMTYgNTQxLjIzIDM0OC40NCIvPjxwb2x5Z29uIGNsYXNzPSJjbHMtMyIgcG9pbnRzPSI1MTYuNzUgNy43NCA3MjYuMiAzNDguNDQgNzQzLjQ4IDM0OC40NCA1MzQuMDMgNy43NCA1MTYuNzUgNy43NCIvPjxwb2x5Z29uIGNsYXNzPSJjbHMtMyIgcG9pbnRzPSI1NTEuNzMgNy43NCA3NjAuNzYgMzQ4LjQ0IDc3OC40NSAzNDguNDQgNTY5LjIxIDcuNzQgNTUxLjczIDcuNzQiLz48cG9seWdvbiBjbGFzcz0iY2xzLTMiIHBvaW50cz0iNTcwLjg2IDM0OC40NCA1ODUuNjcgMzQ4LjQ0IDU4NS42NyAxOTYuMiA1NzAuODYgMTcxLjcyIDU3MC44NiAzNDguNDQiLz48cG9seWdvbiBjbGFzcz0iY2xzLTMiIHBvaW50cz0iNDgxLjk4IDcuNzQgNDgxLjk4IDM0OC40NCA0OTYuNzkgMzQ4LjQ0IDQ5Ni43OSAzMS44MSA2OTEuNDIgMzQ4LjQ0IDcwOC41IDM0OC40NCA0OTkuNjggNy43NCA0ODEuOTggNy43NCIvPjxyZWN0IGNsYXNzPSJjbHMtMiIgeD0iOTE3LjU3IiB5PSI3Ljc0IiB3aWR0aD0iMTQuODEiIGhlaWdodD0iMzQwLjcxIi8+PHJlY3QgY2xhc3M9ImNscy0yIiB4PSI4NTguMzEiIHk9IjcuNzQiIHdpZHRoPSIxNC44MSIgaGVpZ2h0PSIzNDAuNzEiLz48cmVjdCBjbGFzcz0iY2xzLTIiIHg9Ijk0Ny4xOSIgeT0iNy43NCIgd2lkdGg9IjE0LjgxIiBoZWlnaHQ9IjM0MC43MSIvPjxyZWN0IGNsYXNzPSJjbHMtMiIgeD0iODg3Ljk0IiB5PSI3Ljc0IiB3aWR0aD0iMTQuODEiIGhlaWdodD0iMzQwLjcxIi8+PHJlY3QgY2xhc3M9ImNscy00IiB4PSIyOS43MSIgeT0iNC4xNiIgd2lkdGg9IjE0Ljg1IiBoZWlnaHQ9IjM0MS42NCIvPjxwb2x5Z29uIGNsYXNzPSJjbHMtNCIgcG9pbnRzPSI4OS4xMiAzNDUuOCAxMDMuOTggMzQ1LjggMTAzLjk4IDI1MS43IDg5LjEyIDIyMi43IDg5LjEyIDM0NS44Ii8+PHBvbHlnb24gY2xhc3M9ImNscy00IiBwb2ludHM9IjU5LjQyIDM0NS44IDc0LjI3IDM0NS44IDc0LjI3IDE5My42OSA2NC42OSAxNzQuOTggNzQuMjcgMTU2LjI3IDc0LjI3IDQuMTYgNTkuNDIgNC4xNiA1OS40MiAzNDUuOCIvPjxwb2x5Z29uIGNsYXNzPSJjbHMtNCIgcG9pbnRzPSIxMDMuOTggNC4xNiA4OS4xMiA0LjE2IDg5LjEyIDEyNy4yNiAxMDMuOTggOTguMjUgMTAzLjk4IDQuMTYiLz48cmVjdCBjbGFzcz0iY2xzLTQiIHk9IjQuMTYiIHdpZHRoPSIxNC44NSIgaGVpZ2h0PSIzNDEuNjQiLz48cG9seWdvbiBjbGFzcz0iY2xzLTQiIHBvaW50cz0iMTA2LjkyIDE3Ny42MiAxOTQuMzkgNi44IDE3Ny44OCA2LjggMTAzLjk4IDE1MS4xMyA5MC40MSAxNzcuNjIgMTAzLjk4IDIwNC4xMSAxNzYuNTMgMzQ1LjggMTc3Ljg4IDM0OC40NCAxOTQuMzkgMzQ4LjQ0IDE5My4wMyAzNDUuOCAxMDYuOTIgMTc3LjYyIi8+PHBvbHlnb24gY2xhc3M9ImNscy00IiBwb2ludHM9IjE0MC4zNCAxNzcuNjIgMjI3LjYxIDYuOCAyMTEuMSA2LjggMTIzLjgzIDE3Ny42MiAyMDkuNzUgMzQ1LjggMjExLjEgMzQ4LjQ0IDIyNy42MSAzNDguNDQgMjI2LjI1IDM0NS44IDE0MC4zNCAxNzcuNjIiLz48cG9seWdvbiBjbGFzcz0iY2xzLTQiIHBvaW50cz0iMTczLjU1IDE3Ny42MiAyNjAuODIgNi44IDI0NC4zMiA2LjggMTU3LjA1IDE3Ny42MiAyNDIuOTcgMzQ1LjggMjQ0LjMyIDM0OC40NCAyNjAuODIgMzQ4LjQ0IDI1OS40NyAzNDUuOCAxNzMuNTUgMTc3LjYyIi8+PHBvbHlnb24gY2xhc3M9ImNscy00IiBwb2ludHM9IjI3Ny41MyA2LjggMTkwLjI2IDE3Ny42MiAyNzcuNTMgMzQ4LjQ0IDI5NC4wNCAzNDguNDQgMjA2Ljc3IDE3Ny42MiAyOTQuMDQgNi44IDI3Ny41MyA2LjgiLz48L3N2Zz4=" alt="kinic logotype">
              <div class="auth flex items-center">
                <button v-if="!principal" @click="logIn()" class="bg-gray-200 text-gray-800 py-2 px-3 rounded hover:bg-gray-100 hover:text-gray-700 mr-2">
                  <span class="loginStyle inline-flex text-xs">LOGIN</span>
                    <img src="./assets/dfinity.svg" class="inline-flex h-3 ml-1" />
                </button>
                <button v-if="!principal" @click="logInNFID()" class="bg-gray-200 text-gray-800 py-2 px-3 rounded hover:bg-gray-100 hover:text-gray-700">
                  <img src="./assets/nfid.png" class="h-6" />
                </button>
                <div v-else class="relative inline-block">
                  <button @click="toggleDD" class="relative z-10 flex items-center p-2 text-sm text-gray-600 bg-white border border-transparent rounded-md focus:border-blue-500 focus:ring-opacity-40 focus:ring focus:outline-none">
                      <span class="mx-1">User-{{principal.substring(0, 5)}}</span>
                      <svg class="w-5 h-5 mx-1" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                          <path d="M12 15.713L18.01 9.70299L16.597 8.28799L12 12.888L7.40399 8.28799L5.98999 9.70199L12 15.713Z" 
                            fill="currentColor">
                          </path>
                      </svg>
                  </button>
                  <div :class="dropdownOn ? 'block' : 'hidden'" 
                    class="absolute right-0 z-20 w-56 py-2 mt-2 overflow-hidden bg-white rounded-md shadow-xl text-sm">
                    <a @click="viewClaim" 
                      class="block px-4 py-3 capitalize transition-colors duration-200 transform hover:bg-gray-100 cursor-pointer">
                      Claim Site
                    </a>
                    <a @click="viewAuctions" 
                      class="block px-4 py-3 capitalize transition-colors duration-200 transform hover:bg-gray-100 cursor-pointer">
                      Ad Auction
                    </a>
                    <hr class="border-gray-200">
                    <a @click="logOut()" 
                      class="block px-4 py-3 capitalize transition-colors duration-200 transform hover:bg-gray-100 cursor-pointer">
                      Logout
                    </a>
                  </div>
                </div>
              </div>
            </nav>
            <!-- SEARCH RESULT PAGE NAV -->
            <nav class="flex items-center justify-between mt-1 mb-1">
                <img @click="reset" class="hidden xl:block cursor-pointer" style="max-width:130px;" src="./assets/kinic_0_470px.png" alt="">
                <div class="flex flex-col block relative mx-auto text-gray-600 w-full xl:w-5/12">
                  <input 
                    style="border-width: 1px;" autofocus 
                    class="border-gray-200 bg-white h-10 px-5 pl-12 rounded-xl text-sm focus:outline-none w-full customHover text-lg"
                    type="search" name="search" placeholder="" v-model="search" @keyup.enter="termSearch('in')">
                    <i class="absolute left-4 top-1 mt-2 mr-4">
                      <img src="./assets/search.svg" class="text-gray-400 h-4 w-4 fill-current" />
                    </i>
                    <div v-if="searchMode && category && !this.search" @click="categorySearchNewest(category)"
                      class="absolute top-2 p-1 pl-3 pr-3 right-10 text-white text-sm mr-2 ml-2 text-center cursor-pointer bg-gray-400 hover:bg-gray-800 rounded-xl leading-4">
                      View newest
                    </div>
                 </div>
                 <div class="hidden xl:block auth flex items-center text-sm">
                   <div v-if="!principal" class="relative inline-block">
                      <button @click="toggleDD" 
                        class="relative z-10 flex items-center p-2 text-sm text-gray-600 bg-white border border-transparent 
                        rounded-md focus:border-blue-500 focus:ring-opacity-40 focus:ring focus:outline-none">
                          <span class="mx-1">Login</span>
                          <svg class="w-5 h-5 mx-1" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                              <path d="M12 15.713L18.01 9.70299L16.597 8.28799L12 12.888L7.40399 8.28799L5.98999 9.70199L12 15.713Z" fill="currentColor"></path>
                          </svg>
                      </button>
                      <div :class="dropdownOn ? 'block' : 'hidden'" class="absolute right-0 z-20 w-56 py-2 mt-2 overflow-hidden bg-white rounded-md shadow-xl text-sm">
                        <a @click="logIn()" 
                          class="block px-4 py-3 capitalize transition-colors duration-200 transform hover:bg-gray-100 cursor-pointer">
                          Login with Internet Identity
                        </a>
                        <a @click="logInNFID()" 
                          class="block px-4 py-3 capitalize transition-colors duration-200 transform hover:bg-gray-100 cursor-pointer">
                          Login NFID
                        </a>
                      </div>
                    </div>

                    <div v-else class="relative inline-block">
                        <button @click="toggleDD" class="relative z-10 flex items-center p-2 text-sm text-gray-600 bg-white border border-transparent rounded-md focus:border-blue-500 focus:ring-opacity-40 focus:ring focus:outline-none">
                            <span class="mx-1">User-{{principal.substring(0, 5)}}</span>
                            <svg class="w-5 h-5 mx-1" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M12 15.713L18.01 9.70299L16.597 8.28799L12 12.888L7.40399 8.28799L5.98999 9.70199L12 15.713Z" fill="currentColor"></path>
                            </svg>
                        </button>
                        <div :class="dropdownOn ? 'block' : 'hidden'" class="absolute right-0 z-20 w-56 py-2 mt-2 overflow-hidden bg-white rounded-md shadow-xl text-sm">
                          <a @click="viewClaim" 
                            class="block px-4 py-3 capitalize transition-colors duration-200 transform hover:bg-gray-100 cursor-pointer">
                            Claim Site
                          </a>
                          <a @click="viewAuctions" 
                            class="block px-4 py-3 capitalize transition-colors duration-200 transform hover:bg-gray-100 cursor-pointer">
                            Ad Auction
                          </a>
                          <hr class="border-gray-200">
                          <a @click="logOut()" 
                            class="block px-4 py-3 capitalize transition-colors duration-200 transform hover:bg-gray-100 cursor-pointer">
                            Logout
                          </a>
                        </div>
                    </div>
                  </div>
            </nav>
        </div>
    </header>

    <!-- HEADER FOR LANDING PAGE -->
    <header v-if="!searchMode && !whitepaperMode" class="h-full blackBG">
          <div class="content px-8 py-2 pt-5">
              <!-- LANDING NAV -->
              <nav class="flex items-center justify-between mb-4">
                <h2 class="font-bold text-2xl"></h2>
                <div class="auth flex items-center mr-14">
                    <button v-if="!principal" @click="logIn()" 
                      class="bg-gray-50 text-gray-800 py-3 px-3 rounded hover:bg-gray-100 hover:text-gray-700 mr-2">
                      <span class="loginStyle">LOGIN</span>
                      <img src="./assets/dfinity.svg" class="inline-flex h-5 ml-1" />
                    </button>
                    <button v-if="!principal" @click="logInNFID()" class="bg-gray-50 text-gray-800 py-1 px-3 rounded hover:bg-gray-100 hover:text-gray-700">
                      <img src="./assets/nfid.png" class="h-10" />
                    </button>
                    <div v-else class="relative inline-block">
                       <button @click="toggleDD" 
                          class="relative z-10 flex items-center p-2 text-sm text-gray-600 bg-white border border-transparent 
                          rounded-md focus:border-blue-500 focus:ring-opacity-40 focus:ring focus:outline-none">
                            <span class="mx-1">User-{{principal.substring(0, 5)}}</span>
                            <svg class="w-5 h-5 mx-1" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M12 15.713L18.01 9.70299L16.597 8.28799L12 12.888L7.40399 8.28799L5.98999 9.70199L12 15.713Z" fill="currentColor"></path>
                            </svg>
                       </button>
                       <div :class="dropdownOn ? 'block' : 'hidden'" 
                          class="absolute right-0 z-20 w-56 py-2 mt-2 overflow-hidden bg-white rounded-md shadow-xl text-sm">
                          <a @click="viewClaim" 
                              class="block px-4 py-3 capitalize transition-colors duration-200 transform hover:bg-gray-100 cursor-pointer">
                              Claim Site
                          </a>
                          <a @click="viewAuctions" 
                              class="block px-4 py-3 capitalize transition-colors duration-200 transform hover:bg-gray-100 cursor-pointer">
                              Ad Auction
                          </a>
                          <hr class="border-gray-200">
                          <a @click="logOut()" 
                              class="block px-4 py-3 capitalize transition-colors duration-200 transform hover:bg-gray-100 cursor-pointer">
                              Logout
                          </a>
                       </div>
                   </div>
                </div>
              </nav>
          </div>
    </header>

    <!-- SEARCH RESULTS -->
    <section v-if="searchMode && !whitepaperMode" class="mx-auto w-full px-3 sm:pl-[5%] md:pl-[14%] lg:pl-52 mt-6">
      <div v-for="item in results[page]" :key="item.canisterid" class="max-w-xl mb-8">

        <div v-if="item.canisterid.length === 27" class="group">
            <b v-if="item.notnull" class="text-xs redText"> https://{{item.canisterid}}.icp0.io/ </b>
            <b v-else class="text-xs redText"> https://{{item.canisterid}}.raw.icp0.io/ </b>
            <a v-if="item.notnull && item.title" @click="recordClick(item.canisterid)" :href="'https://' + item.canisterid + '.icp0.io/'">
              <h2 class="truncate text-xl group-hover:underline blueText"> {{item.title}} </h2>
            </a>
            <a v-else-if="item.title" @click="recordClick(item.canisterid)" :href="'https://' + item.canisterid + '.raw.icp0.io/'">
              <h2 class="truncate text-xl group-hover:underline blueText"> {{item.title}} </h2>
            </a>
            <a v-else @click="recordClick(item.canisterid)" :href="'https://' + item.canisterid + '.raw.icp0.io/'">
              <h2 class="truncate text-xl group-hover:underline blueText"> No Title </h2>
            </a>
        </div>

        <div v-else class="group">
            <b class="text-xs redText"> {{item.subnetid}} </b>
            <a v-if="item.title" @click="recordClick(item.canisterid)" :href="'http://' + item.subnetid">
              <h2 class="truncate text-xl group-hover:underline blueText"> {{item.title}} </h2>
            </a>
            <a v-else @click="recordClick(item.canisterid)" :href="'http://' + item.subnetid">
              <h2 class="truncate text-xl group-hover:underline blueText"> No Title </h2>
            </a>
        </div>

        <p class="line-clamp-2 text-gray-900"> {{item.subtitle}} </p>
        <p v-if="item.canisterid.length === 27" class="line-clamp-2 text-gray-900 text-sm font-light"> ID: {{item.canisterid}} </p>
        <p v-if="item.canisterid.length === 27" class="line-clamp-2 text-gray-900 text-sm font-light"> Subnet: {{item.subnetid}} </p>
        <span v-if="item.status && item.status === 'official'" 
          class="bg-blue-100 text-blue-800 text-xs font-semibold mr-2 px-2.5 py-0.5 rounded dark:bg-blue-200 dark:text-blue-800">
          OFFICIAL
        </span>
        <a v-if="item.note && item.note === 'ICME'"  target="_blank" href="https://www.icme.io">
          <span class="bg-gray-100 text-gray-800 text-xs font-semibold mr-2 px-2.5 py-0.5 rounded dark:bg-gray-700 dark:text-gray-300 ml-1">
            BUILT ON ICME.IO
          </span>
        </a>
        <a v-if="item.note && item.note.indexOf('github') > -1"  target="_blank" :href="item.note">
          <span class="bg-gray-100 text-gray-800 text-xs font-semibold mr-2 px-2.5 py-0.5 rounded dark:bg-gray-700 dark:text-gray-300 ml-1">
            OPEN SOURCE
          </span>
        </a>
        <a v-if="item.note && item.note.indexOf('twitter') > -1"  target="_blank" :href="item.note">
          <svg style="display:inline;" class="w-5 h-5 text-blue-300 fill-current ml-1 pointer" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
            <path d="M23.953 4.57a10 10 0 01-2.825.775 4.958 4.958 0 002.163-2.723c-.951.555-2.005.959-3.127 1.184a4.92 4.92 0 00-8.384 4.482C7.69 8.095 4.067 6.13 1.64 3.162a4.822 4.822 0 00-.666 2.475c0 1.71.87 3.213 2.188 4.096a4.904 4.904 0 01-2.228-.616v.06a4.923 4.923 0 003.946 4.827 4.996 4.996 0 01-2.212.085 4.936 4.936 0 004.604 3.417 9.867 9.867 0 01-6.102 2.105c-.39 0-.779-.023-1.17-.067a13.995 13.995 0 007.557 2.209c9.053 0 13.998-7.496 13.998-13.985 0-.21 0-.42-.015-.63A9.935 9.935 0 0024 4.59z" />
          </svg>
        </a>
      </div>
      <div v-if="results.length === 0" class="max-w-xl mb-8 animate-pulse"> ... </div>
    </section>

    <!--
        AD SPACE
        We could do this programatically and swap out the text and image.. but we have plans for some crazy Ad types. Therefore each category needs to be unique.
    -->

    <div v-if="searchMode && category === 'landing'" @click="dropdownOn = false" class="hidden lg:block w-full mx-auto rounded-lg bg-white shadow-lg px-5 pt-5 pb-10 text-gray-800 fixed top-52 right-24 adSpace">
        <div class="w-full pt-1 pb-5">
          <img class="w-60 -mt-16 mx-auto shadow-lg" src="./assets/icme.png" alt="">
        </div>
        <div class="w-full mb-10">
          <p class="text-gray-600 text-center px-5">
              Login and make a bid on your category. The winner of the auction will have their Ad shown under the category for a two week duration. During this time the next auction will take place! Contact 
              <a target="_blank" href="https://twitter.com/kinic_app">@kinic_app</a> on Twitter for support.
          </p>
        </div>
        <div class="w-full">
            <p class="text-lg text-indigo-500 text-center addFont">Category | {{category || 'N/A'}}</p>
            <a target="_blank" href="https://www.icme.io/">
              <p class="text-sm text-center underline">Visit icme.io for no-code content creation on web3.</p>
            </a>
        </div>
    </div>
    <div v-else-if="searchMode && category === 'nftbl'" @click="dropdownOn = false" 
        class="hidden lg:block w-full mx-auto rounded-lg bg-white shadow-lg px-5 pt-5 pb-10 text-gray-800 fixed top-52 right-24 adSpace">
        <div class="w-full pt-1 pb-5">
          <img class="w-60 -mt-16 mx-auto shadow-lg" src="./assets/toniq.png" alt="">
        </div>
        <div class="w-full mb-10">
          <p class="text-gray-600 text-center px-5">
              Login and make a bid on your category. The winner of the auction will have their Ad shown under the category for a two week duration. During this time the next auction will take place! Contact 
              <a target="_blank" href="https://twitter.com/kinic_app">@kinic_app</a> on Twitter for support.
          </p>
        </div>
        <div class="w-full">
            <p class="text-lg text-indigo-500 text-center addFont">Category | {{category || 'N/A'}}</p>
            <a target="_blank" href="https://toniqlabs.com/" class="text-sm text-center underline">
              <p class="text-sm text-center underline">Visit Toniqlabs for NFT and tooling for web3.</p>
            </a>
        </div>
    </div>
    <div v-else-if="searchMode && category === 'defibl'" @click="dropdownOn = false" 
      class="hidden lg:block w-full mx-auto rounded-lg bg-white shadow-lg px-5 pt-5 pb-10 text-gray-800 fixed top-52 right-24 adSpace">   
        <div class="w-full pt-1 pb-5">
            <img class="w-40 -mt-16 mx-auto shadow-lg" src="./assets/infinityswap.png" alt="">
        </div>
        <div class="w-full mb-10 text-gray-600 text-center px-5">The Platform to Create, Stake and Swap Tokens on the Internet Computer (Dfinity).</div>
        <div class="w-full">
            <p class="text-lg text-indigo-500 text-center addFont">Category | {{category || 'N/A'}}</p>
            <a target="_blank" href="https://exwqn-uaaaa-aaaaf-qaeaa-cai.icp0.io/Infinity-Swap">
              <p class="text-sm text-center underline">InfinitySwap News on Nuance, the Publishing Platform for Web3.</p>
            </a>
        </div>
    </div>
    <div v-else-if="searchMode && category === 'interestingbl'" @click="dropdownOn = false" 
        class="hidden lg:block w-full mx-auto rounded-lg bg-white shadow-lg px-5 pt-5 pb-10 text-gray-800 fixed top-52 right-24 adSpace"> 
        <div class="w-full pt-1 pb-5">
            <div class="overflow-hidden w-160 -mt-16 mx-auto shadow-lg">
                <video controls> <source src="./assets/icos_demo.mp4" type="video/mp4"> </video>
            </div>
        </div>
        <div class="w-full mb-10 text-gray-600 text-center px-5">
            ICPCS is building an ecosystem on the Internet Computer powered by NFTs. Access your own personalized portal into the IC - featuring powerful dApps, staking rewards, on-chain file storage and much more, all in one place. Join the ICPCS Community today!
        </div>
        <div class="w-full">
            <p class="text-lg text-indigo-500 text-center addFont">Category | {{category || 'N/A'}}</p>
            <a target="_blank" href="https://icpcs.io/"><p class="text-sm text-center underline">Read more about ICPCS</p></a>
        </div>
    </div>
    <div v-else-if="searchMode && category === 'investorbl'" @click="dropdownOn = false" 
      class="hidden lg:block w-full mx-auto rounded-lg bg-white shadow-lg px-5 pt-5 pb-10 text-gray-800 fixed top-52 right-24 adSpace">
        <div class="w-full pt-1 pb-5">
            <img class="w-60 -mt-16 mx-auto shadow-lg" src="./assets/icpanalysis.png" alt="">
        </div>  
        <div class="w-full mb-10 text-gray-600 text-center px-5">
            The ICP Analysis DSCVR portal will be the single most influential space for Internet Computer microeconomic discussion. It will feature monthly supply-demand-price reports from Kyle Langham, as well as deep data drives into the IC ecosystem.
        </div>
        <div class="w-full">
            <p class="text-lg text-indigo-500 text-center addFont">Category | {{category || 'N/A'}}</p>
            <a target="_blank" href="https://kn5ky-6iaaa-aaaai-qbikq-cai.icp0.io/project.html?projectId=18">
              <p class="text-sm text-center underline">Access NFTs for Season one on sale now!</p>
            </a>
        </div>
    </div>
    <div v-else-if="searchMode && category === 'daobl'" @click="dropdownOn = false" 
      class="hidden lg:block w-full mx-auto rounded-lg bg-white shadow-lg px-5 pt-5 pb-10 text-gray-800 fixed top-52 right-24 adSpace">
        <div class="w-full pt-1 pb-5">
            <img class="w-60 -mt-16 mx-auto shadow-lg" src="./assets/flowerdao.png" alt="">
        </div>  
        <div class="w-full mb-10 text-gray-600 text-center px-5">
            Community controlled launchpad by @btcflower | Merging the best Web3 stack with the finest art | Exclusively covering developments in the DAO.
        </div>
        <div class="w-full">
            <p class="text-lg text-indigo-500 text-center addFont">Category | {{category || 'N/A'}}</p>
            <a target="_blank" href="https://oot6y-haaaa-aaaae-qaa7q-cai.icp0.io/">
              <p class="text-sm text-center underline">Check it out now!</p>
            </a>
        </div>
    </div>
    <div v-else-if="searchMode && category === 'funnybl'" @click="dropdownOn = false" 
      class="hidden lg:block w-full mx-auto rounded-lg bg-white shadow-lg px-5 pt-5 pb-10 text-gray-800 fixed top-52 right-24 adSpace">     
        <div class="w-full pt-1 pb-5">
            <img class="w-80 -mt-16 mx-auto shadow-lg" src="./assets/tacos.gif" alt="">
        </div>  
        <div class="w-full mb-10 text-gray-600 text-center px-5">
            Taco NFTs are stoked to support Kinic’s mission of innovation and discovery on ICP and all of the devs working on Supernova!
        </div>
        <div class="w-full">
            <p class="text-lg text-indigo-500 text-center addFont">Category | {{category || 'N/A'}}</p>
            <a target="_blank" href="https://taconfts.xyz/">
              <p class="text-sm text-center underline">
                Learn more about our 10,000 Tacos living on the ICP Blockchain, join our community and mint your own at taconfts.xyz
              </p>
            </a>
        </div>
    </div>
    <div v-else-if="searchMode && category === 'utilitybl'" @click="dropdownOn = false" class="hidden lg:block w-full mx-auto rounded-lg bg-white shadow-lg px-5 pt-5 pb-10 text-gray-800 fixed top-52 right-24 adSpace">
        <div class="w-full pt-1 pb-5">
            <img class="w-60 -mt-16 mx-auto shadow-lg" src="./assets/nfid.png" alt="">
        </div>   
        <div class="w-full mb-10 text-gray-600 text-center px-5">
            You and your users want a delightful onboarding experience to Web3, complete with proof of humanity and wallet support, and without sacrificing privacy or security. Get it all and then some (soon) with NFID built atop Internet Identity! Contact 
            <a target="_blank" href="https://twitter.com/IdentityMaxis">@IdentityMaxis</a> 
            on Twitter for support.
        </div>
        <div class="w-full">
            <p class="text-lg text-indigo-500 text-center addFont">Category | {{category || 'N/A'}}</p>
            <a target="_blank" href="https://3y5ko-7qaaa-aaaal-aaaaq-cai.raw.icp0.io/">
              <p class="text-sm text-center underline">Visit NFID for secure one touch authentication on the IC.</p>
            </a>
        </div>
    </div>
    <div v-else-if="searchMode" @click="dropdownOn = false" 
      class="hidden lg:block w-full mx-auto rounded-lg bg-white shadow-lg px-5 pt-5 pb-10 text-gray-800 fixed top-52 right-24 adSpace">
        <div class="w-full pt-1 pb-5">
            <div class="overflow-hidden w-60 -mt-16 mx-auto shadow-lg"></div>
        </div>
        <div class="w-full mb-10">
            <div class="text-3xl text-indigo-500 text-center leading-tight addFont">Your AD</div>
            <p class="text-gray-600 text-center px-5">
              Login and make a bid on your category. The winner of the auction will have their Ad shown under the category for a two week duration. During this time the next auction will take place! Contact 
              <a target="_blank" href="https://twitter.com/kinic_app">@kinic_app</a> on Twitter for support.
            </p>
        </div>
        <div class="w-full">
            <p class="text-lg text-indigo-500 text-center addFont">Category | {{category || 'N/A'}}</p>
        </div>
    </div>

    <!-- PAGINATION -->
    <div v-if="searchMode && pages > 1" class="flex flex-col items-center my-12">
      <div class="flex text-gray-700">
          <div @click="backPage()" class="h-12 w-12 mr-1 flex justify-center items-center rounded-full bg-gray-200 cursor-pointer">
              <svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" fill="none" viewBox="0 0 24 24" 
                  stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" 
                  class="feather feather-chevron-left w-6 h-6">
                  <polyline points="15 18 9 12 15 6"></polyline>
              </svg>
          </div>
          <div class="flex h-12 font-medium rounded-full bg-gray-200">
              <div v-for="i in pages" :key="i" @click="changePage(i)" 
                :class="i == (page + 1) ? 'bg-gray-100' : ''" class="w-12 md:flex justify-center items-center hidden cursor-pointer leading-5 transition duration-150 ease-in rounded-full">
                {{i}}
              </div>
          </div>
          <div @click="nextPage()" class="h-12 w-12 ml-1 flex justify-center items-center rounded-full bg-gray-200 cursor-pointer">
              <svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" fill="none" viewBox="0 0 24 24" 
                  stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" 
                  class="feather feather-chevron-right w-6 h-6">
                  <polyline points="9 18 15 12 9 6"></polyline>
              </svg>
          </div>
      </div>
    </div>

    <!-- SEARCH AND TITLE PAGE -->
    <section v-if="!searchMode && !whitepaperMode" @click="dropdownOn = false" class="w-full pt-20 mt-30 blackBG">
      <div class="flex justify-center">
          <img class="kinicLogo" alt="kinic logotype" src="data:image/svg+xml;base64,PHN2ZyBpZD0iTGF5ZXJfMSIgZGF0YS1uYW1lPSJMYXllciAxIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAxMzIxIDM1NC44NiI+PGRlZnM+PHN0eWxlPi5jbHMtMXtmaWxsOiNmMDVjMjI7fS5jbHMtMntmaWxsOiNmYmFmMjg7fS5jbHMtM3tmaWxsOiMyM2E4ZTA7fS5jbHMtNHtmaWxsOiNlYzE5Nzg7fTwvc3R5bGU+PC9kZWZzPjxwYXRoIGNsYXNzPSJjbHMtMSIgZD0iTTEyNjcuMjEsMzQzLjIzYTE2Mi40MiwxNjIuNDIsMCwwLDEtMTQwLjI3LDYuNEExNjAuMTYsMTYwLjE2LDAsMCwxLDEwNDAsMjYyLjY5YTE2Mi4wNiwxNjIuMDYsMCwwLDEsMC0xMjYuNzdBMTYwLjE5LDE2MC4xOSwwLDAsMSwxMTI2Ljk0LDQ5YTE2Mi45MywxNjIuOTMsMCwwLDEsMTQwLjE3LDYuMiwxNjIuMTYsMTYyLjE2LDAsMCwxLDU4LjA2LDUyLjA1TDEzMzcsOTkuNTVhMTc3LjA2LDE3Ny4wNiwwLDAsMC02My4wOS01Ni43N0ExNzYuNjYsMTc2LjY2LDAsMCwwLDExMjEuNDIsMzYsMTc1LDE3NSwwLDAsMCwxMDI3LDEzMC40YTE3NS40MiwxNzUuNDIsMCwwLDAsMCwxMzcuODEsMTc0Ljk0LDE3NC45NCwwLDAsMCw5NC40Myw5NC40MywxNzYuNiwxNzYuNiwwLDAsMCwxNTIuMy02LjcsMTc3LjQyLDE3Ny40MiwwLDAsMCw2My4wOC01Ni4yOUwxMzI1LjM3LDI5MUExNjMuNzIsMTYzLjcyLDAsMCwxLDEyNjcuMjEsMzQzLjIzWiIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTE2IC0yMS44OCkiLz48cGF0aCBjbGFzcz0iY2xzLTEiIGQ9Ik0xMTkwLjMyLDEyMS4yNGE3Ny42NSw3Ny42NSwwLDAsMSw2NC42NywzNC4xbDExLjYzLTcuNjhBOTEuNTcsOTEuNTcsMCwwLDAsMTIzMy44OSwxMThhOTEuNzksOTEuNzksMCwwLDAtNzkuMzUtMy42NSw5MS4xMyw5MS4xMywwLDAsMC00OS4xOSw0OS4xOCw5MS40OCw5MS40OCwwLDAsMCwwLDcxLjU3LDkxLjE5LDkxLjE5LDAsMCwwLDQ5LjE5LDQ5LjE5LDkxLjg3LDkxLjg3LDAsMCwwLDc5LjE2LTMuNTUsOTEuNTUsOTEuNTUsMCwwLDAsMzIuNzItMjkuMzdMMTI1NSwyNDMuMDdhNzcuNTQsNzcuNTQsMCwwLDEtMjcuNywyNSw3Ni4xNyw3Ni4xNywwLDAsMS0zNyw5LjI2cS0zMi4zMywwLTU1LjItMjIuODZ0LTIyLjg2LTU1LjJxMC0zMi4zNCwyMi44Ni01NS4yVDExOTAuMzIsMTIxLjI0WiIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTE2IC0yMS44OCkiLz48cGF0aCBjbGFzcz0iY2xzLTEiIGQ9Ik0xMjkwLjA4LDEzMS40OWExMTkuNTIsMTE5LjUyLDAsMCwwLTQyLjg4LTM4LjY0LDEyMS4yNiwxMjEuMjYsMCwwLDAtMTE3LjQsMiwxMTkuNDgsMTE5LjQ4LDAsMCwwLTQ0LDQ0LDEyMS4zNCwxMjEuMzQsMCwwLDAsMCwxMjEsMTE5LjQ1LDExOS40NSwwLDAsMCw0NCw0NCwxMjEuMjIsMTIxLjIyLDAsMCwwLDExNy40LDIsMTE5LjYxLDExOS42MSwwLDAsMCw0Mi44OC0zOC42NEwxMjc4LjQ1LDI1OWExMDYuMzEsMTA2LjMxLDAsMCwxLTM3Ljg1LDM0LjExLDEwNi43MSwxMDYuNzEsMCwwLDEtMTAzLjctMS42OCwxMDYuMjIsMTA2LjIyLDAsMCwxLTM4Ljc0LTM4Ljc0LDEwNi45NSwxMDYuOTUsMCwwLDEsMC0xMDYuODUsMTA2LjM3LDEwNi4zNywwLDAsMSwzOC43NC0zOC43NCwxMDYuOTEsMTA2LjkxLDAsMCwxLDEwMy42LTEuNzcsMTA2LjI1LDEwNi4yNSwwLDAsMSwzNy43NSwzMy44MVoiIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0xNiAtMjEuODgpIi8+PHBhdGggY2xhc3M9ImNscy0xIiBkPSJNMTMxMy43NCwxMTUuNzJhMTQ5LjE5LDE0OS4xOSwwLDAsMC01My00Ny44MSwxNDkuMzcsMTQ5LjM3LDAsMCwwLTE0NS4xLDIuMzcsMTQ4LjQ2LDE0OC40NiwwLDAsMC01NC4zMiw1NC4zMSwxNDUuNywxNDUuNywwLDAsMC0yMCw3NC43MiwxNDUuNywxNDUuNywwLDAsMCwyMCw3NC43MiwxNDguNTMsMTQ4LjUzLDAsMCwwLDU0LjMyLDU0LjMxLDE0OS40OCwxNDkuNDgsMCwwLDAsMTQ0LjgsMi41NiwxNDguMjEsMTQ4LjIxLDAsMCwwLDUyLjkzLTQ3LjQxTDEzMDEuOTEsMjc1QTEzNS4xOSwxMzUuMTksMCwwLDEsMTI1NCwzMTguMThhMTMxLjE2LDEzMS4xNiwwLDAsMS02My42OCwxNiwxMzIuNzcsMTMyLjc3LDAsMCwxLTUyLjQ0LTEwLjY0LDEzMS41OCwxMzEuNTgsMCwwLDEtNzEuNzYtNzEuNzcsMTM0LjUyLDEzNC41MiwwLDAsMSwwLTEwNC44NywxMzEuNjcsMTMxLjY3LDAsMCwxLDcxLjc2LTcxLjc3LDEzNSwxMzUsMCwwLDEsMTE2LDUuMjMsMTM0LjExLDEzNC4xMSwwLDAsMSw0OCw0My4wOFoiIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0xNiAtMjEuODgpIi8+PHJlY3QgY2xhc3M9ImNscy0yIiB4PSI0MTUuMjUiIHk9IjcuNzQiIHdpZHRoPSIxNC44MSIgaGVpZ2h0PSIzNDAuNzEiLz48cmVjdCBjbGFzcz0iY2xzLTIiIHg9IjM4NS42MiIgeT0iNy43NCIgd2lkdGg9IjE0LjgxIiBoZWlnaHQ9IjM0MC43MSIvPjxyZWN0IGNsYXNzPSJjbHMtMiIgeD0iMzU2IiB5PSI3Ljc0IiB3aWR0aD0iMTQuODEiIGhlaWdodD0iMzQwLjcxIi8+PHJlY3QgY2xhc3M9ImNscy0yIiB4PSIzMjYuMzciIHk9IjcuNzQiIHdpZHRoPSIxNC44MSIgaGVpZ2h0PSIzNDAuNzEiLz48cG9seWdvbiBjbGFzcz0iY2xzLTMiIHBvaW50cz0iNTExLjYxIDM0OC40NCA1MjYuNDIgMzQ4LjQ0IDUyNi40MiA5OS4wOSA1MTEuNjEgNzMuOTggNTExLjYxIDM0OC40NCIvPjxwb2x5Z29uIGNsYXNzPSJjbHMtMyIgcG9pbnRzPSI3ODMuMTkgNy43NCA3NjguMzcgNy43NCA3NjguMzcgMjU3LjEgNzgzLjE5IDI4Mi4yIDc4My4xOSA3Ljc0Ii8+PHBvbHlnb24gY2xhc3M9ImNscy0zIiBwb2ludHM9IjcyMy45MyA3Ljc0IDcwOS4xMiA3Ljc0IDcwOS4xMiAxNTkuOTkgNzIzLjkzIDE4NC40NyA3MjMuOTMgNy43NCIvPjxwb2x5Z29uIGNsYXNzPSJjbHMtMyIgcG9pbnRzPSI3NTMuNTYgNy43NCA3MzguNzUgNy43NCA3MzguNzUgMjA4LjEzIDc1My41NiAyMzMuMDIgNzUzLjU2IDcuNzQiLz48cG9seWdvbiBjbGFzcz0iY2xzLTMiIHBvaW50cz0iNzk4IDMyNC4zNyA2MDMuNzggNy43NCA1ODYuNSA3Ljc0IDc5NS4zMiAzNDguNDQgODEyLjgxIDM0OC40NCA4MTIuODEgNy43NCA3OTggNy43NCA3OTggMzI0LjM3Ii8+PHBvbHlnb24gY2xhc3M9ImNscy0zIiBwb2ludHM9IjU0MS4yMyAzNDguNDQgNTU2LjA1IDM0OC40NCA1NTYuMDUgMTQ4LjA1IDU0MS4yMyAxMjMuMTYgNTQxLjIzIDM0OC40NCIvPjxwb2x5Z29uIGNsYXNzPSJjbHMtMyIgcG9pbnRzPSI1MTYuNzUgNy43NCA3MjYuMiAzNDguNDQgNzQzLjQ4IDM0OC40NCA1MzQuMDMgNy43NCA1MTYuNzUgNy43NCIvPjxwb2x5Z29uIGNsYXNzPSJjbHMtMyIgcG9pbnRzPSI1NTEuNzMgNy43NCA3NjAuNzYgMzQ4LjQ0IDc3OC40NSAzNDguNDQgNTY5LjIxIDcuNzQgNTUxLjczIDcuNzQiLz48cG9seWdvbiBjbGFzcz0iY2xzLTMiIHBvaW50cz0iNTcwLjg2IDM0OC40NCA1ODUuNjcgMzQ4LjQ0IDU4NS42NyAxOTYuMiA1NzAuODYgMTcxLjcyIDU3MC44NiAzNDguNDQiLz48cG9seWdvbiBjbGFzcz0iY2xzLTMiIHBvaW50cz0iNDgxLjk4IDcuNzQgNDgxLjk4IDM0OC40NCA0OTYuNzkgMzQ4LjQ0IDQ5Ni43OSAzMS44MSA2OTEuNDIgMzQ4LjQ0IDcwOC41IDM0OC40NCA0OTkuNjggNy43NCA0ODEuOTggNy43NCIvPjxyZWN0IGNsYXNzPSJjbHMtMiIgeD0iOTE3LjU3IiB5PSI3Ljc0IiB3aWR0aD0iMTQuODEiIGhlaWdodD0iMzQwLjcxIi8+PHJlY3QgY2xhc3M9ImNscy0yIiB4PSI4NTguMzEiIHk9IjcuNzQiIHdpZHRoPSIxNC44MSIgaGVpZ2h0PSIzNDAuNzEiLz48cmVjdCBjbGFzcz0iY2xzLTIiIHg9Ijk0Ny4xOSIgeT0iNy43NCIgd2lkdGg9IjE0LjgxIiBoZWlnaHQ9IjM0MC43MSIvPjxyZWN0IGNsYXNzPSJjbHMtMiIgeD0iODg3Ljk0IiB5PSI3Ljc0IiB3aWR0aD0iMTQuODEiIGhlaWdodD0iMzQwLjcxIi8+PHJlY3QgY2xhc3M9ImNscy00IiB4PSIyOS43MSIgeT0iNC4xNiIgd2lkdGg9IjE0Ljg1IiBoZWlnaHQ9IjM0MS42NCIvPjxwb2x5Z29uIGNsYXNzPSJjbHMtNCIgcG9pbnRzPSI4OS4xMiAzNDUuOCAxMDMuOTggMzQ1LjggMTAzLjk4IDI1MS43IDg5LjEyIDIyMi43IDg5LjEyIDM0NS44Ii8+PHBvbHlnb24gY2xhc3M9ImNscy00IiBwb2ludHM9IjU5LjQyIDM0NS44IDc0LjI3IDM0NS44IDc0LjI3IDE5My42OSA2NC42OSAxNzQuOTggNzQuMjcgMTU2LjI3IDc0LjI3IDQuMTYgNTkuNDIgNC4xNiA1OS40MiAzNDUuOCIvPjxwb2x5Z29uIGNsYXNzPSJjbHMtNCIgcG9pbnRzPSIxMDMuOTggNC4xNiA4OS4xMiA0LjE2IDg5LjEyIDEyNy4yNiAxMDMuOTggOTguMjUgMTAzLjk4IDQuMTYiLz48cmVjdCBjbGFzcz0iY2xzLTQiIHk9IjQuMTYiIHdpZHRoPSIxNC44NSIgaGVpZ2h0PSIzNDEuNjQiLz48cG9seWdvbiBjbGFzcz0iY2xzLTQiIHBvaW50cz0iMTA2LjkyIDE3Ny42MiAxOTQuMzkgNi44IDE3Ny44OCA2LjggMTAzLjk4IDE1MS4xMyA5MC40MSAxNzcuNjIgMTAzLjk4IDIwNC4xMSAxNzYuNTMgMzQ1LjggMTc3Ljg4IDM0OC40NCAxOTQuMzkgMzQ4LjQ0IDE5My4wMyAzNDUuOCAxMDYuOTIgMTc3LjYyIi8+PHBvbHlnb24gY2xhc3M9ImNscy00IiBwb2ludHM9IjE0MC4zNCAxNzcuNjIgMjI3LjYxIDYuOCAyMTEuMSA2LjggMTIzLjgzIDE3Ny42MiAyMDkuNzUgMzQ1LjggMjExLjEgMzQ4LjQ0IDIyNy42MSAzNDguNDQgMjI2LjI1IDM0NS44IDE0MC4zNCAxNzcuNjIiLz48cG9seWdvbiBjbGFzcz0iY2xzLTQiIHBvaW50cz0iMTczLjU1IDE3Ny42MiAyNjAuODIgNi44IDI0NC4zMiA2LjggMTU3LjA1IDE3Ny42MiAyNDIuOTcgMzQ1LjggMjQ0LjMyIDM0OC40NCAyNjAuODIgMzQ4LjQ0IDI1OS40NyAzNDUuOCAxNzMuNTUgMTc3LjYyIi8+PHBvbHlnb24gY2xhc3M9ImNscy00IiBwb2ludHM9IjI3Ny41MyA2LjggMTkwLjI2IDE3Ny42MiAyNzcuNTMgMzQ4LjQ0IDI5NC4wNCAzNDguNDQgMjA2Ljc3IDE3Ny42MiAyOTQuMDQgNi44IDI3Ny41MyA2LjgiLz48L3N2Zz4=" />
      </div>
    </section>

    <section v-if="!searchMode && !whitepaperMode" @click="dropdownOn = false" style="margin-bottom:2%;" class="w-full blackBG">
        <div class="p-4 w-full pb-20">
            <div class="flex justify-center pt-2 relative mx-auto text-gray-600 w-9/12 xl:w-6/12 2xl:w-5/12">
                <input class="border-gray-200 bg-white h-12 px-5 pl-12 rounded-xl text-sm focus:outline-none w-full customHover text-lg"
                  style="border-width: 1px;" autofocus type="search" name="search" 
                  placeholder="Search text or a canister id" v-model="search" @keyup.enter="termSearch('in')">
                <i class="absolute left-4 top-1 mt-5 mr-4">
                  <svg class="text-gray-400 h-4 w-4 fill-current" xmlns="http://www.w3.org/2000/svg"
                    xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="Capa_1" x="0px" y="0px"
                    viewBox="0 0 56.966 56.966" style="enable-background:new 0 0 56.966 56.966;" xml:space="preserve"
                    width="512px" height="512px">
                    <path d="M55.146,51.887L41.588,37.786c3.486-4.144,5.396-9.358,5.396-14.786c0-12.682-10.318-23-23-23s-23,10.318-23,23  s10.318,23,23,23c4.761,0,9.298-1.436,13.177-4.162l13.661,14.208c0.571,0.593,1.339,0.92,2.162,0.92  c0.779,0,1.518-0.297,2.079-0.837C56.255,54.982,56.293,53.08,55.146,51.887z M23.984,6c9.374,0,17,7.626,17,17s-7.626,17-17,17  s-17-7.626-17-17S14.61,6,23.984,6z" />
                  </svg>
                </i>
            </div>
            <div class="flex justify-center mt-10">
              <button @click="termSearch('in')" 
                class="text-white font-bold py-3 px-8 rounded searchButton text-gray-800 bg-gray-300 hover:text-gray-700 hover:bg-gray-100">
                Search Web 3.0
              </button>
            </div>
        </div>
    </section>

    <div v-if="!searchMode && !whitepaperMode" @click="dropdownOn = false" class="mt-6 mx-2 ml-8 mb-2">
      <a @click="categorySearch('blog')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">Blog</a>
      <a @click="categorySearch('communication')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">Communication</a>
      <a @click="categorySearch('dao')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">DAO</a>
      <a @click="categorySearch('defi')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">Defi</a>
      <a @click="categorySearch('docs')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">Docs</a>
      <a @click="categorySearch('funny')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">Funny</a>
      <a @click="categorySearch('game')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">Games</a>
      <a @click="categorySearch('interesting')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">Interesting</a>
      <a @click="categorySearch('investor')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">Investor</a>
    </div>
    <div v-if="!searchMode && !whitepaperMode" @click="dropdownOn = false" class="mt-2 mb-10 ml-8">
      <a @click="categorySearch('portfolio')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">Portfolio</a>
      <a @click="categorySearch('landing')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">Landing</a>
      <a @click="categorySearch('learning')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">Learning</a>
      <a @click="categorySearch('music')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">Music</a>
      <a @click="categorySearch('news')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">News</a>
      <a @click="categorySearch('nft')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">NFT</a>
      <a @click="categorySearch('social')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">Social</a>
      <a @click="categorySearch('utility')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">Utility</a>
      <a @click="categorySearch('video')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">Video</a>
      <a @click="categorySearch('wip')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">Work In Progress</a>
    </div>

    <Modal v-model="adMode" :close="closeAds" class="z-20">
      <div class="modal shadow-lg">
        <button @click="closeAds" class="bg-gray-200 text-gray-800 py-2 px-3 rounded hover:bg-gray-100 hover:text-gray-700 mr-2">
          X
        </button>
        <div class="text-3xl text-indigo-500 text-center leading-tight addFont">Auctions</div>
        <div class="text-lg text-indigo-500 text-center">Bid to get your ad presented in a category for one month.</div>
        <div class="flex flex-col">
          <div class="overflow-x-auto sm:-mx-6 lg:-mx-8">
            <div class="py-2 inline-block min-w-full sm:px-6 lg:px-8">
              <b>Fund your account on the 'Claim Site' page. Auctions end after one week. Check out Twitter @kinic_app for updates!</b>
              <br/>
              <b>Kinic receives 1% of each bid for running the auction.</b>
              <input type="text" v-model="claimCanister" 
                  placeholder="The canister ID that you own and want to make an AD for (ex. 74iy7-xqaaa-aaaaf-qagra-cai)" 
                  class="block w-full p-2 mt-2 text-gray-700 bg-gray-100 appearance-none focus:outline-none focus:bg-gray-200 focus:shadow-inner mb-2"/>
              <table class="min-w-full">
                <thead class="bg-indigo-100 border-b">
                    <th scope="col" class="text-sm font-medium text-gray-900 px-6 py-4 text-left">Category</th>
                    <th scope="col" class="text-sm font-medium text-gray-900 px-6 py-4 text-left">Status</th>
                    <th scope="col" class="text-sm font-medium text-gray-900 px-6 py-4 text-left">Bids</th>
                    <th scope="col" class="text-sm font-medium text-gray-900 px-6 py-4 text-left">Highest Bid</th>
                    <th scope="col" class="text-sm font-medium text-gray-900 px-6 py-4 text-left">Manage Your Bid</th>
                </thead>
                <tbody>
                  <tr v-for="item in this.cats" :key="item.name" class="bg-white border-b">
                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">{{item.name}}</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">{{item.status}}</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">{{item.bids.length}}</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">{{item.highestBid}}</td>
                    <td v-if="item.status === 'Open'" class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                      <button :disabled="buttonClicked" @click="offerBid(item.name, claimCanister)" 
                        class="bg-green-600 text-white py-2 px-3 rounded hover:bg-green-500 mr-2">
                        Make Offer
                        <b v-if="buttonClicked">
                          <svg style="display:inline;" class="animate-spin ml-4 mr-3 h-5 w-5 text-white" 
                            xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                            <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                            <path class="opacity-75" fill="#000" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                          </svg>
                        </b>
                      </button>
                      <button :disabled="buttonClicked" @click="cancelBid(claimCanister)" 
                        class="bg-red-600 text-white py-2 px-3 rounded hover:bg-red-500 mr-2">
                        Cancel Offer
                        <b v-if="buttonClicked">
                          <svg style="display:inline;" class="animate-spin ml-4 mr-3 h-5 w-5 text-white" 
                            xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                            <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                            <path class="opacity-75" fill="#000" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                          </svg>
                        </b>
                      </button>
                    </td>
                    <td v-else class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                      <button disabled class="bg-green-400 text-white py-2 px-3 rounded mr-2 cursor-not-allowed">Make Offer</button>
                      <button disabled class="bg-red-400 text-white py-2 px-3 rounded mr-2 cursor-not-allowed">Cancel Offer</button>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </Modal>

    <Modal v-model="claimMode" :close="closeClaim" class="z-20">
      <div class="modal shadow-lg">
        <button @click="closeClaim" class="bg-gray-200 text-gray-800 py-2 px-3 rounded hover:bg-gray-100 hover:text-gray-700 mr-2">
          X
        </button>
        <div class="text-3xl text-indigo-500 text-center leading-tight addFont">Claim Site</div>
        <div class="text-lg text-indigo-500 text-center">By claiming your site you get an OFFICIAL tag which boosts SEO.</div>
        <div class="flex flex-col">
          <div class="overflow-x-auto sm:-mx-6 lg:-mx-8">
            <div class="py-2 inline-block min-w-full sm:px-6 lg:px-8">
              <p class="text-medium mt-4">1. Enter your canister's ID and make a Claim Request. If you have done this previously input ID and get funding address in step #3.</p>
              <input type="text" v-model="claimCanister" 
                placeholder="The canister ID that you own and want to claim. (ex. 74iy7-xqaaa-aaaaf-qagra-cai from the Kinic URL)" 
                class="block w-full p-2 mt-2 text-gray-700 bg-gray-100 appearance-none focus:outline-none focus:bg-gray-200 
                focus:shadow-inner mb-2" 
              />
              <button :disabled="buttonClicked" @click="claimSite(claimCanister)" 
                class="bg-green-600 text-white py-2 px-3 rounded hover:bg-green-500 mr-2">
                Claim Request
                <b v-if="buttonClicked">
                  <svg style="display:inline;" class="animate-spin ml-4 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                    <path class="opacity-75" fill="#000" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                  </svg>
                </b>
              </button>
              <p class="text-medium mt-4 mb-2">2. Use DFX with the identity that created the canister, or is an owner, and run this command.</p>
              <p class="font-light text-gray-700 bg-gray-100 px-2 py-4">dfx canister --network ic call 73j6l-2iaaa-aaaaf-qagrq-cai requestVerifyContentOwner '(principal "{{claimCanister}}")'</p>
              <p class="font-bold mt-2 mb-2 text-xs">*Your claim request needs to be manually verfied as Motoko does not have a 'canister info' method yet. This may take some time. DM us at https://twitter.com/kinic_app with this principal for support.</p>
              <hr/>
              <div class="text-2xl text-indigo-500 leading-tight addFont mt-4">Fill Account</div>
              <div class="text-medium text-indigo-500">3. Fill this address with ICP to make a bid.</div>
              <button :disabled="buttonClicked" @click="getAddress(claimCanister)" 
                class="bg-green-600 text-white py-2 px-3 rounded hover:bg-green-500 mt-2">
                Get Address & Balance
                <b v-if="buttonClicked">
                  <svg style="display:inline;" class="animate-spin ml-4 mr-3 h-5 w-5 text-white" 
                    xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                    <path class="opacity-75" fill="#000" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                  </svg>
                </b>
              </button>
              <p v-if="bidAddress" class="font-light text-gray-700 bg-gray-100 px-2 py-4 mt-2">{{bidAddress}}</p>
              <p v-if="bidAddress" class="font-bold mb-2 text-xs mb-2">*Transfer ICP to this address. The full amount will be used when you make a bid.</p>
              <p v-if="balance" class="font-light text-gray-700 bg-gray-100 px-2 py-4 my-2">{{(Number(balance)/100000000)}} ICP</p>
              <p v-if="balance" class="text-medium mt-4">Enter the account id that you want to send your balance to.</p>
              <input v-if="balance" type="text" v-model="accountID" 
                placeholder="Account ID (ex. bb1bddb10fa4e5539316e735d6559d8ae454a48aeb68cc6b454f0f9201bdb9f8)" 
                class="block w-full p-2 mt-2 text-gray-700 bg-gray-100 appearance-none focus:outline-none focus:bg-gray-200 focus:shadow-inner mb-2" />
              <button v-if="balance" :disabled="buttonClicked" @click="refound(claimCanister)" 
                class="bg-yellow-600 text-white py-2 px-3 rounded hover:bg-yellow-500 mt-2 mb-2">
                Redeem Balance
              </button>
            </div>
          </div>
        </div>
      </div>
    </Modal>
</template>

<script>
import { createActor as mainCA} from "canisters/main"
const MAIN_CANISTER_ID = process.env.MAIN_CANISTER_ID;
import axios from 'axios'
import { AuthClient } from '@dfinity/auth-client'
import { Principal } from '@dfinity/principal'
import VueCountdown from '@chenfengyuan/vue-countdown'
import { createActor as canDBService} from "./candbservice/index"
import { createActor as canDBIndex} from "./candbindex/index"

import Whitepaper from "./Whitepaper.vue"
import Header from "./Header.vue"

let main = mainCA(MAIN_CANISTER_ID);

let host = 'https://ic0.app'
let dbIndexCanisterId = 'msqgt-mqaaa-aaaaf-qaj2a-cai'
let dbServiceCanisterId;
let dbName = 'kindb'

if (location.port === '3000' || location.port === '8000') {
  //host = 'http://127.0.0.1:8080'
  //dbIndexCanisterId = 'rrkah-fqaaa-aaaaa-aaaaq-cai'
  //dbName = 'test'
}

let dbIndex = canDBIndex(dbIndexCanisterId, {agentOptions: {host}})
let dbService;

export default {
  name: 'Search',
  components: {
    VueCountdown,
    Whitepaper,
    Header
  },
  async mounted () {
    const client = await AuthClient.create()
    const isAuthenticated = await client.isAuthenticated()

    if (isAuthenticated) {
      this.identity = client.getIdentity()
      this.principal = this.identity.getPrincipal().toString()
      if (this.identity) {
        main = mainCA(MAIN_CANISTER_ID, {agentOptions: {identity: this.identity}})
      }
      // Force close.
      setTimeout(() => {
        this.dropdownOn = false
      }, 200)
    }
  },
  computed: {
    headerFunctions() {
      return {
        dropdownOn: this.dropdownOn,
        searchMode: this.searchMode,
        whitepaper: this.whitepaper,
      };
    },
  },
  methods: {
    closeAds () {
      this.adMode = false
    },
    closeClaim () {
      this.claimMode = false
    },
    getAddress (canisterId) {
        this.buttonClicked = true
        if (!canisterId || canisterId.length !== 27) {
          alert('That canister ID is not valid.')
          this.buttonClicked = false
          return;
        }

        main.getContentAccountIdentifier(Principal.fromText(canisterId)).then((res) => {
          if (res.err) {
            alert(res.err)
            this.buttonClicked = false
            return
          }
          this.bidAddress = res

          main.getContentBalance(Principal.fromText(canisterId)).then((res) => {
            if (res.err) {
              alert(res.err)
              this.buttonClicked = false
              return
            }
            this.balance = res
            this.buttonClicked = false
          })
        })
    },
    refound (canisterId) {
        this.buttonClicked = true
        if (!canisterId || canisterId.length !== 27) {
          alert('That canister ID is not valid.')
          this.buttonClicked = false
          return;
        }
        if (!this.accountID || this.accountID.length !== 64) {
          alert('This account id is not valid.')
          this.buttonClicked = false
          return;
        }

        main.refound({canisterId: Principal.fromText(canisterId), to: this.accountID}).then((res) => {
          if (res.err && res.err.main) {
            alert(res.err.main)
            this.buttonClicked = false
            return
          }
          alert("Success!")
          this.buttonClicked = false
        }).catch((err) => {
          console.log(err)
          alert("Something went wrong.")
          this.buttonClicked = false
        })
    },
    claimSite (canisterId) {
        this.buttonClicked = true
        if (!canisterId || canisterId.length !== 27) {
          alert('That canister ID is not valid.')
          this.buttonClicked = false
          return;
        }

        main.requestVerifyContentOwner(Principal.fromText(canisterId)).then((res) => {
          if (res.err) {
            alert(res.err)
            this.buttonClicked = false
            return;
          }
          alert('Request for verification sent!')
          this.buttonClicked = false
        }).catch((err) => {
          console.log(err)
          alert("Something went wrong.")
          this.buttonClicked = false
        })
    },
    offerBid (category, canisterId) {
        this.buttonClicked = true
        if (!canisterId || canisterId.length !== 27) {
          alert('That canister ID is not valid.')
          this.buttonClicked = false
          return;
        }
        main.offerBid({category, canisterId: Principal.fromText(canisterId)}).then((res) => {
          this.buttonClicked = false

          if (res.err && res.err === 'This canister is not registered.') {
            alert('Please register your canister first.')
            return;
          } else if (res.err) {
            alert(res.err)
          } else {
            alert("Success!")
          }
        }).catch((err) => {
          console.log(err)
          alert("Something went wrong.")
          this.buttonClicked = false
        });
    },
    cancelBid (canisterId) {
        this.buttonClicked = true
        if (!canisterId || canisterId.length !== 27) {
          alert('That canister ID is not valid.')
          this.buttonClicked = false
          return;
        }
        main.cancelBid(Principal.fromText(canisterId)).then((res) => {
          this.buttonClicked = false
          if (res.err && res.err === 'This canister is not registered.') {
            alert('Please register your canister first.')
            return;
          } else if (res.err) {
            alert(res.err)
          } else {
            alert("Success!")
          }
        }).catch((err) => {
          console.log(err)
          alert("Something went wrong.")
          this.buttonClicked = false
        });
    },
    viewClaim () {
      this.claimMode = true
    },
    viewAuctions () {
      main.getCategoryAll().then((res) => {
        if (res) {
          let final = []
          let bidAmounts = []
          res.forEach((ent) => {
            let obj = {
              name: ent[0],
              status: 'Pending',
              bids: [],
              highestBid: 0
            }
            if (ent[1].status) {
              for (var key in ent[1].status) {
                if (key === 'open') {
                  obj.status = 'Open'
                  obj.bids = ent[1].status.open.bids
                  if (ent[1].status.open.bids) {
                    ent[1].status.open.bids.forEach((bid) => {
                      if (bid[0] && bid[0][1]) {
                        bidAmounts.push(Number(bid[0][1])/100000000)
                      }
                    })
                    if (ent[1].status.open.end) {
                      let end = "" + Number(ent[1].status.open.end)
                      // Needs to be 13 digits for JS.
                      end = Number(end.slice(0,13))
                      if (end < Date.now()) {
                        obj.status = 'Finished'
                      }
                    }
                  }
                  bidAmounts.sort().reverse()
                  obj.highestBid = bidAmounts[0] || 0
                }
                break;
              }
            }
            final.push(obj)
          })
          this.cats = final
          this.adMode = true
        }
      }).catch((err) => {
        alert("Something went wrong.")
        this.buttonClicked = false
      })
    },
    recordClick (canisterID) {
      main.recordClick(Principal.fromText(canisterID))
    },
    async logInNFID () {
      const authClient = await AuthClient.create();
      authClient.login({
        identityProvider: 'https://nfid.one/authenticate/?applicationName=Kinic&applicationLogo=https%3A%2F%2Fb3kfi-qqaaa-aaaam-qaixq-cai.raw.icp0.io%2Ffile%3Fid%3Da4xcpig3z5d224%26minterid%3Ddgxla-dyaaa-aaaam-qaiya-cai%26tokenid%3Da4o4k-eqkor-uwiaa-aaaaa-deacg-aaqca-aaaac-q#authorize',
        windowOpenerFeatures: `left=${window.screen.width / 2 - 525 / 2}, ` + `top=${window.screen.height / 2 - 705 / 2},` + `toolbar=0,location=0,menubar=0,width=525,height=705`,
        onSuccess: async () => {
          this.identity = authClient.getIdentity()
          this.principal = this.identity.getPrincipal().toString()
          main = mainCA(MAIN_CANISTER_ID, {agentOptions: {identity: this.identity}})
          // Force close.
          setTimeout(() => {
            this.dropdownOn = false
          }, 200)
        }
      })
    },
    async logIn () {
      const authClient = await AuthClient.create();
      authClient.login({
        identityProvider: 'https://identity.ic0.app',
        onSuccess: async () => {
          this.identity = authClient.getIdentity()
          this.principal = this.identity.getPrincipal().toString()
          main = mainCA(MAIN_CANISTER_ID, {agentOptions: {identity: this.identity}})
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
      this.adMode = false
      this.whitepaperMode = false
      this.claimMode = false
      this.results = []
      this.cats = []
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
      } else if (window.location.pathname.split('/')[1] === 'whitepaper') {
        this.whitepaper()
      } else {
        this.reset();
      }
    },
    paginate (data, skip) {
      this.dropdownOn = false
      this.results = []

      if (!skip) {
        // Sort results
        data.sort(function(a, b) {
          if (a.datalength < b.datalength) {
              return 1;
          } else if (a.datalength > b.datalength) {
              return -1;
          }
          return 0;
        });

        let top = [];
        // for Vue.js. Needs new array.
        let newData = [];
        for (let i = 0; i < data.length; i++) {
          if (data[i] && data[i].status === 'official') {
            top.push(data[i])
          } else {
            newData.push(data[i])
          }
        }

        top.sort(function(a, b) {
          if (a.datalength < b.datalength) {
              return 1;
          } else if (a.datalength > b.datalength) {
              return -1;
          }
          return 0;
        });

        data = top.concat(newData)
      }

      // Set category for Ads
      if (!this.category) {
        let mainCategory = data.map(function(value, index) {
            if (value) {
              return value['apptype']
            } else {
              ''
            }
          }),
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
    async termSearch (txt) {
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
        let res = await dbService.searchCanisterId(this.search, '')
        let response = JSON.parse(res)
        let mtx = []
        mtx.push(response)
        this.paginate(mtx)
      } else {

        let res = await dbService.searchTermForParallel((this.search).split(" "))
        let response = []

        if (res[0] != '[]') {
          response = JSON.parse(res[0])

          if (response.length >= 20) {
            this.paginate(response)
            return
          }
        }

        let term = this.search
        let got = false
        let data = []
        let query_data = async (term, sk) => {
          return new Promise(async (resolve) => {
            let res = await dbService.searchTermWithTarget(true, true, true, term.split(" "), [sk])
            if (res[0] != '[]') {
              got = true
              data.push(res[0])
            }
            resolve(res)
          });
        }

        const MAX = res[1].length;
        const CONCURRENCY = 40;
        console.log("Max", MAX)
        let cnt = 0;
        let promises = [];

        for (let i = 0; i < CONCURRENCY; i++) {
          let p = new Promise((resolve) => {
            (async function loop(index) {
              if (index < MAX && !got) {
                await query_data(term, res[1][index]);
                // console.log(index)
                loop(cnt++);
                return;
              }
              resolve();
            })(cnt++);
          });
          promises.push(p);
        }
        await Promise.all(promises);
        if (data.length == 0) console.log("No result")
        let res2 = data.map(r => JSON.parse(r)).flat()
        console.log(res2.length)
        response = response.concat(res2)

        // response.forEach((r)=>{console.log(r.get("title"))})
        console.log(response.length)
        
        this.paginate(response)
      }
    },
    whitepaper () {
      let newUrlIS =  window.location.origin + '/whitepaper'
      history.pushState({}, null, newUrlIS)
      this.searchMode = false
      this.adMode = false
      this.claimMode = false
      this.results = []
      this.cats = []
      this.category = ''
      this.page = 0
      this.pages = 0
      this.search = ''
      this.whitepaperMode = true
    },
    async categorySearch (txt) {
      this.results = []
      let newUrlIS =  window.location.origin + '/category/' + txt
      if (this.page !== 0) {
        newUrlIS = window.location.origin + '/category/' + txt + '/' + (this.page + 1)
      }
      history.pushState({}, null, newUrlIS)
      this.searchMode = true
      this.category = txt

      let res = await dbService.searchCategory(txt, [])
      let response = JSON.parse(res[0])
      this.paginate(response)
    },
    async categorySearchNewest (txt) {
      this.results = []
      let newUrlIS =  window.location.origin + '/category/' + txt
      if (this.page !== 0) {
        newUrlIS = window.location.origin + '/category/' + txt + '/' + (this.page + 1)
      }
      history.pushState({}, null, newUrlIS)
      this.searchMode = true
      this.category = txt

      let res = await dbService.categorySearchNewest(txt, [])
      let response = JSON.parse(res[0])
      this.paginate(response, true)
    },
    toggleDD () {
      this.dropdownOn = !this.dropdownOn
    }
  },
  async beforeMount () {
    const self = this;

    let indexId = await dbIndex.getCanistersByPK(dbName)
    if (indexId && indexId[0]) {
        dbServiceCanisterId = indexId[0]
        dbService = canDBService(dbServiceCanisterId, {agentOptions: {host}})
    }

    window.onpopstate = function () {
      self.setSearch();
    }
    self.setSearch();
  },
  data () {
    const now = new Date();
    const auctionEnds = new Date(now.getFullYear(), 8, 26);

    return {
      time: auctionEnds - now,
      search: '',
      claimCanister: '',
      bidAddress: '',
      accountID: '',
      searchMode: false,
      adMode: false,
      whitepaperMode: false,
      claimMode: false,
      results: [],
      cats: [],
      category: '',
      page: 0,
      balance: 0,
      principal: null,
      identity: null,
      buttonClicked: false,
      dropdownOn: false
    }
  }
}
</script>
<style>
  ol.list-inside li {
    text-indent: -1em;
    padding-left: 1em;
  }
  ol.list-inside li:before {
    position: absolute;
    margin-left: -1em;
  }
  .adSpace {
    max-width: 33%;
  }
  .addFont {
    font-family: "neonize","Noto Sans JP",Helvetica,Arial,sans-serif;
  }
  .blackBG {
    background-color: #162337;
  }
  .redBG {
    background-color: #7D0B24;
  }
  .yellowBG {
    background-color: #FCB028;
  }
  .blueText {
    color: #4182d8;
  }
  .redText {
    color:#7D0B24;
  }
  .redBORDER {
    border-color:#B01234;
  }
  .searchButton {
    background-color: #4182d8;
  }
  .searchButton:hover {
    background-color: #235da9;
  }
  .customHover:hover {
    box-shadow: rgba(0 0 0 0.15) 0 6px 15px -3px, rgba(0 0 0 0.15) 0 -3px 6px -4px;
  }
  .kinicLogo {
  	max-width: 365px;
  }
  .headerSN {
    font-size: 0.9rem;
  }
  .loginStyle {
      font-weight: 900;
      font-size: 0.8rem;
      position: relative;
      top: 1px;
  }
  .modal {
    width: 80%;
    min-height: 400px;
    padding: 30px;
    box-sizing: border-box;
    background-color: #fff;
  }
</style>
