<template>
  <div class="h-16 bg-white hidden md:block">
    <ul class="container h-full flex items-center">
      <nav-item href="#home">Home</nav-item>
      <nav-item href="/create">Create</nav-item>
    </ul>
  </div>
</template>

<script>
import NavItem from './item.vue';

export default {
  components: {
    NavItem,
  },
};
</script>
