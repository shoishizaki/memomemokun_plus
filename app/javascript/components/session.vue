<template>
  <v-app>
    <v-alert v-if="show_error" type="error">
      {{ message }}
    </v-alert>
    <v-row align-content="center">
      <v-col>
        <v-form>
          <v-row justify="center">
            <v-col cols="4">
              <v-text-field v-model="user['email']" label="メールアドレス" placeholder="メールアドレス" outlined></v-text-field>
            </v-col>
          </v-row>
          <v-row justify="center">
            <v-col cols="4">
              <v-text-field v-model="user['password']" label="パスワード" placeholder="パスワード" type="password" outlined></v-text-field>
              <a href="/signup">ユーザーを登録されていない方はこちら</a>
            </v-col>
          </v-row>
          <v-row justify="center">
            <v-btn @click="submit" large color="primary" dark>ログイン</v-btn>
          </v-row>
        </v-form>
      </v-col>
    </v-row>
  </v-app>
</template>

<script>
import axios from 'axios';

axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};

export default {
  data() {
    return {
      user: {
        email: null,
        password: null
      },
      show_error: false,
      message: ""
    }
  },

  methods: {
    submit () {
      const params = {
        user: {
          email: this.user.email,
          password: this.user.password
        }
      }

      axios
        .post('/api/v1/sessions', params)
        .then(response => (this.successHandler()))
        .catch((error) => (this.errorHandler(error.response["data"])))
    },

    successHandler() {
      window.location.href = "/"
    },

    errorHandler(error_message) {
      this.message = error_message
      this.showFlash()
    },

    showFlash() {
        this.show_error = true
        setTimeout(() => {this.show_error = false}, 10000)
    }
  }
}
</script>

<style scoped>
a {
  font-size: 5px;
}
</style>