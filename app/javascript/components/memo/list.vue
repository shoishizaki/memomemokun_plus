<template>
  <v-app>
    <v-simple-table fixed-header height="700px">
      <template v-slot:default>
        <thead>
          <tr>
            <th class="text-left">カテゴリー</th>
            <th class="text-left">内容</th>
            <th class="text-left">作成日</th>
            <th class="text-left">更新日</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="item in memos" :key="item.name">
            <td>{{ item.category }}</td>
            <td>{{ item.content }}</td>
            <td>{{ item.created_at }}</td>
            <td>{{ item.updated_at }}</td>
          </tr>
        </tbody>
      </template>
    </v-simple-table>
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
      memos: []
    }
  },

  created: function() {
    axios
      .get("/api/v1/memos")
      .then(response => (this.memos = response.data, console.log(response)))
  }
}
</script>

<style scoped>
</style>