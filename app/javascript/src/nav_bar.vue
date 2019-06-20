<template>
  <div class="h-16 bg-white">
    <ul class="container h-full flex items-center">
      <li class="nav-item"><a href="#home">Home</a></li>
      <li class="nav-item"><a href="/create">Create</a></li>
    </ul>
  </div>
</template>

<style scoped>
.nav-item {
  @apply h-full;
}
.nav-item > a {
  @apply h-full px-6 mr-3 flex items-center no-underline text-black;
}
.nav-item > a:hover {
  @apply border-b-8 border-bright-blue pt-8px;
}
</style>
