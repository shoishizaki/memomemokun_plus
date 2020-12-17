<template>
  <v-row height="100px">
    <v-dialog v-model="dialog" persistent max-width="600px">
      <template v-slot:activator="{ on, attrs }">
        <v-btn light fab v-bind="attrs" v-on="on" id="btn" elevation="0">
          <v-icon>mdi-plus-circle-outline</v-icon>
        </v-btn>
      </template>
      <v-card>
        <v-card-title>
          <span class="headline">ToDo作成</span>
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
          <v-btn color="blue darken-1" text @click="create">作成</v-btn>
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
  props:["user_id"],

  data() {
    return {
      todo: {
        task: "",
        priority: "中",
        note: ""
      },
      dialog: false,
      message: "",
      date: new Date().toISOString().substr(0, 10),
      menu: false,
      time: "00:00",
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
    }
  },

  methods: {
    create() {
      const params = {
        todo: {
          user_id: this.user_id,
          completed: false,
          task: this.todo.task,
          deadline: this.createDateTime,
          priority: this.changePriority,
          note: this.todo.note
        }
      }

      axios
        .post('/api/v1/todos', params)
        .then(response => (this.successHandler()))
        .catch((error) => (this.errorHandler(error.response["data"])))
    },

    successHandler() {
      this.dialog = false
      this.message = ""
      this.todo.task = ""
      this.todo.priority = "中"
      this.todo.note = ""
      this.date = new Date().toISOString().substr(0, 10)
      this.time = "00:00"
      this.$emit('send-message', "ToDoリストに追加しました。");
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

#btn {
  margin: 0 0 0 auto;
}
</style>