<template>
  <div>
    <v-checkbox @change="update" v-model="todo['completed']" color="success" hide-details/>
  </div>
</template>

<script>
import axios from 'axios';

axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};

export default {
  props:["info"],

  data() {
    return {
      todo: {
        completed: null
      }
    }
  },

  created: function() {
    this.todo.completed = this.info.completed
  },

  methods: {
    update() {
      const params = {
        todo: {
          id: this.info.id,
          completed: this.todo.completed,
        }
      }

      axios
        .patch('/api/v1/todos', params)
        .then(response => (this.successHandler()))
        .catch((error) => (this.errorHandler(error.response["data"])))
    },

    successHandler() {
      this.$emit('send-message', "完了チェックのステータスが更新されました");
    },

    errorHandler(error_message) {
      console.log(error_message)
    }
  }
}
</script>

<style scoped>
</style>