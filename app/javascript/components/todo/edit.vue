<template>
  <v-row height="100px">
    <v-dialog v-model="dialog" persistent max-width="600px">
      <template v-slot:activator="{ on, attrs }">
        <v-btn color="lime" v-bind="attrs" v-on="on" id="btn" elevation="0">
          編集
        </v-btn>
      </template>
      <v-card>
        <v-card-title>
          <span class="headline">ToDo編集</span>
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-row>
              <v-col cols="12">
                <v-text-field outlined label="タスク" v-model="todo['task']"></v-text-field>
              </v-col>

              <v-col cols="12">
                <v-textarea auto-grow outlined label="メモ" v-model="todo['note']"></v-textarea>
              </v-col>

              <v-col cols="12" sm="6" md="4">
                <v-menu ref="menu" v-model="menu" :close-on-content-click="false" :return-value.sync="date" transition="scale-transition" offset-y min-width="290px">
                  <template v-slot:activator="{ on, attrs }">
                    <v-text-field v-model="date" label="期日(日付)" prepend-icon="mdi-calendar" readonly v-bind="attrs" v-on="on"></v-text-field>
                  </template>
                  <v-date-picker v-model="date" no-title scrollable>
                    <v-spacer></v-spacer>
                    <v-btn text color="primary" @click="menu = false">Cancel</v-btn>
                    <v-btn text color="primary" @click="$refs.menu.save(date)">OK</v-btn>
                  </v-date-picker>
                </v-menu>
              </v-col>

              <v-col cols="11" sm="5">
                <v-menu ref="menu2" v-model="menu2" :close-on-content-click="false" :nudge-right="40" :return-value.sync="time" transition="scale-transition" offset-y max-width="290px" min-width="290px">
                  <template v-slot:activator="{ on, attrs }">
                    <v-text-field v-model="time" label="期日(時間)" prepend-icon="mdi-calendar-clock" readonly v-bind="attrs" v-on="on"/>
                  </template>
                  <v-time-picker v-if="menu2" v-model="time" full-width format="24hr" @click:minute="$refs.menu2.save(time)"/>
                </v-menu>
              </v-col>

              <v-col class="d-flex" cols="12" sm="6">
                <v-select :items="items" v-model="todo['priority']" label="優先順位" outlined/>
              </v-col>

            </v-row>
            <p>{{ message }}</p>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" text @click="dialog = false">閉じる</v-btn>
          <v-btn color="blue darken-1" text @click="update">編集</v-btn>
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
  props:["user_id", "todos"],

  data() {
    return {
      todo: {
        task: this.todos.task,
        priority: this.formatPriority(this.todos.priority),
        note: this.todos.note,
      },
      dialog: false,
      message: "",
      date: this.formmatDate(this.todos.deadline),
      menu: false,
      time: this.formatTime(this.todos.deadline),
      menu2: false,
      items: ['低', '中', '高'],
    }
  },

  computed: {
    createDateTime() {
      return this.date + "-" + this.time
    },

    changePriority() {
      if(this.todo.priority === "低") {
        return 0
      }

      if(this.todo.priority === "中") {
        return 1
      }

      if(this.todo.priority === "高") {
        return 2
      }
    },
  },

  methods: {
    update() {
      const params = {
        todo: {
          id: this.todos.id,
          user_id: this.user_id,
          completed: false,
          task: this.todo.task,
          deadline: this.createDateTime,
          priority: this.changePriority,
          note: this.todo.note
        }
      }

      axios
        .patch('/api/v1/todos', params)
        .then(response => (this.successHandler()))
        .catch((error) => (this.errorHandler(error.response["data"])))
    },

    successHandler() {
      this.dialog = false
      this.message = ""
      this.$emit('send-message', "ToDoリストを編集しました。");
    },

    errorHandler(error_message) {
      this.message = error_message
    },

    formatPriority(priority_num) {
      if(priority_num === 0) {
        return "低"
      }

      if(priority_num === 1) {
        return "中"
      }

      if(priority_num === 2) {
        return "高"
      }
    },

    formmatDate(str_date) {
      return str_date.slice(0, -14);
    },

    formatTime(str_date) {
      return str_date.slice(11, -8)
    }
  }
}
</script>

<style scoped>
p {
  color: #F44336
}
</style>