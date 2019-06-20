<template>
  <li class="nav-item">
    <a :href="href">
      <slot></slot>
      <span class="caret ml-1 text-xs text-blue-bright font-bold">></span>
    </a>
  </li>
</template>

<script>
export default {
  props: {
    href: {
      type: String,
      required: true,
    },
  },
};
</script>

<style scoped>
.nav-item {
  @apply h-full;
}
.nav-item > a {
  @apply h-full px-6 mr-3 flex items-center no-underline text-black border-blue-bright;
  transition: border-width 200ms, padding-top 200ms;
}
.nav-item > a .caret {
  transition: transform 200ms;
}
.nav-item > a:hover {
  @apply border-b-8 pt-8px;
}
.nav-item > a:hover .caret {
  transform: rotate(90deg);
}
</style>
