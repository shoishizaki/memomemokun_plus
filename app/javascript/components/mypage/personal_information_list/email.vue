<template>
  <v-expansion-panel v-if="receivedData">
    <v-expansion-panel-header>メールアドレス：　{{ user.email }}</v-expansion-panel-header>
    <v-expansion-panel-content>
      <v-col cols="12">
        <v-text-field v-model="change_email" label="変更するメールアドレス" placeholder="変更するメールアドレス" outlined></v-text-field>
      </v-col>
      <v-row>
    　　<v-dialog v-model="dialog" persistent max-width="400px">
    　　  <template v-slot:activator="{ on, attrs }">
    　　    <v-btn id="change_btn" color="success" v-bind="attrs" v-on="on" :disabled="disabled">
    　　      変更
    　　    </v-btn>
    　　  </template>
    　　  <v-card>
    　　    <v-card-title class="headline">確認</v-card-title>
    　　    <v-card-text>
    　　      <p>「{{ user.email }}」から「{{ change_email }}」に変更します。</p>
             <span>{{ message }}</span>
    　　    </v-card-text>
    　　    <v-card-actions>
    　　      <v-spacer></v-spacer>
    　　      <v-btn color="blue darken-1" text @click="dialog = false">
    　　        キャンセル
    　　      </v-btn>
    　　      <v-btn color="blue darken-1" text @click="update">
    　　        変更する
    　　      </v-btn>
    　　    </v-card-actions>
    　　  </v-card>
    　　</v-dialog>
  　　</v-row>
    </v-expansion-panel-content>
  </v-expansion-panel>
</template>

<script>
import axios from 'axios';

axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};

export default {
  props:["user"],

  data() {
    return {
      change_email: null,
      dialog: false,
      message: null
    }
  },

  computed: {
    receivedData() {
      return this.user !== null
    },

    disabled() {
      return this.change_email == null || this.change_email == ""
    }
  },

  methods: {
    update() {
      const params = {
        user: {
          id: this.user.id,
          email: this.change_email
        }
      }

      axios
        .patch('/api/v1/user', params)
        .then(response => (this.successHandler()))
        .catch((error) => (this.errorHandler(error.response["data"])))
    },

    successHandler() {
      this.dialog = false
      this.message = ""
      this.change_email = null
      this.$emit('send-message', "メールアドレスの変更が完了しました。");
    },

    errorHandler(error_message) {
      this.message = error_message
    }
  },
}
</script>

<style scoped>
#change_btn {
  margin-left: 20px;
}

span {
  color: #F44336
}
</style>