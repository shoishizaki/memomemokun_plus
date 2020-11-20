<template>
  <v-app>
    <navigation/>
    <transition name="slide-fade">
      <div id="alert" v-if="show">
        <v-alert type="success" elevation="12" width="400">
          {{ message }}
        </v-alert>
      </div>
    </transition>
    <h1>メモ一覧</h1>
    <div id="register">
      <register-modal :user_id="user_id" @send-message="showAlert"/>
    </div>
    <h1>Hello</h1>
  </v-app>
</template>

<script>
import axios from 'axios';
import navigation from "../common/navigation"
import register_modal from "./register"

axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};

export default {
  data() {
    return {
      dialog: false,
      user_id: null,
      message: null,
      show: false
    }
  },

  created: function() {
    axios
      .get("/api/v1/get_login_user")
      .then(response => (this.user_id = response.data.id, console.log(response.data.id)))
  },

  components: {
    "navigation": navigation,
    "register-modal": register_modal
  },

  methods: {
    showAlert(message) {
      this.message = message
      this.show = true
      setTimeout(() => {this.show = false}, 10000)
    }
  }
}
</script>

<style scoped>
h1 {
  margin-top: 30px;
  margin-left: 30px;
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