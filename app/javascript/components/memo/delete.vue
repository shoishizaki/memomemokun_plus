<template>
  <v-row justify="center">
    <v-dialog v-model="dialog" persistent max-width="400px">
      <template v-slot:activator="{ on, attrs }">
        <v-btn color="orange" v-bind="attrs" v-on="on">
          削除
        </v-btn>
      </template>
      <v-card>
        <v-card-title class="headline">
          本当によろしいでしょうか？
        </v-card-title>
        <v-card-text>
          削除するとデータを復元することはできません。
          <p>{{ message }}</p>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" text @click="dialog = false">
            キャンセル
          </v-btn>
          <v-btn color="blue darken-1" text @click="delete_memo">
            削除する
          </v-btn>
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
    props:["memo"],

    data () {
      return {
        dialog: false,
        message: ""
      }
    },

    methods: {
      delete_memo() {
        axios
          .delete("/api/v1/memos/" + this.memo.id)
          .then(response => (this.successHandler()))
          .catch((error) => (this.errorHandler(error.response["data"])))
      },

      successHandler() {
        this.dialog = false
        this.message = ""
        this.$emit('send-message', "メモの削除が完了しました。");
      },

      errorHandler(error_message) {
        this.message = error_message
      }
    }
  }
</script>

<style scoped>
p {
  font-size: 5px;
  color: #F44336
}
</style>

