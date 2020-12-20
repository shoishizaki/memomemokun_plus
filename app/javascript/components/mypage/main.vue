<template>
  <v-app>
    <v-container>
      <v-row>
        <navigation/>
      </v-row>
      <v-row>
        <transition name="slide-fade">
          <div id="alert" v-if="show">
            <v-alert type="success" elevation="12" width="400">
              {{ message }}
            </v-alert>
          </div>
        </transition>
      </v-row>
      <h1>マイページ</h1>
      <v-row>
        <v-col cols="6">
          <h3>個人情報</h3>
          <v-expansion-panels accordion>
            <name-display :user="user" @send-message="showAlert"/>
            <email-display :user="user" @send-message="showAlert"/>
          </v-expansion-panels>
        </v-col>
      </v-row>
    </v-container>
  </v-app>
</template>

<script>
import axios from 'axios';
import navigation from "../common/navigation"
import name_display from "./personal_information_list/name"
import email_display from "./personal_information_list/email"

axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};

export default {
  data() {
    return {
      dialog: false,
      user: null,
      message: null,
      show: false,
      memos: []
    }
  },

  created: function() {
    this.getLoginUserInfo()
  },

  components: {
    "navigation": navigation,
    "name-display": name_display,
    "email-display": email_display
  },

  methods: {
    showAlert(message) {
      scrollTo(0, 0);
      this.message = message
      this.show = true
      this.getLoginUserInfo()
      setTimeout(() => {this.show = false}, 10000)
    },

    getLoginUserInfo() {
      axios
        .get("/api/v1/get_login_user")
        .then(response => (this.user = response.data))
    },
  }
}
</script>

<style scoped>
h3 {
  margin-bottom: 5px;
}

#alert {
  margin-left: 20px;
}

.slide-fade-enter-active {
  transition: all .3s ease;
}
.slide-fade-leave-active {
  transition: all .8s cubic-bezier(1.0, 0.5, 0.8, 1.0);
}
.slide-fade-enter, .slide-fade-leave-to
/* .slide-fade-leave-active below version 2.1.8 */ {
  transform: translateX(10px);
  opacity: 0;
}
</style>