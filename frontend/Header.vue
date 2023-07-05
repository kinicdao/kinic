<template>
    <div @click="headerFunctions.dropdownOn = false" class="yellowBG">
        <div v-if="!whitepaperMode" class="max-w-7xl mx-auto py-1 px-2 flex items-center justify-between flex-wrap">
            <div class="w-0 flex-1 flex flex-col items-left">
                <p class="ml-3 text-lg truncate headerSN">
                <span v-if="!headerFunctions.searchMode">
                    <b>Kinic</b> is the world's first web3 search engine. 
                    <a class="cursor-pointer text-white underline" @click="headerFunctions.whitepaper">Read our SNS Whitepaper.</a>
                </span>
                <span v-else>Advertisers can bid ICP to place Ads in categories. Login to see more.</span>
                </p>
            </div>
            <div class="order-3 mb-1 flex-shrink-0 w-full sm:order-2 sm:mt-0 sm:w-auto">
                <!--<p class="text-xs text-black">Login & make history. 1st ever web3 ad spot auction. Ends in:</p>
                <div class="flex items-center justify-center px-4 py-3 rounded-md shadow-sm text-sm text font-bold text-white bg-black mt-1">
                    <vue-countdown :time="time" :interval="100" v-slot="{ days, hours, minutes, seconds}">
                        {{ days }} days, {{ hours }} hours, {{ minutes }} minutes, {{ seconds }} seconds
                    </vue-countdown>
                </div>-->
                <div class="flex flex-row mt-1 w-full mx-auto justify-end items-end ml-auto">
                    <!--<a href="https://discord.gg/AkapKzFCtd" class="ml-2 mb-0.5" target="_blank">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" width="30px" height="30px"><path fill="#ffffff" d="M39.248,10.177c-2.804-1.287-5.812-2.235-8.956-2.778c-0.057-0.01-0.114,0.016-0.144,0.068 c-0.387,0.688-0.815,1.585-1.115,2.291c-3.382-0.506-6.747-0.506-10.059,0c-0.3-0.721-0.744-1.603-1.133-2.291 c-0.03-0.051-0.087-0.077-0.144-0.068c-3.143,0.541-6.15,1.489-8.956,2.778c-0.024,0.01-0.045,0.028-0.059,0.051 c-5.704,8.522-7.267,16.835-6.5,25.044c0.003,0.04,0.026,0.079,0.057,0.103c3.763,2.764,7.409,4.442,10.987,5.554 c0.057,0.017,0.118-0.003,0.154-0.051c0.846-1.156,1.601-2.374,2.248-3.656c0.038-0.075,0.002-0.164-0.076-0.194 c-1.197-0.454-2.336-1.007-3.432-1.636c-0.087-0.051-0.094-0.175-0.014-0.234c0.231-0.173,0.461-0.353,0.682-0.534 c0.04-0.033,0.095-0.04,0.142-0.019c7.201,3.288,14.997,3.288,22.113,0c0.047-0.023,0.102-0.016,0.144,0.017 c0.22,0.182,0.451,0.363,0.683,0.536c0.08,0.059,0.075,0.183-0.012,0.234c-1.096,0.641-2.236,1.182-3.434,1.634 c-0.078,0.03-0.113,0.12-0.075,0.196c0.661,1.28,1.415,2.498,2.246,3.654c0.035,0.049,0.097,0.07,0.154,0.052 c3.595-1.112,7.241-2.79,11.004-5.554c0.033-0.024,0.054-0.061,0.057-0.101c0.917-9.491-1.537-17.735-6.505-25.044 C39.293,10.205,39.272,10.187,39.248,10.177z M16.703,30.273c-2.168,0-3.954-1.99-3.954-4.435s1.752-4.435,3.954-4.435 c2.22,0,3.989,2.008,3.954,4.435C20.658,28.282,18.906,30.273,16.703,30.273z M31.324,30.273c-2.168,0-3.954-1.99-3.954-4.435 s1.752-4.435,3.954-4.435c2.22,0,3.989,2.008,3.954,4.435C35.278,28.282,33.544,30.273,31.324,30.273z"/></svg>
                    </a>-->
                    <a href="https://twitter.com/kinic_app" class="ml-4 mt-1" target="_blank">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" width="35px" height="35px">
                        <path fill="#ffffff" d="M42,12.429c-1.323,0.586-2.746,0.977-4.247,1.162c1.526-0.906,2.7-2.351,3.251-4.058c-1.428,0.837-3.01,1.452-4.693,1.776C34.967,9.884,33.05,9,30.926,9c-4.08,0-7.387,3.278-7.387,7.32c0,0.572,0.067,1.129,0.193,1.67c-6.138-0.308-11.582-3.226-15.224-7.654c-0.64,1.082-1,2.349-1,3.686c0,2.541,1.301,4.778,3.285,6.096c-1.211-0.037-2.351-0.374-3.349-0.914c0,0.022,0,0.055,0,0.086c0,3.551,2.547,6.508,5.923,7.181c-0.617,0.169-1.269,0.263-1.941,0.263c-0.477,0-0.942-0.054-1.392-0.135c0.94,2.902,3.667,5.023,6.898,5.086c-2.528,1.96-5.712,3.134-9.174,3.134c-0.598,0-1.183-0.034-1.761-0.104C9.268,36.786,13.152,38,17.321,38c13.585,0,21.017-11.156,21.017-20.834c0-0.317-0.01-0.633-0.025-0.945C39.763,15.197,41.013,13.905,42,12.429"/>
                        </svg>
                    </a>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
  export default {
    name: 'Header',
    components: {
    },
    props: {
        headerFunctions: {
            type: Object,
            required: true,
        },
    },
    data() {
        return {
        }
    }
}
</script>