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
        <h1>ToDoリスト</h1>
      <v-row>
        <v-col cols="12">
          <div id="register">
            <register-modal :user_id="user_id" @send-message="showAlert"/>
          </div>
          <div id="list">
            <list :user_id="user_id" :todos="todos" @send-message="showAlert"/>
          </div>
        </v-col>
      </v-row>
    </v-container>
  </v-app>
</template>

<script>
import axios from 'axios';
import navigation from "../common/navigation"
import register_modal from "./register"
import list from "./list"

export default {
  data() {
    return {
      user_id: null,
      message: null,
      show: false,
      todos: []
    }
  },

  created: function() {
    this.getLoginUserId()
    this.getTodosList()
  },

  components: {
    "navigation": navigation,
    "register-modal": register_modal,
    "list": list
  },

  methods: {
    getLoginUserId() {
      axios
        .get("/api/v1/get_login_user")
        .then(response => (this.user_id = response.data.id))
    },

    getTodosList() {
      axios
        .get("/api/v1/todos")
        .then(response => (this.todos = response.data))
    },

    showAlert(message) {
      scrollTo(0, 0);
      this.message = message
      this.show = true
      this.getTodosList()
      setTimeout(() => {this.show = false}, 10000)
    },
  }
}
</script>
</script>

<style scoped>
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