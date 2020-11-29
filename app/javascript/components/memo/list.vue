<template>
  <v-app>
    <v-simple-table fixed-header height="800px">
      <template v-slot:default>
        <thead>
          <tr>
            <th class="text-left">カテゴリー</th>
            <th class="text-left">内容</th>
            <th class="text-left">作成日</th>
            <th class="text-left">更新日</th>
            <th class="text-left">操作</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="item in memos" :key="item.name">
            <td>{{ item.category }}</td>
            <td>{{ item.content }}</td>
            <td>{{ item.created_at }}</td>
            <td>{{ item.updated_at }}</td>
            <td>
              <div id="memo-modal">
                <v-btn color="light-blue">表示</v-btn>
              </div>
              <div id="edit">
                <edit :memos="item" :user_id="user_id" @send-message="sendMessage"/>
              </div>
              <div id="delete">
                <v-btn color="orange">削除</v-btn>
              </div>
            </td>
          </tr>
        </tbody>
      </template>
    </v-simple-table>
  </v-app>
</template>

<script>
import axios from 'axios';
import edit from "./edit"

axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};

export default {
  props:["user_id"],

  components: {
    "edit": edit
  },

  data() {
    return {
      memos: []
    }
  },

  created: function() {
    axios
      .get("/api/v1/memos")
      .then(response => (this.memos = response.data, console.log(response)))
  },

  methods: {
    sendMessage(message) {
      this.$emit('send-message', message);
    }
  }
}
</script>

<style scoped>
#edit {
  margin-bottom: 10px;
  margin-left: 12px;
}

#memo-modal {
  margin-top: 10px;
  margin-bottom: 10px;
}

#delete {
  margin-bottom: 10px
}
</style>