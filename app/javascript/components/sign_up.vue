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
              <v-text-field v-model="user['name']" label="名前" placeholder="名前" outlined></v-text-field>
            </v-col>
          </v-row>
          <v-row justify="center">
            <v-col cols="4">
              <v-text-field v-model="user['email']" label="メールアドレス" placeholder="メールアドレス" outlined></v-text-field>
            </v-col>
          </v-row>
          <v-row justify="center">
            <v-col cols="4">
              <v-text-field v-model="user['password']" label="パスワード" placeholder="パスワード" type="password" outlined></v-text-field>
              <p>パスワードは8文字以上で入力してください。</p>
              <a href="/login">すでにユーザーを登録を完了している方はこちら</a>
            </v-col>
          </v-row>
          <v-row justify="center">
            <v-btn @click="submit" large color="primary" dark>登録</v-btn>
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
        name: null,
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
          name: this.user.name,
          email: this.user.email,
          password: this.user.password
        }
      }

      axios
        .post('/api/v1/user', params)
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
p {
  font-size: 5px;
  color: #F44336
}

a {
  font-size: 5px;
}
</style>