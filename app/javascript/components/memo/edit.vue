<template>
  <v-row height="100px">
    <v-dialog v-model="dialog" persistent max-width="600px">
      <template v-slot:activator="{ on, attrs }">
        <v-btn :color="color" :text="text_status" v-bind="attrs" v-on="on">
          編集
        </v-btn>
      </template>
      <v-card>
        <v-card-title>
          <span class="headline">メモ編集</span>
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
          <div id="close-btn">
            <v-btn color="blue darken-1" text @click="dialog = false">閉じる</v-btn>
          </div>
          <div id="edit-btn">
            <v-btn color="blue darken-1" text @click="update">編集</v-btn>
          </div>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>
import axios from 'axios';

axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};

export default {
  props:["user_id", "memos", "color", "text_status"],

  data() {
    return {
      memo: {
        category: this.memos.category,
        content: this.memos.content
      },
      dialog: false,
      message: null
    }
  },

  methods: {
    update() {
      const params = {
        memo: {
          id: this.memos.id,
          user_id: this.user_id,
          category: this.memo.category,
          content: this.memo.content
        }
      }

      axios
        .patch('/api/v1/memos', params)
        .then(response => (this.successHandler()))
        .catch((error) => (this.errorHandler(error.response["data"])))
    },

    successHandler() {
      this.dialog = false
      this.message = ""
      this.memo.category = ""
      this.memo.content = ""
      this.$emit('send-message', "メモの編集が完了しました");
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