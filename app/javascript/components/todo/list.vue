<template>
  <v-app>
    <v-simple-table fixed-header height="800px">
      <template v-slot:default>
        <thead>
          <tr>
            <th class="text-left">完了チェック</th>
            <th class="text-left">タスク</th>
            <th class="text-left">期限</th>
            <th class="text-left">操作</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="item in todos" :key="item.name">
            <td>
              <v-checkbox v-model="item.completed" color="success" hide-details/>
            </td>
            <td>{{ item.task }}</td>
            <td>{{ formmatDateTime(item.deadline) }}</td>
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
  props:["user_id", "todos"],

  components: {
  },

  data() {
    return {
      text_status: false
    }
  },

  methods: {
    sendMessage(message) {
      this.$emit('send-message', message);
    },

    formmatDateTime(str_date) {
      return str_date.slice(0, -8).replace("T", "-");
    }
  }
}
</script>

<style scoped>
#edit {
  margin-bottom: 10px;
}

#memo-modal {
  margin-top: 10px;
  margin-bottom: 10px;
}

#delete {
  margin-bottom: 10px
}
</style>