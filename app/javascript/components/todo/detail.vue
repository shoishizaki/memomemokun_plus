<template>
  <v-row>
    <v-dialog v-model="dialog" width="600px">
      <template v-slot:activator="{ on, attrs }">
        <v-btn color="primary" dark v-bind="attrs" v-on="on">
          詳細
        </v-btn>
      </template>
      <v-card>
        <v-card-title>
          <span class="headline">{{ todo.task }}</span>
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-row>
              <v-col cols="12">
                <v-textarea readonly auto-grow outlined label="メモ" v-model="todo.note"/>
              </v-col>
            </v-row>
          </v-container>
          <div>
            <h3>期日</h3>
            {{ formmatDateTime(todo.deadline) }}
          </div>
          <br>
          <div>
            <h3>優先度</h3>
            {{ formatPriority(todo.priority) }}
          </div>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="green darken-1" text @click="dialog = false">
            閉じる
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>
  export default {
    props:["todo"],

    data () {
      return {
        dialog: false,
      }
    },

    methods: {
      formmatDateTime(str_date) {
        return str_date.slice(0, -8).replace("T", "-");
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
    }
  }
</script>

<style scoped>
</style>