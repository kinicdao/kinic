<template>
  <div class="App">
    <Search />
  </div>
  <div id="modals"></div>
</template>

<script>
import Search from "./Search.vue"

export default {
  name: "App",
  components: {
    Search
  },
}
</script>

<style>
.App {
  font-family: Avenir, Helvetica, Arial, sans-serif;
}
</style>
