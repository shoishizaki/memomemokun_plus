<template>
  <div>
    <v-navigation-drawer app v-model="drawer" temporary>

      <v-list-item>
        <v-list-item-title class="title">
          MemoMemokun
        </v-list-item-title>
        <v-btn icon @click="drawer = false">
          <v-icon>mdi-chevron-left</v-icon>
        </v-btn>
      </v-list-item>

      <v-list-item>
        <v-list-item-icon>
          <v-icon>{{ user.icon }}</v-icon>
        </v-list-item-icon>
        <v-list-item-content>
          <v-list-item-title class="title">
            {{ user.name }}
          </v-list-item-title>
          <v-list-item-subtitle>{{ user.email }}</v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>

      <v-divider />

      <v-list nav>

        <v-list-item v-for="menu in menus" :key="menu.title" :href="menu.url">
          <v-list-item-icon>
            <v-icon>{{ menu.icon }}</v-icon>
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title>{{ menu.title }}</v-list-item-title>
          </v-list-item-content>
        </v-list-item>

        <v-list-item @click="logout">
          <v-list-item-icon>
            <v-icon>mdi-exit-run</v-icon>
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title>Logout</v-list-item-title>
          </v-list-item-content>
        </v-list-item>

      </v-list>
    </v-navigation-drawer>

    <v-app-bar app>
      <!-- アプリケーションバー -->
      <v-app-bar-nav-icon @click.stop="drawer = !drawer" />
    </v-app-bar>
  </div>
</template>

<script>
import axios from 'axios';

axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};

export default {
  name: 'App',
  data: () => ({
    drawer: false,
    menus: [
      { title: 'Home', icon: 'mdi-home', url: '/' },
      { title: 'Memo', icon: 'mdi-card-text-outline', url: '/memo' },
      { title: 'ToDo', icon: 'mdi-format-list-checks', url: '#' },
      { title: 'MyPage', icon: 'mdi-web', url: '#' }
    ],
    user: {
      name: null,
      email: null,
      icon: "mdi-account"
    }
  }),

  created: function() {
    axios
      .get("/api/v1/get_login_user")
      .then(response => (this.user.name = response.data.name, this.user.email = response.data.email))
  },

  methods: {
    logout() {
      const url = "/api/v1/logout"
      axios.delete(url)
           .then(response => (this.successHandler()))
           .catch(error => (this.errorHandler(error)))
    },

    successHandler() {
      window.location.href = "/login"
    },

    errorHandler(error) {
      console.log(error)
    }
  }
}
</script>

<style></style>