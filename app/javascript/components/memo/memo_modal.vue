<template>
  <v-row height="100px">
    <v-dialog v-model="dialog" persistent max-width="600px">
      <template v-slot:activator="{ on, attrs }">
        <v-btn color="light-blue" v-bind="attrs" v-on="on">
          表示
        </v-btn>
      </template>
      <v-card>
        <v-card-title>
          <span class="headline">メモ</span>
        </v-card-title>
        <v-card-text>
          <p>編集する際には編集ボタンを押してください。</p>
          <v-container>
            <v-row>
              <v-col cols="12">
                <v-text-field readonly outlined label="カテゴリー" v-model="memo['category']"></v-text-field>
              </v-col>
              <v-col cols="12">
                <v-textarea readonly auto-grow outlined label="メモ" v-model="memo['content']"></v-textarea>
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <div id="close-btn">
            <v-btn color="blue darken-1" text @click="dialog = false">閉じる</v-btn>
          </div>
          <div id="edit-btn">
            <edit :memos="memos" :user_id="user_id" :text_status="text_status" color="blue darken-1" @send-message="sendMessage"/>
          </div>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>
import axios from 'axios';
import edit from './edit'

axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};

export default {
  props:["user_id", "memos"],

  components: {
    "edit": edit
  },


  data() {
    return {
      memo: {
        category: this.memos.category,
        content: this.memos.content
      },
      dialog: false,
      text_status: true
    }
  },

  methods: {
    sendMessage(message) {
      this.dialog = false
      this.$emit('send-message', message);
    }
  }
}
</script>

<style scoped>
#edit-btn {
  margin-left: 15px;
  margin-right: 15px;
}

#close-btn {
  margin-left: 15px;
}

p {
  color: #F44336;
  font-size: 5px;
}
</style>