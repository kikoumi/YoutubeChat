<template>
  <div id="app">
    {{ message }}
  </div>
</template>

<script>
import Top from "./components/Top"; //追記

export default {
  data: function () {
    return {
      message: "Hello Vue!"
    }
  },
  components: {
    Top, //追記
  }
}
</script>

<style scoped>
/* p {
  font-size: 2em;
  text-align: center;
} */
</style>
