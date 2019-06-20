<template>
  <div>
    <top-bar/>
    <nav-bar/>

    <div class="bg-blue-gradient">
      <div class="container">
        <div class="row">
          <marketing-message class="col-12 col-md-6"/>
          <create-form class="col-12 col-md-6"/>
        </div>
      </div>
    </div>

    <div class="h-20 bg-gray-900"></div>
    <div class="h-64 bg-teal-100"></div>
    <div class="h-64 bg-gray-200"></div>
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

<style src="../styles/tailwind.css"/>

<style scoped>
.bg-blue-gradient {
  background-image: linear-gradient(to bottom, #41bec8, #bcf9f1);
}
</style>
