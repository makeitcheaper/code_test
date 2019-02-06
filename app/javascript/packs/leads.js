 import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue';
import Leads from '../components/leads.vue'

Vue.use(TurbolinksAdapter)

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#vue-container',
    render: h => h(Leads)
  })

  console.log(app)
})
