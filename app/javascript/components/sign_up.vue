<template>
  <v-app>
    <v-alert v-if="show_success" type="success">
      {{ message }}
    </v-alert>
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
      show_success: false,
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
        .then(response => (this.message = response.data, console.log(response)))
        .then(() => (this.showFlash()))
    },

    showFlash() {
      if(this.message === "メールアドレスまたはパスワードが不正な値です。もう一度入力し直してください") {
        this.show_error = true
        setTimeout(() => {this.show_error = false}, 10000)
      } else if(this.message === "ユーザーの登録に成功しました。") {
        this.show_success = true
        setTimeout(() => {this.show_success = false}, 10000)
      } else if(this.message === "原因不明のエラーが発生しました。開発者にお問い合わせください。") {
        this.show_error = true
        setTimeout(() => {this.show_success = false}, 10000)
      }
    }
  }
}
</script>

<style scoped>
</style>