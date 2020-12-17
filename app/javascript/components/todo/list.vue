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
              <completed-checkbox :info="item" @send-message="sendMessage"/>
            </td>
            <td>{{ item.task }}</td>
            <td>{{ formmatDateTime(item.deadline) }}</td>
            <td>
              <div id="detail">
                <detail :todo="item"/>
              </div>
              <div id="edit">
                <edit :todos="item" :user_id="user_id" @send-message="sendMessage"/>
              </div>
              <div id="delete">
                <delete-btn :info="item" @send-message="sendMessage"/>
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
import detail from "./detail"
import completed_checkbox from "./completed_checkbox"
import delete_btn from "./delete"

axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};

export default {
  props:["user_id", "todos"],

  components: {
    "edit": edit,
    "detail": detail,
    "completed-checkbox": completed_checkbox,
    "delete-btn": delete_btn
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
#detail {
  margin-top: 10px;
  margin-bottom: 10px;
}

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