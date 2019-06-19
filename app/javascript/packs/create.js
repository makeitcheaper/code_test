import Vue from 'vue';
import CreateApp from '../src/create/app.vue';

document.addEventListener('DOMContentLoaded', () => {
  const vm = new Vue({
    render: h => h(CreateApp),
  }).$mount();

  document.body.appendChild(vm.$el);
});
