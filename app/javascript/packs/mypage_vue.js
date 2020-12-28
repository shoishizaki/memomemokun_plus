import Vue from 'vue'
import App from '../components/mypage/main'
import Vuetify from 'vuetify'
import "vuetify/dist/vuetify.min.css"

Vue.use(Vuetify)

const vuetify = new Vuetify();

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    vuetify,
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)
})