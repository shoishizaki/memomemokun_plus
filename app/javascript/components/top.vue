<template>
  <v-app>
    <navigation/>
    <v-parallax dark src="https://cdn.vuetifyjs.com/images/backgrounds/vbanner.jpg">
      <v-row align="center" justify="center">
        <v-col class="text-center" cols="12">
          <h1 class="display-1 font-weight-thin mb-4">
            Hello World
          </h1>
          <h4 class="subheading">
            Build your application today!
          </h4>
        </v-col>
      </v-row>
    </v-parallax>
  </v-app>
</template>

<script>
import navigation from "./common/navigation"

  export default {
    name: 'top',

    components: {
    navigation: navigation
  },
  }
</script>

<style>
</style>