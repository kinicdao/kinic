<template>
  <div @click="dropdownOn = false" class="yellowBG">
    <div class="max-w-7xl mx-auto py-1 px-2">
      <div class="flex items-center justify-between flex-wrap">
        <div class="w-0 flex-1 flex items-center">
          <p class="ml-3 font-medium text-md truncate headerSN">
            <span v-if="!searchMode">Kinic is the world's first web3 search engine.</span>
            <span v-else>Advertisers can bid ICP to place Ads in categories. Login to see more.</span>
          </p>
        </div>
        <div class="order-3 mb-1 flex-shrink-0 w-full sm:order-2 sm:mt-0 sm:w-auto">
          <a href="https://twitter.com/kinic_app" target="_blank" class="flex items-center justify-center px-4 py-3 border border-transparent rounded-md shadow-sm text-sm text font-bold text-white bg-black hover:bg-indigo-50 hover:text-yellow-500 mt-1"> Built for #SUPERNOVA </a>
        </div>
      </div>
    </div>
  </div>

  <!-- HEADER FOR RESULTS PAGE -->
  <header v-if="searchMode" class="h-full">
        <div class="content px-8 pt-4 pb-4 blackBG">
            <!-- MOBILE NAV -->
            <nav class="block xl:hidden flex items-center justify-between mb-4">
              <img @click="reset" class="cursor-pointer" style="max-width:130px;" src="data:image/svg+xml;base64,PHN2ZyBpZD0iTGF5ZXJfMSIgZGF0YS1uYW1lPSJMYXllciAxIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAxMzIxIDM1NC44NiI+PGRlZnM+PHN0eWxlPi5jbHMtMXtmaWxsOiNmMDVjMjI7fS5jbHMtMntmaWxsOiNmYmFmMjg7fS5jbHMtM3tmaWxsOiMyM2E4ZTA7fS5jbHMtNHtmaWxsOiNlYzE5Nzg7fTwvc3R5bGU+PC9kZWZzPjxwYXRoIGNsYXNzPSJjbHMtMSIgZD0iTTEyNjcuMjEsMzQzLjIzYTE2Mi40MiwxNjIuNDIsMCwwLDEtMTQwLjI3LDYuNEExNjAuMTYsMTYwLjE2LDAsMCwxLDEwNDAsMjYyLjY5YTE2Mi4wNiwxNjIuMDYsMCwwLDEsMC0xMjYuNzdBMTYwLjE5LDE2MC4xOSwwLDAsMSwxMTI2Ljk0LDQ5YTE2Mi45MywxNjIuOTMsMCwwLDEsMTQwLjE3LDYuMiwxNjIuMTYsMTYyLjE2LDAsMCwxLDU4LjA2LDUyLjA1TDEzMzcsOTkuNTVhMTc3LjA2LDE3Ny4wNiwwLDAsMC02My4wOS01Ni43N0ExNzYuNjYsMTc2LjY2LDAsMCwwLDExMjEuNDIsMzYsMTc1LDE3NSwwLDAsMCwxMDI3LDEzMC40YTE3NS40MiwxNzUuNDIsMCwwLDAsMCwxMzcuODEsMTc0Ljk0LDE3NC45NCwwLDAsMCw5NC40Myw5NC40MywxNzYuNiwxNzYuNiwwLDAsMCwxNTIuMy02LjcsMTc3LjQyLDE3Ny40MiwwLDAsMCw2My4wOC01Ni4yOUwxMzI1LjM3LDI5MUExNjMuNzIsMTYzLjcyLDAsMCwxLDEyNjcuMjEsMzQzLjIzWiIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTE2IC0yMS44OCkiLz48cGF0aCBjbGFzcz0iY2xzLTEiIGQ9Ik0xMTkwLjMyLDEyMS4yNGE3Ny42NSw3Ny42NSwwLDAsMSw2NC42NywzNC4xbDExLjYzLTcuNjhBOTEuNTcsOTEuNTcsMCwwLDAsMTIzMy44OSwxMThhOTEuNzksOTEuNzksMCwwLDAtNzkuMzUtMy42NSw5MS4xMyw5MS4xMywwLDAsMC00OS4xOSw0OS4xOCw5MS40OCw5MS40OCwwLDAsMCwwLDcxLjU3LDkxLjE5LDkxLjE5LDAsMCwwLDQ5LjE5LDQ5LjE5LDkxLjg3LDkxLjg3LDAsMCwwLDc5LjE2LTMuNTUsOTEuNTUsOTEuNTUsMCwwLDAsMzIuNzItMjkuMzdMMTI1NSwyNDMuMDdhNzcuNTQsNzcuNTQsMCwwLDEtMjcuNywyNSw3Ni4xNyw3Ni4xNywwLDAsMS0zNyw5LjI2cS0zMi4zMywwLTU1LjItMjIuODZ0LTIyLjg2LTU1LjJxMC0zMi4zNCwyMi44Ni01NS4yVDExOTAuMzIsMTIxLjI0WiIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTE2IC0yMS44OCkiLz48cGF0aCBjbGFzcz0iY2xzLTEiIGQ9Ik0xMjkwLjA4LDEzMS40OWExMTkuNTIsMTE5LjUyLDAsMCwwLTQyLjg4LTM4LjY0LDEyMS4yNiwxMjEuMjYsMCwwLDAtMTE3LjQsMiwxMTkuNDgsMTE5LjQ4LDAsMCwwLTQ0LDQ0LDEyMS4zNCwxMjEuMzQsMCwwLDAsMCwxMjEsMTE5LjQ1LDExOS40NSwwLDAsMCw0NCw0NCwxMjEuMjIsMTIxLjIyLDAsMCwwLDExNy40LDIsMTE5LjYxLDExOS42MSwwLDAsMCw0Mi44OC0zOC42NEwxMjc4LjQ1LDI1OWExMDYuMzEsMTA2LjMxLDAsMCwxLTM3Ljg1LDM0LjExLDEwNi43MSwxMDYuNzEsMCwwLDEtMTAzLjctMS42OCwxMDYuMjIsMTA2LjIyLDAsMCwxLTM4Ljc0LTM4Ljc0LDEwNi45NSwxMDYuOTUsMCwwLDEsMC0xMDYuODUsMTA2LjM3LDEwNi4zNywwLDAsMSwzOC43NC0zOC43NCwxMDYuOTEsMTA2LjkxLDAsMCwxLDEwMy42LTEuNzcsMTA2LjI1LDEwNi4yNSwwLDAsMSwzNy43NSwzMy44MVoiIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0xNiAtMjEuODgpIi8+PHBhdGggY2xhc3M9ImNscy0xIiBkPSJNMTMxMy43NCwxMTUuNzJhMTQ5LjE5LDE0OS4xOSwwLDAsMC01My00Ny44MSwxNDkuMzcsMTQ5LjM3LDAsMCwwLTE0NS4xLDIuMzcsMTQ4LjQ2LDE0OC40NiwwLDAsMC01NC4zMiw1NC4zMSwxNDUuNywxNDUuNywwLDAsMC0yMCw3NC43MiwxNDUuNywxNDUuNywwLDAsMCwyMCw3NC43MiwxNDguNTMsMTQ4LjUzLDAsMCwwLDU0LjMyLDU0LjMxLDE0OS40OCwxNDkuNDgsMCwwLDAsMTQ0LjgsMi41NiwxNDguMjEsMTQ4LjIxLDAsMCwwLDUyLjkzLTQ3LjQxTDEzMDEuOTEsMjc1QTEzNS4xOSwxMzUuMTksMCwwLDEsMTI1NCwzMTguMThhMTMxLjE2LDEzMS4xNiwwLDAsMS02My42OCwxNiwxMzIuNzcsMTMyLjc3LDAsMCwxLTUyLjQ0LTEwLjY0LDEzMS41OCwxMzEuNTgsMCwwLDEtNzEuNzYtNzEuNzcsMTM0LjUyLDEzNC41MiwwLDAsMSwwLTEwNC44NywxMzEuNjcsMTMxLjY3LDAsMCwxLDcxLjc2LTcxLjc3LDEzNSwxMzUsMCwwLDEsMTE2LDUuMjMsMTM0LjExLDEzNC4xMSwwLDAsMSw0OCw0My4wOFoiIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0xNiAtMjEuODgpIi8+PHJlY3QgY2xhc3M9ImNscy0yIiB4PSI0MTUuMjUiIHk9IjcuNzQiIHdpZHRoPSIxNC44MSIgaGVpZ2h0PSIzNDAuNzEiLz48cmVjdCBjbGFzcz0iY2xzLTIiIHg9IjM4NS42MiIgeT0iNy43NCIgd2lkdGg9IjE0LjgxIiBoZWlnaHQ9IjM0MC43MSIvPjxyZWN0IGNsYXNzPSJjbHMtMiIgeD0iMzU2IiB5PSI3Ljc0IiB3aWR0aD0iMTQuODEiIGhlaWdodD0iMzQwLjcxIi8+PHJlY3QgY2xhc3M9ImNscy0yIiB4PSIzMjYuMzciIHk9IjcuNzQiIHdpZHRoPSIxNC44MSIgaGVpZ2h0PSIzNDAuNzEiLz48cG9seWdvbiBjbGFzcz0iY2xzLTMiIHBvaW50cz0iNTExLjYxIDM0OC40NCA1MjYuNDIgMzQ4LjQ0IDUyNi40MiA5OS4wOSA1MTEuNjEgNzMuOTggNTExLjYxIDM0OC40NCIvPjxwb2x5Z29uIGNsYXNzPSJjbHMtMyIgcG9pbnRzPSI3ODMuMTkgNy43NCA3NjguMzcgNy43NCA3NjguMzcgMjU3LjEgNzgzLjE5IDI4Mi4yIDc4My4xOSA3Ljc0Ii8+PHBvbHlnb24gY2xhc3M9ImNscy0zIiBwb2ludHM9IjcyMy45MyA3Ljc0IDcwOS4xMiA3Ljc0IDcwOS4xMiAxNTkuOTkgNzIzLjkzIDE4NC40NyA3MjMuOTMgNy43NCIvPjxwb2x5Z29uIGNsYXNzPSJjbHMtMyIgcG9pbnRzPSI3NTMuNTYgNy43NCA3MzguNzUgNy43NCA3MzguNzUgMjA4LjEzIDc1My41NiAyMzMuMDIgNzUzLjU2IDcuNzQiLz48cG9seWdvbiBjbGFzcz0iY2xzLTMiIHBvaW50cz0iNzk4IDMyNC4zNyA2MDMuNzggNy43NCA1ODYuNSA3Ljc0IDc5NS4zMiAzNDguNDQgODEyLjgxIDM0OC40NCA4MTIuODEgNy43NCA3OTggNy43NCA3OTggMzI0LjM3Ii8+PHBvbHlnb24gY2xhc3M9ImNscy0zIiBwb2ludHM9IjU0MS4yMyAzNDguNDQgNTU2LjA1IDM0OC40NCA1NTYuMDUgMTQ4LjA1IDU0MS4yMyAxMjMuMTYgNTQxLjIzIDM0OC40NCIvPjxwb2x5Z29uIGNsYXNzPSJjbHMtMyIgcG9pbnRzPSI1MTYuNzUgNy43NCA3MjYuMiAzNDguNDQgNzQzLjQ4IDM0OC40NCA1MzQuMDMgNy43NCA1MTYuNzUgNy43NCIvPjxwb2x5Z29uIGNsYXNzPSJjbHMtMyIgcG9pbnRzPSI1NTEuNzMgNy43NCA3NjAuNzYgMzQ4LjQ0IDc3OC40NSAzNDguNDQgNTY5LjIxIDcuNzQgNTUxLjczIDcuNzQiLz48cG9seWdvbiBjbGFzcz0iY2xzLTMiIHBvaW50cz0iNTcwLjg2IDM0OC40NCA1ODUuNjcgMzQ4LjQ0IDU4NS42NyAxOTYuMiA1NzAuODYgMTcxLjcyIDU3MC44NiAzNDguNDQiLz48cG9seWdvbiBjbGFzcz0iY2xzLTMiIHBvaW50cz0iNDgxLjk4IDcuNzQgNDgxLjk4IDM0OC40NCA0OTYuNzkgMzQ4LjQ0IDQ5Ni43OSAzMS44MSA2OTEuNDIgMzQ4LjQ0IDcwOC41IDM0OC40NCA0OTkuNjggNy43NCA0ODEuOTggNy43NCIvPjxyZWN0IGNsYXNzPSJjbHMtMiIgeD0iOTE3LjU3IiB5PSI3Ljc0IiB3aWR0aD0iMTQuODEiIGhlaWdodD0iMzQwLjcxIi8+PHJlY3QgY2xhc3M9ImNscy0yIiB4PSI4NTguMzEiIHk9IjcuNzQiIHdpZHRoPSIxNC44MSIgaGVpZ2h0PSIzNDAuNzEiLz48cmVjdCBjbGFzcz0iY2xzLTIiIHg9Ijk0Ny4xOSIgeT0iNy43NCIgd2lkdGg9IjE0LjgxIiBoZWlnaHQ9IjM0MC43MSIvPjxyZWN0IGNsYXNzPSJjbHMtMiIgeD0iODg3Ljk0IiB5PSI3Ljc0IiB3aWR0aD0iMTQuODEiIGhlaWdodD0iMzQwLjcxIi8+PHJlY3QgY2xhc3M9ImNscy00IiB4PSIyOS43MSIgeT0iNC4xNiIgd2lkdGg9IjE0Ljg1IiBoZWlnaHQ9IjM0MS42NCIvPjxwb2x5Z29uIGNsYXNzPSJjbHMtNCIgcG9pbnRzPSI4OS4xMiAzNDUuOCAxMDMuOTggMzQ1LjggMTAzLjk4IDI1MS43IDg5LjEyIDIyMi43IDg5LjEyIDM0NS44Ii8+PHBvbHlnb24gY2xhc3M9ImNscy00IiBwb2ludHM9IjU5LjQyIDM0NS44IDc0LjI3IDM0NS44IDc0LjI3IDE5My42OSA2NC42OSAxNzQuOTggNzQuMjcgMTU2LjI3IDc0LjI3IDQuMTYgNTkuNDIgNC4xNiA1OS40MiAzNDUuOCIvPjxwb2x5Z29uIGNsYXNzPSJjbHMtNCIgcG9pbnRzPSIxMDMuOTggNC4xNiA4OS4xMiA0LjE2IDg5LjEyIDEyNy4yNiAxMDMuOTggOTguMjUgMTAzLjk4IDQuMTYiLz48cmVjdCBjbGFzcz0iY2xzLTQiIHk9IjQuMTYiIHdpZHRoPSIxNC44NSIgaGVpZ2h0PSIzNDEuNjQiLz48cG9seWdvbiBjbGFzcz0iY2xzLTQiIHBvaW50cz0iMTA2LjkyIDE3Ny42MiAxOTQuMzkgNi44IDE3Ny44OCA2LjggMTAzLjk4IDE1MS4xMyA5MC40MSAxNzcuNjIgMTAzLjk4IDIwNC4xMSAxNzYuNTMgMzQ1LjggMTc3Ljg4IDM0OC40NCAxOTQuMzkgMzQ4LjQ0IDE5My4wMyAzNDUuOCAxMDYuOTIgMTc3LjYyIi8+PHBvbHlnb24gY2xhc3M9ImNscy00IiBwb2ludHM9IjE0MC4zNCAxNzcuNjIgMjI3LjYxIDYuOCAyMTEuMSA2LjggMTIzLjgzIDE3Ny42MiAyMDkuNzUgMzQ1LjggMjExLjEgMzQ4LjQ0IDIyNy42MSAzNDguNDQgMjI2LjI1IDM0NS44IDE0MC4zNCAxNzcuNjIiLz48cG9seWdvbiBjbGFzcz0iY2xzLTQiIHBvaW50cz0iMTczLjU1IDE3Ny42MiAyNjAuODIgNi44IDI0NC4zMiA2LjggMTU3LjA1IDE3Ny42MiAyNDIuOTcgMzQ1LjggMjQ0LjMyIDM0OC40NCAyNjAuODIgMzQ4LjQ0IDI1OS40NyAzNDUuOCAxNzMuNTUgMTc3LjYyIi8+PHBvbHlnb24gY2xhc3M9ImNscy00IiBwb2ludHM9IjI3Ny41MyA2LjggMTkwLjI2IDE3Ny42MiAyNzcuNTMgMzQ4LjQ0IDI5NC4wNCAzNDguNDQgMjA2Ljc3IDE3Ny42MiAyOTQuMDQgNi44IDI3Ny41MyA2LjgiLz48L3N2Zz4=" alt="kinic logotype">
              <div class="auth flex items-center">
                <button v-if="!principal" @click="logIn()" class="bg-gray-200 text-gray-800 py-2 px-3 rounded hover:bg-gray-100 hover:text-gray-700 mr-2">
                  <span class="loginStyle">LOGIN</span>
                  <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                     preserveAspectRatio="xMidYMid meet" viewBox="-1 -1 107.42470599999999 54.6597" width="103.42" height="48.66"
                     class="inline h-8 w-8 ml-1" data-v-45c16e28="" data-v-5e337368="">
                    <defs data-v-45c16e28="">
                        <path d="M59.62 9.14C56.48 11.99 53.72 15.07 51.71 17.53C51.71 17.53 54.95 21.18 58.49 25.09C60.41 22.72 63.17 19.51 66.36 16.61C72.26 11.2 76.1 10.11 78.33 10.11C86.64 10.11 93.37 16.92 93.37 25.35C93.37 33.7 86.64 40.51 78.33 40.6C77.94 40.6 77.46 40.55 76.89 40.42C79.29 41.52 81.92 42.31 84.37 42.31C99.58 42.31 102.55 32.03 102.72 31.28C103.16 29.39 103.42 27.42 103.42 25.4C103.38 11.38 92.15 0 78.33 0C72.56 0 66.27 3.08 59.62 9.14Z"
                              id="a2oTCciHwU" data-v-45c16e28=""></path>
                        <linearGradient id="gradientc2rIvyDhN" gradientUnits="userSpaceOnUse" x1="65.17" y1="3.67" x2="99.9" y2="39.44"
                                        data-v-45c16e28="">
                            <stop offset="21%" data-v-45c16e28="" style="stop-color: rgb(241, 90, 36); stop-opacity: 1;"></stop>
                            <stop offset="68.41000000000001%" data-v-45c16e28=""
                                  style="stop-color: rgb(251, 176, 59); stop-opacity: 1;"></stop>
                        </linearGradient>
                        <path d="M43.8 41.52C46.95 38.66 49.7 35.59 51.71 33.13C51.71 33.13 48.48 29.48 44.94 25.57C43.01 27.94 40.26 31.15 37.07 34.05C31.17 39.41 27.28 40.55 25.09 40.55C16.79 40.55 10.05 33.74 10.05 25.31C10.05 16.96 16.79 10.15 25.09 10.06C25.48 10.06 25.97 10.11 26.53 10.24C24.13 9.14 21.51 8.35 19.06 8.35C3.85 8.35 0.87 18.63 0.7 19.38C0.26 21.27 0 23.24 0 25.26C0 39.28 11.23 50.66 25.09 50.66C30.86 50.66 37.16 47.58 43.8 41.52Z"
                              id="aFWcwFIax" data-v-45c16e28=""></path>
                        <linearGradient id="gradientaIMror5Zz" gradientUnits="userSpaceOnUse" x1="38.22" y1="46.97" x2="3.5" y2="11.2"
                                        data-v-45c16e28="">
                            <stop offset="21%" data-v-45c16e28="" style="stop-color: rgb(237, 30, 121); stop-opacity: 1;"></stop>
                            <stop offset="89.29%" data-v-45c16e28="" style="stop-color: rgb(82, 39, 133); stop-opacity: 1;"></stop>
                        </linearGradient>
                        <path d="M19.1 8.57C5.24 8.23 1.16 18.1 0.81 19.37C3.47 8.3 13.37 0.04 25.14 0C34.73 0 44.43 9.21 51.59 17.53C51.6 17.51 51.61 17.5 51.62 17.49C51.62 17.49 54.86 21.13 58.4 25.04C58.4 25.04 62.42 29.7 66.71 33.79C68.37 35.37 76.45 41.74 84.23 41.96C98.49 42.36 102.42 31.94 102.64 31.15C100.02 42.27 90.09 50.57 78.29 50.62C68.69 50.62 58.99 41.4 51.8 33.08C51.78 33.1 51.77 33.11 51.76 33.13C51.76 33.13 48.52 29.48 44.98 25.57C44.98 25.57 40.96 20.91 36.68 16.83C35.01 15.25 26.88 8.79 19.1 8.57ZM0.81 19.37C0.8 19.4 0.79 19.43 0.79 19.46C0.79 19.44 0.8 19.41 0.81 19.37Z"
                              id="e1RZG6bOc" data-v-45c16e28=""></path>
                    </defs>
                    <g data-v-45c16e28="">
                        <g data-v-45c16e28="">
                            <use xlink:href="#a2oTCciHwU" opacity="1" fill="url(#gradientc2rIvyDhN)" data-v-45c16e28=""></use>
                            <g data-v-45c16e28="">
                                <use xlink:href="#a2oTCciHwU" opacity="1" fill-opacity="0" stroke="#000000" stroke-width="1"
                                     stroke-opacity="0" data-v-45c16e28=""></use>
                            </g>
                        </g>
                        <g data-v-45c16e28="">
                            <use xlink:href="#aFWcwFIax" opacity="1" fill="url(#gradientaIMror5Zz)" data-v-45c16e28=""></use>
                            <g data-v-45c16e28="">
                                <use xlink:href="#aFWcwFIax" opacity="1" fill-opacity="0" stroke="#000000" stroke-width="1"
                                     stroke-opacity="0" data-v-45c16e28=""></use>
                            </g>
                        </g>
                        <g data-v-45c16e28="">
                            <use xlink:href="#e1RZG6bOc" opacity="1" fill="#29abe2" fill-opacity="1" data-v-45c16e28=""></use>
                            <g data-v-45c16e28="">
                                <use xlink:href="#e1RZG6bOc" opacity="1" fill-opacity="0" stroke="#000000" stroke-width="1"
                                     stroke-opacity="0" data-v-45c16e28=""></use>
                            </g>
                        </g>
                    </g>
                  </svg>
                </button>
                <button v-if="!principal" @click="logInNFID()" class="bg-gray-200 text-gray-800 py-2 px-3 rounded hover:bg-gray-100 hover:text-gray-700">
                      <svg
                      width="60"
                      height="32"
                      viewBox="0 0 70 37"
                      fill="none"
                      xmlns="http://www.w3.org/2000/svg"
                      class=""
                      >
                      <path
                        d="M13.9423 10.0312C14.2583 10.0312 14.4163 10.0312 14.537 10.0956C14.6432 10.1521 14.7295 10.2424 14.7836 10.3534C14.8451 10.4796 14.8451 10.6448 14.8451 10.9752V25.4014C14.8451 25.7319 14.8451 25.8971 14.7836 26.0233C14.7295 26.1343 14.6432 26.2245 14.537 26.2811C14.4163 26.3454 14.2583 26.3454 13.9423 26.3454H11.6363C11.4803 26.3454 11.4023 26.3454 11.3301 26.325C11.2661 26.307 11.2056 26.2772 11.1515 26.2372C11.0904 26.1921 11.0406 26.1293 10.9411 26.0036L4.80368 18.2574C4.65611 18.0711 4.58232 17.978 4.51784 17.9682C4.46199 17.9598 4.40579 17.9809 4.36795 18.0247C4.32426 18.0753 4.32426 18.1962 4.32426 18.438V25.4014C4.32426 25.7319 4.32426 25.8971 4.26276 26.0233C4.20866 26.1343 4.12234 26.2245 4.01617 26.2811C3.89547 26.3454 3.73746 26.3454 3.42144 26.3454H0.902817C0.586801 26.3454 0.428793 26.3454 0.308091 26.2811C0.201919 26.2245 0.115598 26.1343 0.0615007 26.0233C0 25.8971 0 25.7319 0 25.4014V10.9752C0 10.6448 0 10.4796 0.0615007 10.3534C0.115598 10.2424 0.201919 10.1521 0.308091 10.0956C0.428793 10.0312 0.586801 10.0312 0.902816 10.0312H3.20881C3.36481 10.0312 3.44281 10.0312 3.51506 10.0516C3.57906 10.0697 3.63952 10.0994 3.69367 10.1394C3.75477 10.1846 3.80453 10.2474 3.90405 10.373L10.0415 18.1193C10.189 18.3055 10.2628 18.3987 10.3273 18.4084C10.3831 18.4169 10.4393 18.3957 10.4772 18.352C10.5209 18.3014 10.5209 18.1805 10.5209 17.9386V10.9752C10.5209 10.6448 10.5209 10.4796 10.5824 10.3534C10.6365 10.2424 10.7228 10.1521 10.829 10.0956C10.9497 10.0312 11.1077 10.0312 11.4237 10.0312H13.9423Z"
                        fill="black"
                      ></path>
                      <path
                        d="M22.4022 13.5971C22.3074 13.5971 22.26 13.5971 22.2237 13.6164C22.1919 13.6333 22.166 13.6604 22.1498 13.6937C22.1313 13.7316 22.1313 13.7811 22.1313 13.8802V16.903C22.1313 17.0021 22.1313 17.0517 22.1498 17.0895C22.166 17.1228 22.1919 17.1499 22.2237 17.1669C22.26 17.1862 22.3074 17.1862 22.4022 17.1862H28.1161C28.4321 17.1862 28.5901 17.1862 28.7108 17.2505C28.817 17.307 28.9033 17.3973 28.9574 17.5083C29.0189 17.6345 29.0189 17.7997 29.0189 18.1301V19.808C29.0189 20.1384 29.0189 20.3036 28.9574 20.4299C28.9033 20.5409 28.817 20.6311 28.7108 20.6877C28.5901 20.752 28.4321 20.752 28.1161 20.752H22.4022C22.3074 20.752 22.26 20.752 22.2237 20.7713C22.1919 20.7882 22.166 20.8153 22.1498 20.8486C22.1313 20.8865 22.1313 20.936 22.1313 21.0352V25.4014C22.1313 25.7319 22.1313 25.8971 22.0698 26.0233C22.0157 26.1343 21.9294 26.2245 21.8232 26.2811C21.7025 26.3454 21.5445 26.3454 21.2285 26.3454H18.6207C18.3047 26.3454 18.1467 26.3454 18.026 26.2811C17.9198 26.2245 17.8335 26.1343 17.7794 26.0233C17.7179 25.8971 17.7179 25.7319 17.7179 25.4014V10.9752C17.7179 10.6448 17.7179 10.4796 17.7794 10.3534C17.8335 10.2424 17.9198 10.1521 18.026 10.0956C18.1467 10.0312 18.3047 10.0312 18.6207 10.0312H29.0523C29.3683 10.0312 29.5263 10.0312 29.647 10.0956C29.7532 10.1521 29.8395 10.2424 29.8936 10.3534C29.9551 10.4796 29.9551 10.6448 29.9551 10.9752V12.6531C29.9551 12.9835 29.9551 13.1487 29.8936 13.2749C29.8395 13.3859 29.7532 13.4762 29.647 13.5328C29.5263 13.5971 29.3683 13.5971 29.0523 13.5971H22.4022Z"
                        fill="black"
                      ></path>
                      <path
                        fill-rule="evenodd"
                        clip-rule="evenodd"
                        d="M44.2751 2.05897C44.7399 2.00715 45.0766 1.57116 45.027 1.08516C44.9774 0.599165 44.5605 0.24719 44.0957 0.299006L42.3671 0.491699C41.4815 0.590417 40.7712 0.669594 40.1943 0.778949C39.6 0.891604 39.0907 1.0456 38.6177 1.32278C37.8497 1.77281 37.213 2.43227 36.7756 3.23088C36.5062 3.72285 36.3545 4.25376 36.2418 4.87364C36.1323 5.47528 36.0507 6.21649 35.9489 7.14043L35.9445 7.18023L35.7748 8.94512C35.7281 9.43142 36.0672 9.86528 36.5323 9.91418C36.9974 9.96308 37.4123 9.6085 37.4591 9.1222L37.6276 7.37003C37.7335 6.40833 37.8085 5.73352 37.9047 5.20436C37.9992 4.68504 38.1047 4.36599 38.2447 4.11035C38.5296 3.59007 38.9445 3.16021 39.4453 2.86678C39.6914 2.72253 39.9981 2.61494 40.4963 2.52049C41.005 2.42406 41.6536 2.3512 42.5785 2.2481L44.2751 2.05897ZM60.744 1.08516C60.6944 1.57116 61.0311 2.00715 61.4959 2.05897L63.1925 2.2481C64.1174 2.3512 64.766 2.42406 65.2747 2.52049C65.7729 2.61494 66.0796 2.72253 66.3257 2.86678C66.8265 3.16021 67.2414 3.59007 67.5263 4.11035C67.6663 4.36599 67.7718 4.68504 67.8663 5.20436C67.9625 5.73352 68.0375 6.40833 68.1434 7.37003L68.3119 9.1222C68.3587 9.6085 68.7736 9.96308 69.2387 9.91418C69.7038 9.86528 70.0429 9.43142 69.9962 8.94512L69.8265 7.18023L69.8221 7.14043C69.7203 6.21649 69.6387 5.47528 69.5292 4.87364C69.4165 4.25376 69.2648 3.72285 68.9953 3.23088C68.558 2.43227 67.9213 1.77281 67.1533 1.32278C66.6803 1.0456 66.171 0.891604 65.5767 0.778949C64.9998 0.669594 64.2895 0.590417 63.4039 0.491699L61.6753 0.299006C61.2105 0.24719 60.7935 0.599165 60.744 1.08516ZM60.7435 35.2913C60.6939 34.8053 61.0306 34.3693 61.4954 34.3175L63.192 34.1284C64.1169 34.0253 64.7655 33.9524 65.2742 33.856C65.7724 33.7615 66.0791 33.6539 66.3252 33.5097C66.826 33.2163 67.2409 32.7864 67.5259 32.2661C67.6658 32.0105 67.7713 31.6914 67.8658 31.1721C67.962 30.6429 68.037 29.9681 68.1429 29.0064L68.3114 27.2543C68.3582 26.768 68.7731 26.4134 69.2382 26.4623C69.7033 26.5112 70.0425 26.945 69.9957 27.4313L69.826 29.1962L69.8216 29.236C69.7198 30.16 69.6382 30.9012 69.5287 31.5028C69.416 32.1227 69.2643 32.6536 68.9949 33.1456C68.5575 33.9442 67.9208 34.6037 67.1528 35.0537C66.6798 35.3309 66.1705 35.4849 65.5762 35.5975C64.9993 35.7069 64.289 35.786 63.4034 35.8848L61.6749 36.0775C61.21 36.1293 60.7931 35.7773 60.7435 35.2913ZM45.027 35.2912C45.0766 34.8052 44.7399 34.3692 44.2751 34.3174L42.5785 34.1283C41.6536 34.0252 41.005 33.9523 40.4963 33.8559C39.9981 33.7614 39.6914 33.6538 39.4453 33.5096C38.9445 33.2162 38.5296 32.7863 38.2447 32.266C38.1047 32.0104 37.9992 31.6913 37.9047 31.172C37.8085 30.6428 37.7335 29.968 37.6276 29.0063L37.4591 27.2542C37.4123 26.7679 36.9974 26.4133 36.5323 26.4622C36.0672 26.5111 35.7281 26.9449 35.7748 27.4312L35.9445 29.1961L35.9489 29.2359C36.0507 30.1599 36.1323 30.9011 36.2418 31.5027C36.3545 32.1226 36.5062 32.6535 36.7756 33.1455C37.213 33.9441 37.8497 34.6036 38.6177 35.0536C39.0907 35.3308 39.6 35.4848 40.1943 35.5974C40.7712 35.7068 41.4815 35.7859 42.3671 35.8847L44.0957 36.0774C44.5605 36.1292 44.9774 35.7772 45.027 35.2912ZM44.8358 11.3653C44.2836 11.3653 43.8358 11.813 43.8358 12.3653V24.2729C43.8358 24.8252 44.2836 25.2729 44.8358 25.2729H46.5982C47.1505 25.2729 47.5982 24.8252 47.5982 24.2729V12.3653C47.5982 11.813 47.1505 11.3653 46.5982 11.3653H44.8358ZM51.0701 11.3653C50.5178 11.3653 50.0701 11.813 50.0701 12.3653V24.2729C50.0701 24.8252 50.5178 25.2729 51.0701 25.2729H56.3597C57.8166 25.2729 59.1087 24.9881 60.2361 24.4186C61.3636 23.849 62.2377 23.041 62.8584 21.9947C63.4791 20.9483 63.7895 19.7231 63.7895 18.3191C63.7895 16.9151 63.4791 15.6899 62.8584 14.6435C62.2377 13.5971 61.3636 12.7891 60.2361 12.2196C59.1087 11.65 57.8166 11.3653 56.3597 11.3653H51.0701ZM58.944 21.1205C58.2599 21.796 57.3478 22.1337 56.2077 22.1337H54.1325C53.9668 22.1337 53.8325 21.9994 53.8325 21.8337V14.8044C53.8325 14.6387 53.9668 14.5044 54.1325 14.5044H56.2077C57.3478 14.5044 58.2599 14.8422 58.944 15.5177C59.6407 16.1932 59.9891 17.127 59.9891 18.3191C59.9891 19.5111 59.6407 20.4449 58.944 21.1205Z"
                        fill="url(#paint0_linear_2608_11359)"
                      ></path>
                      <defs>
                        <linearGradient
                          id="paint0_linear_2608_11359"
                          x1="43.9989"
                          y1="12.2042"
                          x2="56.4702"
                          y2="29.5414"
                          gradientUnits="userSpaceOnUse"
                        >
                          <stop stop-color="#CC5CDC"></stop>
                          <stop offset="0.244792" stop-color="#7B66FF"></stop>
                          <stop offset="0.520833" stop-color="#1F8AF0"></stop>
                          <stop offset="0.760417" stop-color="#00D1FF"></stop>
                          <stop offset="1" stop-color="#3DEDD7"></stop>
                        </linearGradient>
                      </defs>
                    </svg>
                  </button>
                  <div v-else class="relative inline-block">
                     <button @click="toggleDD" class="relative z-10 flex items-center p-2 text-sm text-gray-600 bg-white border border-transparent rounded-md focus:border-blue-500 focus:ring-opacity-40 focus:ring focus:outline-none">
                         <span class="mx-1">User-{{principal.substring(0, 5)}}</span>
                         <svg class="w-5 h-5 mx-1" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                             <path d="M12 15.713L18.01 9.70299L16.597 8.28799L12 12.888L7.40399 8.28799L5.98999 9.70199L12 15.713Z" fill="currentColor"></path>
                         </svg>
                     </button>
                     <div :class="dropdownOn ? 'block' : 'hidden'" class="absolute right-0 z-20 w-56 py-2 mt-2 overflow-hidden bg-white rounded-md shadow-xl text-sm">
                       <a @click="viewClaim" class="block px-4 py-3 capitalize transition-colors duration-200 transform hover:bg-gray-100 cursor-pointer">
                           Claim Site
                       </a>

                       <a @click="viewAuctions" class="block px-4 py-3 capitalize transition-colors duration-200 transform hover:bg-gray-100 cursor-pointer">
                           Ad Auction
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
            <nav class="flex items-center justify-between mt-1 mb-1">
                <img @click="reset" class="hidden xl:block cursor-pointer" style="max-width:130px;" src="./assets/kinic_0_470px.png" alt="">
                <div class="hidden xl:block relative mx-auto text-gray-600 w-9/12 xl:w-5/12">
                   <input style="border-width: 1px;" autofocus class="border-gray-200 bg-white h-10 px-5 pl-12 rounded-xl text-sm focus:outline-none w-full customHover text-lg"
                     type="search" name="search" placeholder="" v-model="search" @keyup.enter="termSearch('in')">
                   <i class="absolute left-4 top-1 mt-2 mr-4">
                     <svg class="text-gray-400 h-4 w-4 fill-current" xmlns="http://www.w3.org/2000/svg"
                       xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="Capa_1" x="0px" y="0px"
                       viewBox="0 0 56.966 56.966" style="enable-background:new 0 0 56.966 56.966;" xml:space="preserve"
                       width="512px" height="512px">
                       <path
                         d="M55.146,51.887L41.588,37.786c3.486-4.144,5.396-9.358,5.396-14.786c0-12.682-10.318-23-23-23s-23,10.318-23,23  s10.318,23,23,23c4.761,0,9.298-1.436,13.177-4.162l13.661,14.208c0.571,0.593,1.339,0.92,2.162,0.92  c0.779,0,1.518-0.297,2.079-0.837C56.255,54.982,56.293,53.08,55.146,51.887z M23.984,6c9.374,0,17,7.626,17,17s-7.626,17-17,17  s-17-7.626-17-17S14.61,6,23.984,6z" />
                     </svg>
                   </i>
                 </div>
                 <input style="border-width: 1px;" class="block xl:hidden border-gray-200 bg-white h-12 px-5 pl-6 rounded-xl text-sm focus:outline-none w-full customHover text-lg"
                   type="search" name="search" placeholder="" v-model="search" @keyup.enter="termSearch('in')">
                 <div class="hidden xl:block auth flex items-center text-sm">
                   <div v-if="!principal" class="relative inline-block">
                      <button @click="toggleDD" class="relative z-10 flex items-center p-2 text-sm text-gray-600 bg-white border border-transparent rounded-md focus:border-blue-500 focus:ring-opacity-40 focus:ring focus:outline-none">
                          <span class="mx-1">Login</span>
                          <svg class="w-5 h-5 mx-1" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                              <path d="M12 15.713L18.01 9.70299L16.597 8.28799L12 12.888L7.40399 8.28799L5.98999 9.70199L12 15.713Z" fill="currentColor"></path>
                          </svg>
                      </button>
                      <div :class="dropdownOn ? 'block' : 'hidden'" class="absolute right-0 z-20 w-56 py-2 mt-2 overflow-hidden bg-white rounded-md shadow-xl text-sm">

                        <a @click="logIn()" class="block px-4 py-3 capitalize transition-colors duration-200 transform hover:bg-gray-100 cursor-pointer">
                            Login with Internet Identity
                        </a>
                        <a @click="logInNFID()" class="block px-4 py-3 capitalize transition-colors duration-200 transform hover:bg-gray-100 cursor-pointer">
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

                           <a @click="viewClaim" class="block px-4 py-3 capitalize transition-colors duration-200 transform hover:bg-gray-100 cursor-pointer">
                               Claim Site
                           </a>
                           <a @click="viewAuctions" class="block px-4 py-3 capitalize transition-colors duration-200 transform hover:bg-gray-100 cursor-pointer">
                               Ad Auction
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

    <!-- HEADER FOR LANDING PAGE -->
    <header v-if="!searchMode" class="h-full blackBG">
          <div class="content px-8 py-2 pt-5">
              <!-- LANDING NAV -->
              <nav class="flex items-center justify-between mb-4">
                <h2 class="font-bold text-2xl"></h2>
                <div class="auth flex items-center mr-14">
                    <button v-if="!principal" @click="logIn()" class="bg-gray-200 text-gray-800 py-2 px-3 rounded hover:bg-gray-100 hover:text-gray-700 mr-2">
                      <span class="loginStyle">LOGIN</span>
                      <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                         preserveAspectRatio="xMidYMid meet" viewBox="-1 -1 107.42470599999999 54.6597" width="103.42" height="48.66"
                         class="inline h-8 w-8 ml-1" data-v-45c16e28="" data-v-5e337368="">
                        <defs data-v-45c16e28="">
                            <path d="M59.62 9.14C56.48 11.99 53.72 15.07 51.71 17.53C51.71 17.53 54.95 21.18 58.49 25.09C60.41 22.72 63.17 19.51 66.36 16.61C72.26 11.2 76.1 10.11 78.33 10.11C86.64 10.11 93.37 16.92 93.37 25.35C93.37 33.7 86.64 40.51 78.33 40.6C77.94 40.6 77.46 40.55 76.89 40.42C79.29 41.52 81.92 42.31 84.37 42.31C99.58 42.31 102.55 32.03 102.72 31.28C103.16 29.39 103.42 27.42 103.42 25.4C103.38 11.38 92.15 0 78.33 0C72.56 0 66.27 3.08 59.62 9.14Z"
                                  id="a2oTCciHwU" data-v-45c16e28=""></path>
                            <linearGradient id="gradientc2rIvyDhN" gradientUnits="userSpaceOnUse" x1="65.17" y1="3.67" x2="99.9" y2="39.44"
                                            data-v-45c16e28="">
                                <stop offset="21%" data-v-45c16e28="" style="stop-color: rgb(241, 90, 36); stop-opacity: 1;"></stop>
                                <stop offset="68.41000000000001%" data-v-45c16e28=""
                                      style="stop-color: rgb(251, 176, 59); stop-opacity: 1;"></stop>
                            </linearGradient>
                            <path d="M43.8 41.52C46.95 38.66 49.7 35.59 51.71 33.13C51.71 33.13 48.48 29.48 44.94 25.57C43.01 27.94 40.26 31.15 37.07 34.05C31.17 39.41 27.28 40.55 25.09 40.55C16.79 40.55 10.05 33.74 10.05 25.31C10.05 16.96 16.79 10.15 25.09 10.06C25.48 10.06 25.97 10.11 26.53 10.24C24.13 9.14 21.51 8.35 19.06 8.35C3.85 8.35 0.87 18.63 0.7 19.38C0.26 21.27 0 23.24 0 25.26C0 39.28 11.23 50.66 25.09 50.66C30.86 50.66 37.16 47.58 43.8 41.52Z"
                                  id="aFWcwFIax" data-v-45c16e28=""></path>
                            <linearGradient id="gradientaIMror5Zz" gradientUnits="userSpaceOnUse" x1="38.22" y1="46.97" x2="3.5" y2="11.2"
                                            data-v-45c16e28="">
                                <stop offset="21%" data-v-45c16e28="" style="stop-color: rgb(237, 30, 121); stop-opacity: 1;"></stop>
                                <stop offset="89.29%" data-v-45c16e28="" style="stop-color: rgb(82, 39, 133); stop-opacity: 1;"></stop>
                            </linearGradient>
                            <path d="M19.1 8.57C5.24 8.23 1.16 18.1 0.81 19.37C3.47 8.3 13.37 0.04 25.14 0C34.73 0 44.43 9.21 51.59 17.53C51.6 17.51 51.61 17.5 51.62 17.49C51.62 17.49 54.86 21.13 58.4 25.04C58.4 25.04 62.42 29.7 66.71 33.79C68.37 35.37 76.45 41.74 84.23 41.96C98.49 42.36 102.42 31.94 102.64 31.15C100.02 42.27 90.09 50.57 78.29 50.62C68.69 50.62 58.99 41.4 51.8 33.08C51.78 33.1 51.77 33.11 51.76 33.13C51.76 33.13 48.52 29.48 44.98 25.57C44.98 25.57 40.96 20.91 36.68 16.83C35.01 15.25 26.88 8.79 19.1 8.57ZM0.81 19.37C0.8 19.4 0.79 19.43 0.79 19.46C0.79 19.44 0.8 19.41 0.81 19.37Z"
                                  id="e1RZG6bOc" data-v-45c16e28=""></path>
                        </defs>
                        <g data-v-45c16e28="">
                            <g data-v-45c16e28="">
                                <use xlink:href="#a2oTCciHwU" opacity="1" fill="url(#gradientc2rIvyDhN)" data-v-45c16e28=""></use>
                                <g data-v-45c16e28="">
                                    <use xlink:href="#a2oTCciHwU" opacity="1" fill-opacity="0" stroke="#000000" stroke-width="1"
                                         stroke-opacity="0" data-v-45c16e28=""></use>
                                </g>
                            </g>
                            <g data-v-45c16e28="">
                                <use xlink:href="#aFWcwFIax" opacity="1" fill="url(#gradientaIMror5Zz)" data-v-45c16e28=""></use>
                                <g data-v-45c16e28="">
                                    <use xlink:href="#aFWcwFIax" opacity="1" fill-opacity="0" stroke="#000000" stroke-width="1"
                                         stroke-opacity="0" data-v-45c16e28=""></use>
                                </g>
                            </g>
                            <g data-v-45c16e28="">
                                <use xlink:href="#e1RZG6bOc" opacity="1" fill="#29abe2" fill-opacity="1" data-v-45c16e28=""></use>
                                <g data-v-45c16e28="">
                                    <use xlink:href="#e1RZG6bOc" opacity="1" fill-opacity="0" stroke="#000000" stroke-width="1"
                                         stroke-opacity="0" data-v-45c16e28=""></use>
                                </g>
                            </g>
                        </g>
                      </svg>
                    </button>
                    <button v-if="!principal" @click="logInNFID()" class="bg-gray-200 text-gray-800 py-2 px-3 rounded hover:bg-gray-100 hover:text-gray-700">
                        <svg
                        width="60"
                        height="32"
                        viewBox="0 0 70 37"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                        class=""
                      >
                        <path
                          d="M13.9423 10.0312C14.2583 10.0312 14.4163 10.0312 14.537 10.0956C14.6432 10.1521 14.7295 10.2424 14.7836 10.3534C14.8451 10.4796 14.8451 10.6448 14.8451 10.9752V25.4014C14.8451 25.7319 14.8451 25.8971 14.7836 26.0233C14.7295 26.1343 14.6432 26.2245 14.537 26.2811C14.4163 26.3454 14.2583 26.3454 13.9423 26.3454H11.6363C11.4803 26.3454 11.4023 26.3454 11.3301 26.325C11.2661 26.307 11.2056 26.2772 11.1515 26.2372C11.0904 26.1921 11.0406 26.1293 10.9411 26.0036L4.80368 18.2574C4.65611 18.0711 4.58232 17.978 4.51784 17.9682C4.46199 17.9598 4.40579 17.9809 4.36795 18.0247C4.32426 18.0753 4.32426 18.1962 4.32426 18.438V25.4014C4.32426 25.7319 4.32426 25.8971 4.26276 26.0233C4.20866 26.1343 4.12234 26.2245 4.01617 26.2811C3.89547 26.3454 3.73746 26.3454 3.42144 26.3454H0.902817C0.586801 26.3454 0.428793 26.3454 0.308091 26.2811C0.201919 26.2245 0.115598 26.1343 0.0615007 26.0233C0 25.8971 0 25.7319 0 25.4014V10.9752C0 10.6448 0 10.4796 0.0615007 10.3534C0.115598 10.2424 0.201919 10.1521 0.308091 10.0956C0.428793 10.0312 0.586801 10.0312 0.902816 10.0312H3.20881C3.36481 10.0312 3.44281 10.0312 3.51506 10.0516C3.57906 10.0697 3.63952 10.0994 3.69367 10.1394C3.75477 10.1846 3.80453 10.2474 3.90405 10.373L10.0415 18.1193C10.189 18.3055 10.2628 18.3987 10.3273 18.4084C10.3831 18.4169 10.4393 18.3957 10.4772 18.352C10.5209 18.3014 10.5209 18.1805 10.5209 17.9386V10.9752C10.5209 10.6448 10.5209 10.4796 10.5824 10.3534C10.6365 10.2424 10.7228 10.1521 10.829 10.0956C10.9497 10.0312 11.1077 10.0312 11.4237 10.0312H13.9423Z"
                          fill="black"
                        ></path>
                        <path
                          d="M22.4022 13.5971C22.3074 13.5971 22.26 13.5971 22.2237 13.6164C22.1919 13.6333 22.166 13.6604 22.1498 13.6937C22.1313 13.7316 22.1313 13.7811 22.1313 13.8802V16.903C22.1313 17.0021 22.1313 17.0517 22.1498 17.0895C22.166 17.1228 22.1919 17.1499 22.2237 17.1669C22.26 17.1862 22.3074 17.1862 22.4022 17.1862H28.1161C28.4321 17.1862 28.5901 17.1862 28.7108 17.2505C28.817 17.307 28.9033 17.3973 28.9574 17.5083C29.0189 17.6345 29.0189 17.7997 29.0189 18.1301V19.808C29.0189 20.1384 29.0189 20.3036 28.9574 20.4299C28.9033 20.5409 28.817 20.6311 28.7108 20.6877C28.5901 20.752 28.4321 20.752 28.1161 20.752H22.4022C22.3074 20.752 22.26 20.752 22.2237 20.7713C22.1919 20.7882 22.166 20.8153 22.1498 20.8486C22.1313 20.8865 22.1313 20.936 22.1313 21.0352V25.4014C22.1313 25.7319 22.1313 25.8971 22.0698 26.0233C22.0157 26.1343 21.9294 26.2245 21.8232 26.2811C21.7025 26.3454 21.5445 26.3454 21.2285 26.3454H18.6207C18.3047 26.3454 18.1467 26.3454 18.026 26.2811C17.9198 26.2245 17.8335 26.1343 17.7794 26.0233C17.7179 25.8971 17.7179 25.7319 17.7179 25.4014V10.9752C17.7179 10.6448 17.7179 10.4796 17.7794 10.3534C17.8335 10.2424 17.9198 10.1521 18.026 10.0956C18.1467 10.0312 18.3047 10.0312 18.6207 10.0312H29.0523C29.3683 10.0312 29.5263 10.0312 29.647 10.0956C29.7532 10.1521 29.8395 10.2424 29.8936 10.3534C29.9551 10.4796 29.9551 10.6448 29.9551 10.9752V12.6531C29.9551 12.9835 29.9551 13.1487 29.8936 13.2749C29.8395 13.3859 29.7532 13.4762 29.647 13.5328C29.5263 13.5971 29.3683 13.5971 29.0523 13.5971H22.4022Z"
                          fill="black"
                        ></path>
                        <path
                          fill-rule="evenodd"
                          clip-rule="evenodd"
                          d="M44.2751 2.05897C44.7399 2.00715 45.0766 1.57116 45.027 1.08516C44.9774 0.599165 44.5605 0.24719 44.0957 0.299006L42.3671 0.491699C41.4815 0.590417 40.7712 0.669594 40.1943 0.778949C39.6 0.891604 39.0907 1.0456 38.6177 1.32278C37.8497 1.77281 37.213 2.43227 36.7756 3.23088C36.5062 3.72285 36.3545 4.25376 36.2418 4.87364C36.1323 5.47528 36.0507 6.21649 35.9489 7.14043L35.9445 7.18023L35.7748 8.94512C35.7281 9.43142 36.0672 9.86528 36.5323 9.91418C36.9974 9.96308 37.4123 9.6085 37.4591 9.1222L37.6276 7.37003C37.7335 6.40833 37.8085 5.73352 37.9047 5.20436C37.9992 4.68504 38.1047 4.36599 38.2447 4.11035C38.5296 3.59007 38.9445 3.16021 39.4453 2.86678C39.6914 2.72253 39.9981 2.61494 40.4963 2.52049C41.005 2.42406 41.6536 2.3512 42.5785 2.2481L44.2751 2.05897ZM60.744 1.08516C60.6944 1.57116 61.0311 2.00715 61.4959 2.05897L63.1925 2.2481C64.1174 2.3512 64.766 2.42406 65.2747 2.52049C65.7729 2.61494 66.0796 2.72253 66.3257 2.86678C66.8265 3.16021 67.2414 3.59007 67.5263 4.11035C67.6663 4.36599 67.7718 4.68504 67.8663 5.20436C67.9625 5.73352 68.0375 6.40833 68.1434 7.37003L68.3119 9.1222C68.3587 9.6085 68.7736 9.96308 69.2387 9.91418C69.7038 9.86528 70.0429 9.43142 69.9962 8.94512L69.8265 7.18023L69.8221 7.14043C69.7203 6.21649 69.6387 5.47528 69.5292 4.87364C69.4165 4.25376 69.2648 3.72285 68.9953 3.23088C68.558 2.43227 67.9213 1.77281 67.1533 1.32278C66.6803 1.0456 66.171 0.891604 65.5767 0.778949C64.9998 0.669594 64.2895 0.590417 63.4039 0.491699L61.6753 0.299006C61.2105 0.24719 60.7935 0.599165 60.744 1.08516ZM60.7435 35.2913C60.6939 34.8053 61.0306 34.3693 61.4954 34.3175L63.192 34.1284C64.1169 34.0253 64.7655 33.9524 65.2742 33.856C65.7724 33.7615 66.0791 33.6539 66.3252 33.5097C66.826 33.2163 67.2409 32.7864 67.5259 32.2661C67.6658 32.0105 67.7713 31.6914 67.8658 31.1721C67.962 30.6429 68.037 29.9681 68.1429 29.0064L68.3114 27.2543C68.3582 26.768 68.7731 26.4134 69.2382 26.4623C69.7033 26.5112 70.0425 26.945 69.9957 27.4313L69.826 29.1962L69.8216 29.236C69.7198 30.16 69.6382 30.9012 69.5287 31.5028C69.416 32.1227 69.2643 32.6536 68.9949 33.1456C68.5575 33.9442 67.9208 34.6037 67.1528 35.0537C66.6798 35.3309 66.1705 35.4849 65.5762 35.5975C64.9993 35.7069 64.289 35.786 63.4034 35.8848L61.6749 36.0775C61.21 36.1293 60.7931 35.7773 60.7435 35.2913ZM45.027 35.2912C45.0766 34.8052 44.7399 34.3692 44.2751 34.3174L42.5785 34.1283C41.6536 34.0252 41.005 33.9523 40.4963 33.8559C39.9981 33.7614 39.6914 33.6538 39.4453 33.5096C38.9445 33.2162 38.5296 32.7863 38.2447 32.266C38.1047 32.0104 37.9992 31.6913 37.9047 31.172C37.8085 30.6428 37.7335 29.968 37.6276 29.0063L37.4591 27.2542C37.4123 26.7679 36.9974 26.4133 36.5323 26.4622C36.0672 26.5111 35.7281 26.9449 35.7748 27.4312L35.9445 29.1961L35.9489 29.2359C36.0507 30.1599 36.1323 30.9011 36.2418 31.5027C36.3545 32.1226 36.5062 32.6535 36.7756 33.1455C37.213 33.9441 37.8497 34.6036 38.6177 35.0536C39.0907 35.3308 39.6 35.4848 40.1943 35.5974C40.7712 35.7068 41.4815 35.7859 42.3671 35.8847L44.0957 36.0774C44.5605 36.1292 44.9774 35.7772 45.027 35.2912ZM44.8358 11.3653C44.2836 11.3653 43.8358 11.813 43.8358 12.3653V24.2729C43.8358 24.8252 44.2836 25.2729 44.8358 25.2729H46.5982C47.1505 25.2729 47.5982 24.8252 47.5982 24.2729V12.3653C47.5982 11.813 47.1505 11.3653 46.5982 11.3653H44.8358ZM51.0701 11.3653C50.5178 11.3653 50.0701 11.813 50.0701 12.3653V24.2729C50.0701 24.8252 50.5178 25.2729 51.0701 25.2729H56.3597C57.8166 25.2729 59.1087 24.9881 60.2361 24.4186C61.3636 23.849 62.2377 23.041 62.8584 21.9947C63.4791 20.9483 63.7895 19.7231 63.7895 18.3191C63.7895 16.9151 63.4791 15.6899 62.8584 14.6435C62.2377 13.5971 61.3636 12.7891 60.2361 12.2196C59.1087 11.65 57.8166 11.3653 56.3597 11.3653H51.0701ZM58.944 21.1205C58.2599 21.796 57.3478 22.1337 56.2077 22.1337H54.1325C53.9668 22.1337 53.8325 21.9994 53.8325 21.8337V14.8044C53.8325 14.6387 53.9668 14.5044 54.1325 14.5044H56.2077C57.3478 14.5044 58.2599 14.8422 58.944 15.5177C59.6407 16.1932 59.9891 17.127 59.9891 18.3191C59.9891 19.5111 59.6407 20.4449 58.944 21.1205Z"
                          fill="url(#paint0_linear_2608_11359)"
                        ></path>
                        <defs>
                          <linearGradient
                            id="paint0_linear_2608_11359"
                            x1="43.9989"
                            y1="12.2042"
                            x2="56.4702"
                            y2="29.5414"
                            gradientUnits="userSpaceOnUse"
                          >
                            <stop stop-color="#CC5CDC"></stop>
                            <stop offset="0.244792" stop-color="#7B66FF"></stop>
                            <stop offset="0.520833" stop-color="#1F8AF0"></stop>
                            <stop offset="0.760417" stop-color="#00D1FF"></stop>
                            <stop offset="1" stop-color="#3DEDD7"></stop>
                          </linearGradient>
                        </defs>
                      </svg>
                    </button>
                    <div v-else class="relative inline-block">
                       <button @click="toggleDD" class="relative z-10 flex items-center p-2 text-sm text-gray-600 bg-white border border-transparent rounded-md focus:border-blue-500 focus:ring-opacity-40 focus:ring focus:outline-none">
                           <span class="mx-1">User-{{principal.substring(0, 5)}}</span>
                           <svg class="w-5 h-5 mx-1" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                               <path d="M12 15.713L18.01 9.70299L16.597 8.28799L12 12.888L7.40399 8.28799L5.98999 9.70199L12 15.713Z" fill="currentColor"></path>
                           </svg>
                       </button>
                       <div :class="dropdownOn ? 'block' : 'hidden'" class="absolute right-0 z-20 w-56 py-2 mt-2 overflow-hidden bg-white rounded-md shadow-xl text-sm">


                         <a @click="viewClaim" class="block px-4 py-3 capitalize transition-colors duration-200 transform hover:bg-gray-100 cursor-pointer">
                             Claim Site
                         </a>
                         <a @click="viewAuctions" class="block px-4 py-3 capitalize transition-colors duration-200 transform hover:bg-gray-100 cursor-pointer">
                             Ad Auction
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
      <div v-for="item in results[page]" :key="item.Canisterid" class="max-w-xl mb-8">
        <div v-if="item.Canisterid.length === 27" class="group">
          <b class="text-xs redText">
            https://{{item.Canisterid}}.raw.ic0.app/
          </b>
          <a v-if="item.Title" @click="recordClick(item.Canisterid)" :href="'https://' + item.Canisterid + '.raw.ic0.app/'">
            <h2 class="truncate text-xl group-hover:underline blueText">
              {{item.Title}}
            </h2>
          </a>
          <a v-else @click="recordClick(item.Canisterid)" :href="'https://' + item.Canisterid + '.raw.ic0.app/'">
            <h2 class="truncate text-xl group-hover:underline blueText">
              No Title
            </h2>
          </a>
        </div>
        <div v-else class="group">
          <b class="text-xs redText">
            {{item.Subnetid}}
          </b>
          <a v-if="item.Title" @click="recordClick(item.Canisterid)" :href="'http://' + item.Subnetid">
            <h2 class="truncate text-xl group-hover:underline blueText">
              {{item.Title}}
            </h2>
          </a>
          <a v-else @click="recordClick(item.Canisterid)" :href="'http://' + item.Subnetid">
            <h2 class="truncate text-xl group-hover:underline blueText">
              No Title
            </h2>
          </a>
        </div>
        <p class="line-clamp-2 text-gray-900">
          {{item.Subtitle}}
        </p>
        <p v-if="item.Canisterid.length === 27" class="line-clamp-2 text-gray-900 text-sm font-light">
          ID: {{item.Canisterid}}
        </p>
        <p v-if="item.Canisterid.length === 27" class="line-clamp-2 text-gray-900 text-sm font-light">
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

    <!--
        AD SPACE
        We could do this programatically and swap out the text and image.. but we have plans for some crazy Ad types. Therefore each category needs to be unique.
    -->
    <div v-if="searchMode && category === 'landingbl'" @click="dropdownOn = false" class="hidden lg:block w-full mx-auto rounded-lg bg-white shadow-lg px-5 pt-5 pb-10 text-gray-800 fixed top-52 right-24 adSpace">
        <div class="w-full pt-1 pb-5">
            <div class="overflow-hidden w-60 -mt-16 mx-auto shadow-lg">
                <img src="./assets/icme.png" alt="">
            </div>
        </div>
        <div class="w-full mb-10">
            <p class="text-gray-600 text-center px-5">
              Login and make a bid on your category. The winner of the auction will have their Ad shown under the category for a two week duration.
              During this time the next auction will take place! Contact <a target="_blank" href="https://twitter.com/kinic_app">@kinic_app</a> on Twitter for support.
            </p>
        </div>
        <div class="w-full">
            <p class="text-lg text-indigo-500 text-center addFont">Category | {{category || 'N/A'}}</p>
            <a target="_blank" href="https://www.icme.io/"><p class="text-sm text-center underline">Visit icme.io for no-code content creation on web3.</p></a>
        </div>
    </div>
    <div v-else-if="searchMode && category === 'nftbl'" @click="dropdownOn = false" class="hidden lg:block w-full mx-auto rounded-lg bg-white shadow-lg px-5 pt-5 pb-10 text-gray-800 fixed top-52 right-24 adSpace">
        <div class="w-full pt-1 pb-5">
            <div class="overflow-hidden w-60 -mt-16 mx-auto shadow-lg">
                <img src="./assets/toniq.png" alt="">
            </div>
        </div>
        <div class="w-full mb-10">
            <p class="text-gray-600 text-center px-5">
              Login and make a bid on your category. The winner of the auction will have their Ad shown under the category for a two week duration.
              During this time the next auction will take place! Contact <a target="_blank" href="https://twitter.com/kinic_app">@kinic_app</a> on Twitter for support.
            </p>
        </div>
        <div class="w-full">
            <p class="text-lg text-indigo-500 text-center addFont">Category | {{category || 'N/A'}}</p>
            <a target="_blank" href="https://toniqlabs.com/"><p class="text-sm text-center underline">Visit Toniqlabs for NFT and tooling for web3.</p></a>
        </div>
    </div>
    <div v-else-if="searchMode && category === 'defibl'" @click="dropdownOn = false" class="hidden lg:block w-full mx-auto rounded-lg bg-white shadow-lg px-5 pt-5 pb-10 text-gray-800 fixed top-52 right-24 adSpace">
        <div class="w-full pt-1 pb-5">
            <div class="overflow-hidden w-40 -mt-16 mx-auto shadow-lg">
                <img src="./assets/infinityswap.png" alt="">
            </div>
        </div>
        <div class="w-full mb-10">
            <p class="text-gray-600 text-center px-5">
              The Platform to Create, Stake and Swap Tokens on the Internet Computer (Dfinity).
            </p>
        </div>
        <div class="w-full">
            <p class="text-lg text-indigo-500 text-center addFont">Category | {{category || 'N/A'}}</p>
            <a target="_blank" href="https://exwqn-uaaaa-aaaaf-qaeaa-cai.ic0.app/Infinity-Swap"><p class="text-sm text-center underline">InfinitySwap News on Nuance, the Publishing Platform for Web3.</p></a>
        </div>
    </div>
    <div v-else-if="searchMode && category === 'interestingbl'" @click="dropdownOn = false" class="hidden lg:block w-full mx-auto rounded-lg bg-white shadow-lg px-5 pt-5 pb-10 text-gray-800 fixed top-52 right-24 adSpace">
        <div class="w-full pt-1 pb-5">
            <div class="overflow-hidden w-160 -mt-16 mx-auto shadow-lg">
                  <video controls>
                    <source src="./assets/icos_demo.mp4" type="video/mp4">
                  </video>
            </div>
        </div>
        <div class="w-full mb-10">
            <p class="text-gray-600 text-center px-5">
              ICPCS is building an ecosystem on the Internet Computer powered by NFTs.
              Access your own personalized portal into the IC - featuring powerful dApps, staking rewards, on-chain file storage and much more, all in one place. Join the ICPCS Community today!
            </p>
        </div>
        <div class="w-full">
            <p class="text-lg text-indigo-500 text-center addFont">Category | {{category || 'N/A'}}</p>
            <a target="_blank" href="https://icpcs.io/"><p class="text-sm text-center underline">Read more about ICPCS</p></a>
        </div>
    </div>
    <div v-else-if="searchMode && category === 'investorbl'" @click="dropdownOn = false" class="hidden lg:block w-full mx-auto rounded-lg bg-white shadow-lg px-5 pt-5 pb-10 text-gray-800 fixed top-52 right-24 adSpace">
        <div class="w-full pt-1 pb-5">
            <div class="overflow-hidden w-60 -mt-16 mx-auto shadow-lg">
                <img src="./assets/icpanalysis.png" alt="">
            </div>
        </div>
        <div class="w-full mb-10">
            <p class="text-gray-600 text-center px-5">
              The ICP Analysis DSCVR portal will be the single most influential space for Internet Computer microeconomic discussion. It will feature monthly supply-demand-price reports from Kyle Langham, as well as deep data drives into the IC ecosystem.
            </p>
        </div>
        <div class="w-full">
            <p class="text-lg text-indigo-500 text-center addFont">Category | {{category || 'N/A'}}</p>
            <a target="_blank" href="https://kn5ky-6iaaa-aaaai-qbikq-cai.ic0.app/project.html?projectId=18"><p class="text-sm text-center underline">Access NFTs for Season one on sale now!</p></a>
        </div>
    </div>
    <div v-else-if="searchMode && category === 'daobl'" @click="dropdownOn = false" class="hidden lg:block w-full mx-auto rounded-lg bg-white shadow-lg px-5 pt-5 pb-10 text-gray-800 fixed top-52 right-24 adSpace">
        <div class="w-full pt-1 pb-5">
            <div class="overflow-hidden w-60 -mt-16 mx-auto shadow-lg">
                <img src="./assets/flowerdao.png" alt="">
            </div>
        </div>
        <div class="w-full mb-10">
            <p class="text-gray-600 text-center px-5">
              Community controlled launchpad by @btcflower | Merging the best Web3 stack with the finest art | Exclusively covering developments in the DAO.
            </p>
        </div>
        <div class="w-full">
            <p class="text-lg text-indigo-500 text-center addFont">Category | {{category || 'N/A'}}</p>
            <a target="_blank" href="https://oot6y-haaaa-aaaae-qaa7q-cai.ic0.app/"><p class="text-sm text-center underline">Check it out now!</p></a>
        </div>
    </div>
    <div v-else-if="searchMode && category === 'funnybl'" @click="dropdownOn = false" class="hidden lg:block w-full mx-auto rounded-lg bg-white shadow-lg px-5 pt-5 pb-10 text-gray-800 fixed top-52 right-24 adSpace">
        <div class="w-full pt-1 pb-5">
            <div class="overflow-hidden w-80 -mt-16 mx-auto shadow-lg">
                <img src="./assets/tacos.gif" alt="">
            </div>
        </div>
        <div class="w-full mb-10">
            <p class="text-gray-600 text-center px-5">
              Taco NFTs are stoked to support Kinic’s mission of innovation and discovery on ICP and all of the devs working on Supernova!
            </p>
        </div>
        <div class="w-full">
            <p class="text-lg text-indigo-500 text-center addFont">Category | {{category || 'N/A'}}</p>
            <a target="_blank" href="https://taconfts.xyz/"><p class="text-sm text-center underline">Learn more about our 10,000 Tacos living on the ICP Blockchain, join our community and mint your own at taconfts.xyz</p></a>
        </div>
    </div>
    <div v-else-if="searchMode && category === 'utilitybl'" @click="dropdownOn = false" class="hidden lg:block w-full mx-auto rounded-lg bg-white shadow-lg px-5 pt-5 pb-10 text-gray-800 fixed top-52 right-24 adSpace">
        <div class="w-full pt-1 pb-5">
            <div class="overflow-hidden w-60 -mt-16 mx-auto shadow-lg">
                <img src="./assets/nfid.png" alt="">
            </div>
        </div>
        <div class="w-full mb-10">
            <p class="text-gray-600 text-center px-5">
              You and your users want a delightful onboarding experience to Web3, complete with proof of humanity and wallet support, and without sacrificing privacy or security. Get it all and then some (soon) with NFID built atop Internet Identity!
              Contact <a target="_blank" href="https://twitter.com/IdentityMaxis">@IdentityMaxis</a> on Twitter for support.
            </p>
        </div>
        <div class="w-full">
            <p class="text-lg text-indigo-500 text-center addFont">Category | {{category || 'N/A'}}</p>
            <a target="_blank" href="https://3y5ko-7qaaa-aaaal-aaaaq-cai.raw.ic0.app/"><p class="text-sm text-center underline">Visit NFID for secure one touch authentication on the IC.</p></a>
        </div>
    </div>
    <div v-else-if="searchMode" @click="dropdownOn = false" class="hidden lg:block w-full mx-auto rounded-lg bg-white shadow-lg px-5 pt-5 pb-10 text-gray-800 fixed top-52 right-24 adSpace">
        <div class="w-full pt-1 pb-5">
            <div class="overflow-hidden w-60 -mt-16 mx-auto shadow-lg">
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
    <section v-if="!searchMode" @click="dropdownOn = false" class="w-full pt-20 mt-30 blackBG">
      <div class="flex justify-center">
            <img class="kinicLogo" alt="kinic logotype" src="data:image/svg+xml;base64,PHN2ZyBpZD0iTGF5ZXJfMSIgZGF0YS1uYW1lPSJMYXllciAxIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAxMzIxIDM1NC44NiI+PGRlZnM+PHN0eWxlPi5jbHMtMXtmaWxsOiNmMDVjMjI7fS5jbHMtMntmaWxsOiNmYmFmMjg7fS5jbHMtM3tmaWxsOiMyM2E4ZTA7fS5jbHMtNHtmaWxsOiNlYzE5Nzg7fTwvc3R5bGU+PC9kZWZzPjxwYXRoIGNsYXNzPSJjbHMtMSIgZD0iTTEyNjcuMjEsMzQzLjIzYTE2Mi40MiwxNjIuNDIsMCwwLDEtMTQwLjI3LDYuNEExNjAuMTYsMTYwLjE2LDAsMCwxLDEwNDAsMjYyLjY5YTE2Mi4wNiwxNjIuMDYsMCwwLDEsMC0xMjYuNzdBMTYwLjE5LDE2MC4xOSwwLDAsMSwxMTI2Ljk0LDQ5YTE2Mi45MywxNjIuOTMsMCwwLDEsMTQwLjE3LDYuMiwxNjIuMTYsMTYyLjE2LDAsMCwxLDU4LjA2LDUyLjA1TDEzMzcsOTkuNTVhMTc3LjA2LDE3Ny4wNiwwLDAsMC02My4wOS01Ni43N0ExNzYuNjYsMTc2LjY2LDAsMCwwLDExMjEuNDIsMzYsMTc1LDE3NSwwLDAsMCwxMDI3LDEzMC40YTE3NS40MiwxNzUuNDIsMCwwLDAsMCwxMzcuODEsMTc0Ljk0LDE3NC45NCwwLDAsMCw5NC40Myw5NC40MywxNzYuNiwxNzYuNiwwLDAsMCwxNTIuMy02LjcsMTc3LjQyLDE3Ny40MiwwLDAsMCw2My4wOC01Ni4yOUwxMzI1LjM3LDI5MUExNjMuNzIsMTYzLjcyLDAsMCwxLDEyNjcuMjEsMzQzLjIzWiIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTE2IC0yMS44OCkiLz48cGF0aCBjbGFzcz0iY2xzLTEiIGQ9Ik0xMTkwLjMyLDEyMS4yNGE3Ny42NSw3Ny42NSwwLDAsMSw2NC42NywzNC4xbDExLjYzLTcuNjhBOTEuNTcsOTEuNTcsMCwwLDAsMTIzMy44OSwxMThhOTEuNzksOTEuNzksMCwwLDAtNzkuMzUtMy42NSw5MS4xMyw5MS4xMywwLDAsMC00OS4xOSw0OS4xOCw5MS40OCw5MS40OCwwLDAsMCwwLDcxLjU3LDkxLjE5LDkxLjE5LDAsMCwwLDQ5LjE5LDQ5LjE5LDkxLjg3LDkxLjg3LDAsMCwwLDc5LjE2LTMuNTUsOTEuNTUsOTEuNTUsMCwwLDAsMzIuNzItMjkuMzdMMTI1NSwyNDMuMDdhNzcuNTQsNzcuNTQsMCwwLDEtMjcuNywyNSw3Ni4xNyw3Ni4xNywwLDAsMS0zNyw5LjI2cS0zMi4zMywwLTU1LjItMjIuODZ0LTIyLjg2LTU1LjJxMC0zMi4zNCwyMi44Ni01NS4yVDExOTAuMzIsMTIxLjI0WiIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTE2IC0yMS44OCkiLz48cGF0aCBjbGFzcz0iY2xzLTEiIGQ9Ik0xMjkwLjA4LDEzMS40OWExMTkuNTIsMTE5LjUyLDAsMCwwLTQyLjg4LTM4LjY0LDEyMS4yNiwxMjEuMjYsMCwwLDAtMTE3LjQsMiwxMTkuNDgsMTE5LjQ4LDAsMCwwLTQ0LDQ0LDEyMS4zNCwxMjEuMzQsMCwwLDAsMCwxMjEsMTE5LjQ1LDExOS40NSwwLDAsMCw0NCw0NCwxMjEuMjIsMTIxLjIyLDAsMCwwLDExNy40LDIsMTE5LjYxLDExOS42MSwwLDAsMCw0Mi44OC0zOC42NEwxMjc4LjQ1LDI1OWExMDYuMzEsMTA2LjMxLDAsMCwxLTM3Ljg1LDM0LjExLDEwNi43MSwxMDYuNzEsMCwwLDEtMTAzLjctMS42OCwxMDYuMjIsMTA2LjIyLDAsMCwxLTM4Ljc0LTM4Ljc0LDEwNi45NSwxMDYuOTUsMCwwLDEsMC0xMDYuODUsMTA2LjM3LDEwNi4zNywwLDAsMSwzOC43NC0zOC43NCwxMDYuOTEsMTA2LjkxLDAsMCwxLDEwMy42LTEuNzcsMTA2LjI1LDEwNi4yNSwwLDAsMSwzNy43NSwzMy44MVoiIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0xNiAtMjEuODgpIi8+PHBhdGggY2xhc3M9ImNscy0xIiBkPSJNMTMxMy43NCwxMTUuNzJhMTQ5LjE5LDE0OS4xOSwwLDAsMC01My00Ny44MSwxNDkuMzcsMTQ5LjM3LDAsMCwwLTE0NS4xLDIuMzcsMTQ4LjQ2LDE0OC40NiwwLDAsMC01NC4zMiw1NC4zMSwxNDUuNywxNDUuNywwLDAsMC0yMCw3NC43MiwxNDUuNywxNDUuNywwLDAsMCwyMCw3NC43MiwxNDguNTMsMTQ4LjUzLDAsMCwwLDU0LjMyLDU0LjMxLDE0OS40OCwxNDkuNDgsMCwwLDAsMTQ0LjgsMi41NiwxNDguMjEsMTQ4LjIxLDAsMCwwLDUyLjkzLTQ3LjQxTDEzMDEuOTEsMjc1QTEzNS4xOSwxMzUuMTksMCwwLDEsMTI1NCwzMTguMThhMTMxLjE2LDEzMS4xNiwwLDAsMS02My42OCwxNiwxMzIuNzcsMTMyLjc3LDAsMCwxLTUyLjQ0LTEwLjY0LDEzMS41OCwxMzEuNTgsMCwwLDEtNzEuNzYtNzEuNzcsMTM0LjUyLDEzNC41MiwwLDAsMSwwLTEwNC44NywxMzEuNjcsMTMxLjY3LDAsMCwxLDcxLjc2LTcxLjc3LDEzNSwxMzUsMCwwLDEsMTE2LDUuMjMsMTM0LjExLDEzNC4xMSwwLDAsMSw0OCw0My4wOFoiIHRyYW5zZm9ybT0idHJhbnNsYXRlKC0xNiAtMjEuODgpIi8+PHJlY3QgY2xhc3M9ImNscy0yIiB4PSI0MTUuMjUiIHk9IjcuNzQiIHdpZHRoPSIxNC44MSIgaGVpZ2h0PSIzNDAuNzEiLz48cmVjdCBjbGFzcz0iY2xzLTIiIHg9IjM4NS42MiIgeT0iNy43NCIgd2lkdGg9IjE0LjgxIiBoZWlnaHQ9IjM0MC43MSIvPjxyZWN0IGNsYXNzPSJjbHMtMiIgeD0iMzU2IiB5PSI3Ljc0IiB3aWR0aD0iMTQuODEiIGhlaWdodD0iMzQwLjcxIi8+PHJlY3QgY2xhc3M9ImNscy0yIiB4PSIzMjYuMzciIHk9IjcuNzQiIHdpZHRoPSIxNC44MSIgaGVpZ2h0PSIzNDAuNzEiLz48cG9seWdvbiBjbGFzcz0iY2xzLTMiIHBvaW50cz0iNTExLjYxIDM0OC40NCA1MjYuNDIgMzQ4LjQ0IDUyNi40MiA5OS4wOSA1MTEuNjEgNzMuOTggNTExLjYxIDM0OC40NCIvPjxwb2x5Z29uIGNsYXNzPSJjbHMtMyIgcG9pbnRzPSI3ODMuMTkgNy43NCA3NjguMzcgNy43NCA3NjguMzcgMjU3LjEgNzgzLjE5IDI4Mi4yIDc4My4xOSA3Ljc0Ii8+PHBvbHlnb24gY2xhc3M9ImNscy0zIiBwb2ludHM9IjcyMy45MyA3Ljc0IDcwOS4xMiA3Ljc0IDcwOS4xMiAxNTkuOTkgNzIzLjkzIDE4NC40NyA3MjMuOTMgNy43NCIvPjxwb2x5Z29uIGNsYXNzPSJjbHMtMyIgcG9pbnRzPSI3NTMuNTYgNy43NCA3MzguNzUgNy43NCA3MzguNzUgMjA4LjEzIDc1My41NiAyMzMuMDIgNzUzLjU2IDcuNzQiLz48cG9seWdvbiBjbGFzcz0iY2xzLTMiIHBvaW50cz0iNzk4IDMyNC4zNyA2MDMuNzggNy43NCA1ODYuNSA3Ljc0IDc5NS4zMiAzNDguNDQgODEyLjgxIDM0OC40NCA4MTIuODEgNy43NCA3OTggNy43NCA3OTggMzI0LjM3Ii8+PHBvbHlnb24gY2xhc3M9ImNscy0zIiBwb2ludHM9IjU0MS4yMyAzNDguNDQgNTU2LjA1IDM0OC40NCA1NTYuMDUgMTQ4LjA1IDU0MS4yMyAxMjMuMTYgNTQxLjIzIDM0OC40NCIvPjxwb2x5Z29uIGNsYXNzPSJjbHMtMyIgcG9pbnRzPSI1MTYuNzUgNy43NCA3MjYuMiAzNDguNDQgNzQzLjQ4IDM0OC40NCA1MzQuMDMgNy43NCA1MTYuNzUgNy43NCIvPjxwb2x5Z29uIGNsYXNzPSJjbHMtMyIgcG9pbnRzPSI1NTEuNzMgNy43NCA3NjAuNzYgMzQ4LjQ0IDc3OC40NSAzNDguNDQgNTY5LjIxIDcuNzQgNTUxLjczIDcuNzQiLz48cG9seWdvbiBjbGFzcz0iY2xzLTMiIHBvaW50cz0iNTcwLjg2IDM0OC40NCA1ODUuNjcgMzQ4LjQ0IDU4NS42NyAxOTYuMiA1NzAuODYgMTcxLjcyIDU3MC44NiAzNDguNDQiLz48cG9seWdvbiBjbGFzcz0iY2xzLTMiIHBvaW50cz0iNDgxLjk4IDcuNzQgNDgxLjk4IDM0OC40NCA0OTYuNzkgMzQ4LjQ0IDQ5Ni43OSAzMS44MSA2OTEuNDIgMzQ4LjQ0IDcwOC41IDM0OC40NCA0OTkuNjggNy43NCA0ODEuOTggNy43NCIvPjxyZWN0IGNsYXNzPSJjbHMtMiIgeD0iOTE3LjU3IiB5PSI3Ljc0IiB3aWR0aD0iMTQuODEiIGhlaWdodD0iMzQwLjcxIi8+PHJlY3QgY2xhc3M9ImNscy0yIiB4PSI4NTguMzEiIHk9IjcuNzQiIHdpZHRoPSIxNC44MSIgaGVpZ2h0PSIzNDAuNzEiLz48cmVjdCBjbGFzcz0iY2xzLTIiIHg9Ijk0Ny4xOSIgeT0iNy43NCIgd2lkdGg9IjE0LjgxIiBoZWlnaHQ9IjM0MC43MSIvPjxyZWN0IGNsYXNzPSJjbHMtMiIgeD0iODg3Ljk0IiB5PSI3Ljc0IiB3aWR0aD0iMTQuODEiIGhlaWdodD0iMzQwLjcxIi8+PHJlY3QgY2xhc3M9ImNscy00IiB4PSIyOS43MSIgeT0iNC4xNiIgd2lkdGg9IjE0Ljg1IiBoZWlnaHQ9IjM0MS42NCIvPjxwb2x5Z29uIGNsYXNzPSJjbHMtNCIgcG9pbnRzPSI4OS4xMiAzNDUuOCAxMDMuOTggMzQ1LjggMTAzLjk4IDI1MS43IDg5LjEyIDIyMi43IDg5LjEyIDM0NS44Ii8+PHBvbHlnb24gY2xhc3M9ImNscy00IiBwb2ludHM9IjU5LjQyIDM0NS44IDc0LjI3IDM0NS44IDc0LjI3IDE5My42OSA2NC42OSAxNzQuOTggNzQuMjcgMTU2LjI3IDc0LjI3IDQuMTYgNTkuNDIgNC4xNiA1OS40MiAzNDUuOCIvPjxwb2x5Z29uIGNsYXNzPSJjbHMtNCIgcG9pbnRzPSIxMDMuOTggNC4xNiA4OS4xMiA0LjE2IDg5LjEyIDEyNy4yNiAxMDMuOTggOTguMjUgMTAzLjk4IDQuMTYiLz48cmVjdCBjbGFzcz0iY2xzLTQiIHk9IjQuMTYiIHdpZHRoPSIxNC44NSIgaGVpZ2h0PSIzNDEuNjQiLz48cG9seWdvbiBjbGFzcz0iY2xzLTQiIHBvaW50cz0iMTA2LjkyIDE3Ny42MiAxOTQuMzkgNi44IDE3Ny44OCA2LjggMTAzLjk4IDE1MS4xMyA5MC40MSAxNzcuNjIgMTAzLjk4IDIwNC4xMSAxNzYuNTMgMzQ1LjggMTc3Ljg4IDM0OC40NCAxOTQuMzkgMzQ4LjQ0IDE5My4wMyAzNDUuOCAxMDYuOTIgMTc3LjYyIi8+PHBvbHlnb24gY2xhc3M9ImNscy00IiBwb2ludHM9IjE0MC4zNCAxNzcuNjIgMjI3LjYxIDYuOCAyMTEuMSA2LjggMTIzLjgzIDE3Ny42MiAyMDkuNzUgMzQ1LjggMjExLjEgMzQ4LjQ0IDIyNy42MSAzNDguNDQgMjI2LjI1IDM0NS44IDE0MC4zNCAxNzcuNjIiLz48cG9seWdvbiBjbGFzcz0iY2xzLTQiIHBvaW50cz0iMTczLjU1IDE3Ny42MiAyNjAuODIgNi44IDI0NC4zMiA2LjggMTU3LjA1IDE3Ny42MiAyNDIuOTcgMzQ1LjggMjQ0LjMyIDM0OC40NCAyNjAuODIgMzQ4LjQ0IDI1OS40NyAzNDUuOCAxNzMuNTUgMTc3LjYyIi8+PHBvbHlnb24gY2xhc3M9ImNscy00IiBwb2ludHM9IjI3Ny41MyA2LjggMTkwLjI2IDE3Ny42MiAyNzcuNTMgMzQ4LjQ0IDI5NC4wNCAzNDguNDQgMjA2Ljc3IDE3Ny42MiAyOTQuMDQgNi44IDI3Ny41MyA2LjgiLz48L3N2Zz4=" />
      </div>
    </section>

    <section v-if="!searchMode" @click="dropdownOn = false" style="margin-bottom:2%;" class="w-full blackBG">
        <div class="p-4 w-full pb-20">
            <div class="flex justify-center">
                <div class="pt-2 relative mx-auto text-gray-600 w-9/12 xl:w-6/12 2xl:w-5/12">
                   <input style="border-width: 1px;" autofocus class="border-gray-200 bg-white h-12 px-5 pl-12 rounded-xl text-sm focus:outline-none w-full customHover text-lg"
                     type="search" name="search" placeholder="Search text or a canister id" v-model="search" @keyup.enter="termSearch('in')">
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
              <button @click="termSearch('in')" class="text-white font-bold py-3 px-8 rounded searchButton text-gray-800 bg-gray-300 hover:text-gray-700 hover:bg-gray-100">Search Web 3.0</button>
            </div>
        </div>
    </section>

    <div v-if="!searchMode" @click="dropdownOn = false" class="mt-6 mx-2 ml-8 mb-2">
        <a @click="categorySearch('blog')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">
          Blog
        </a>
        <a @click="categorySearch('communication')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">
          Communication
        </a>
        <a @click="categorySearch('dao')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">
          DAO
        </a>
        <a @click="categorySearch('defi')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">
          Defi
        </a>
        <a @click="categorySearch('docs')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">
          Docs
        </a>
        <a @click="categorySearch('funny')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">
          Funny
        </a>
        <a @click="categorySearch('game')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">
          Games
        </a>
        <a @click="categorySearch('interesting')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">
          Interesting
        </a>
        <a @click="categorySearch('investor')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">
          Investor
        </a>
    </div>
    <div v-if="!searchMode" @click="dropdownOn = false" class="mt-2 mb-10 ml-8">
        <a @click="categorySearch('portfolio')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">
          Portfolio
        </a>
        <a @click="categorySearch('landing')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">
          Landing
        </a>
        <a @click="categorySearch('learning')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">
          Learning
        </a>
        <a @click="categorySearch('music')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">
          Music
        </a>
        <a @click="categorySearch('nft')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">
          NFT
        </a>
        <a @click="categorySearch('social')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">
          Social
        </a>
        <a @click="categorySearch('utility')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">
          Utility
        </a>
        <a @click="categorySearch('video')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">
          Video
        </a>
        <a @click="categorySearch('wip')" class="mr-6 text-gray-500 hover:text-red-800 font-light cursor-pointer">
          Work In Progress
        </a>
    </div>

    <Modal
      v-model="adMode"
      :close="closeAds"
      class="z-20"
    >
      <div class="modal shadow-lg">
        <button @click="closeAds" class="bg-gray-200 text-gray-800 py-2 px-3 rounded hover:bg-gray-100 hover:text-gray-700 mr-2">
          X
        </button>
        <div class="text-3xl text-indigo-500 text-center leading-tight addFont">Auctions</div>
        <div class="text-lg text-indigo-500 text-center">Bid to get your ad presented in a category for one month.</div>
        <div class="flex flex-col">
          <div class="overflow-x-auto sm:-mx-6 lg:-mx-8">
            <div class="py-2 inline-block min-w-full sm:px-6 lg:px-8">
                <b>Fund your account on the 'Claim Site' page.</b>
                <input type="text" v-model="claimCanister" placeholder="The canister ID that you own and want to make an AD for (ex. 74iy7-xqaaa-aaaaf-qagra-cai)" class="block w-full p-2 mt-2 text-gray-700 bg-gray-100 appearance-none focus:outline-none focus:bg-gray-200 focus:shadow-inner mb-2" />
                <table class="min-w-full">
                  <thead class="bg-indigo-100 border-b">
                      <th scope="col" class="text-sm font-medium text-gray-900 px-6 py-4 text-left">
                        Category
                      </th>
                      <th scope="col" class="text-sm font-medium text-gray-900 px-6 py-4 text-left">
                        Status
                      </th>
                      <th scope="col" class="text-sm font-medium text-gray-900 px-6 py-4 text-left">
                        Bids
                      </th>
                      <th scope="col" class="text-sm font-medium text-gray-900 px-6 py-4 text-left">
                        Highest Bid
                      </th>
                      <th scope="col" class="text-sm font-medium text-gray-900 px-6 py-4 text-left">
                        Manage Your Bid
                      </th>
                  </thead>
                  <tbody>
                    <tr v-for="item in this.cats" :key="item.name" class="bg-white border-b">
                      <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">{{item.name}}</td>
                      <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">{{item.status}}</td>
                      <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">{{item.bids.length}}</td>
                      <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">{{item.highestBid}}</td>
                      <td v-if="item.status === 'Open'" class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                        <button :disabled="buttonClicked" @click="offerBid(item.name, claimCanister)" class="bg-green-600 text-white py-2 px-3 rounded hover:bg-green-500 mr-2">
                          Make Offer
                        </button>
                        <button :disabled="buttonClicked" @click="cancelBid(claimCanister)" class="bg-red-600 text-white py-2 px-3 rounded hover:bg-red-500 mr-2">
                          Cancel Offer
                        </button>
                      </td>
                      <td v-else class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                        <button disabled class="bg-green-400 text-white py-2 px-3 rounded mr-2 cursor-not-allowed">
                          Make Offer
                        </button>
                        <button disabled class="bg-red-400 text-white py-2 px-3 rounded mr-2 cursor-not-allowed">
                          Cancel Offer
                        </button>
                      </td>
                    </tr>
                  </tbody>
                </table>
            </div>
          </div>
        </div>
      </div>
    </Modal>

    <Modal
      v-model="claimMode"
      :close="closeClaim"
      class="z-20"
    >
      <div class="modal shadow-lg">
        <button @click="closeClaim" class="bg-gray-200 text-gray-800 py-2 px-3 rounded hover:bg-gray-100 hover:text-gray-700 mr-2">
          X
        </button>
        <div class="text-3xl text-indigo-500 text-center leading-tight addFont">Claim Site</div>
        <div class="text-lg text-indigo-500 text-center">By claiming your site you get an OFFICIAL tag which boosts SEO.</div>
        <div class="flex flex-col">
          <div class="overflow-x-auto sm:-mx-6 lg:-mx-8">
            <div class="py-2 inline-block min-w-full sm:px-6 lg:px-8">
                <p class="text-medium mt-4">Enter the canister's ID and make a Claim Request.</p>
                <input type="text" v-model="claimCanister" placeholder="The canister ID that you own and want to claim. (ex. 74iy7-xqaaa-aaaaf-qagra-cai)" class="block w-full p-2 mt-2 text-gray-700 bg-gray-100 appearance-none focus:outline-none focus:bg-gray-200 focus:shadow-inner mb-2" />
                <button :disabled="buttonClicked" @click="claimSite(claimCanister)" class="bg-green-600 text-white py-2 px-3 rounded hover:bg-green-500 mr-2">
                  Claim Request
                </button>
                <p class="text-medium mt-4 mb-2">Use DFX with the identity that created the canister or is the owner and run this command.</p>
                <p class="font-light text-gray-700 bg-gray-100 px-2 py-4">
                  dfx canister --network ic call 73j6l-2iaaa-aaaaf-qagrq-cai requestVerifyContentOwner '(principal "{{claimCanister}}")'
                </p>
                <p class="font-bold mt-2 mb-2 text-xs">
                  *Your claim request needs to be manually verfied as Motoko does not have a 'canister info' method yet. This may take some time. DM us at https://twitter.com/kinic_app with this principal for support.
                </p>
                <p class="font-bold mb-2 text-xs">
                  *For support: {{this.principal}}
                </p>
                <hr/>
                <div class="text-2xl text-indigo-500 leading-tight addFont mt-4">Fill Account</div>
                <div class="text-medium text-indigo-500">Fill this address with ICP to make a bid. Make sure you claim your site first.</div>
                <button :disabled="buttonClicked" @click="getAddress(claimCanister)" class="bg-green-600 text-white py-2 px-3 rounded hover:bg-green-500 mt-2">
                  Get Address & Balance
                </button>
                <p v-if="bidAddress" class="font-light text-gray-700 bg-gray-100 px-2 py-4 mt-2">
                  {{bidAddress}}
                </p>
                <p v-if="bidAddress" class="font-bold mb-2 text-xs mb-2">
                  *Transfer ICP to this address. The full amount will be used when you make a bid.
                </p>
                <p v-if="balance" class="font-light text-gray-700 bg-gray-100 px-2 py-4 my-2">
                  {{(Number(balance)/100000000)}} ICP
                </p>
                <p v-if="balance" class="text-medium mt-4">Enter the account id that you want to send your balance to.</p>
                <input v-if="balance" type="text" v-model="accountID" placeholder="Account ID (ex. bb1bddb10fa4e5539316e735d6559d8ae454a48aeb68cc6b454f0f9201bdb9f8)" class="block w-full p-2 mt-2 text-gray-700 bg-gray-100 appearance-none focus:outline-none focus:bg-gray-200 focus:shadow-inner mb-2" />
                <button v-if="balance" :disabled="buttonClicked" @click="refound(claimCanister)" class="bg-yellow-600 text-white py-2 px-3 rounded hover:bg-yellow-500 mt-2 mb-2">
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
import { Principal } from '@dfinity/principal';

let main = mainCA(MAIN_CANISTER_ID);

export default {
  name: 'Search',
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
        identityProvider: 'https://nfid.one/authenticate/?applicationName=Kinic&applicationLogo=https%3A%2F%2Fb3kfi-qqaaa-aaaam-qaixq-cai.raw.ic0.app%2Ffile%3Fid%3Da4xcpig3z5d224%26minterid%3Ddgxla-dyaaa-aaaam-qaiya-cai%26tokenid%3Da4o4k-eqkor-uwiaa-aaaaa-deacg-aaqca-aaaac-q#authorize',
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
          'action': 'searchID',
          'category': this.search
        }).then((response) => {
            if (response.data) {
              this.paginate(response.data)
            }
        });
      } else {
        axios.post(this.host, {
          'action': 'searchTerm',
          'category': this.search
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
        'action': 'searchCategory',
        'category': txt
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
      claimCanister: '',
      bidAddress: '',
      accountID: '',
      host: '',
      searchMode: false,
      adMode: false,
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
