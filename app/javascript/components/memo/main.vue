<template>
  <v-app>
    <navigation/>
    <div id="text">
      <h1>{{ memo.category }}</h1>
      <p>{{ memo.content }}</p>
    </div>
  </v-app>
</template>

<script>
import axios from 'axios';
import navigation from "../common/navigation"

axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};

export default {
  data() {
    return {
      memo: {
        category: "IT",
        content: "Hello World"
      }
    }
  },

  components: {
    navigation: navigation
  },

  methods: {
  }
}
</script>

<style scoped>
#text {
	margin-top: 80px;
}
</style>