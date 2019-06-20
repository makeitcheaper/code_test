<template>
  <div>
    <top-bar/>
    <nav-bar/>

    <div class="py-10 bg-blue-300">
      <div class="container flex">
        <marketing-message/>
        <create-form/>
      </div>
    </div>
  </div>
</template>

<script>
import TopBar from '../top_bar.vue';
import NavBar from '../nav_bar.vue';
import MarketingMessage from './marketing_message.vue';
import CreateForm from './create_form.vue';

export default {
  components: {
    TopBar,
    NavBar,
    MarketingMessage,
    CreateForm,
  },
};
</script>

<style>
@import "../styles/tailwind.css";
</style>
