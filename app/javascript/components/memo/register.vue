<template>
  <v-app>
    <v-row justify="center">
      <v-dialog v-model="dialog" persistent max-width="600px">
        <template v-slot:activator="{ on, attrs }">
          <v-btn color="primary" dark v-bind="attrs" v-on="on" >
            新規作成
          </v-btn>
        </template>
        <v-card>
          <v-card-title>
            <span class="headline">新規メモ作成</span>
          </v-card-title>
          <v-card-text>
            <v-container>
              <v-row>
                <v-col cols="12">
                  <v-text-field outlined label="カテゴリー" hint="メモの種類を入力してください。" v-model="memo['category']"></v-text-field>
                </v-col>
                <v-col cols="12">
                  <v-textarea auto-grow outlined label="メモ" v-model="memo['content']"></v-textarea>
                </v-col>
              </v-row>
              <p>{{ message }}</p>
            </v-container>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="blue darken-1" text @click="dialog = false">閉じる</v-btn>
            <v-btn color="blue darken-1" text @click="create">作成</v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
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
  props:["user_id"],

  data() {
    return {
      memo: {
        category: "",
        content: ""
      },
      dialog: false,
      message: null
    }
  },

  methods: {
    create() {
      const params = {
        memo: {
          user_id: this.user_id,
          category: this.memo.category,
          content: this.memo.content
        }
      }

      axios
        .post('/api/v1/memos', params)
        .then(response => (this.successHandler()))
        .catch((error) => (this.errorHandler(error.response["data"])))
    },

    successHandler() {
      this.dialog = false
      this.$emit('send-message', "メモの作成が完了しました");
    },

    errorHandler(error_message) {
      this.message = error_message
    },
  }
}
</script>

<style scoped>
p {
  color: #F44336
}
</style>