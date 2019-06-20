<template>
  <div class="h-20 px-10 bg-white border-b border-black">
    <div class="container h-full flex justify-between items-center">
      <span class="text-3xl">Brand Name</span>

      <div class="h-full flex items-center">
        <span>Want to contact us?</span>
        <div class="inline-block px-4">
          <div class="text-red-500 text-xl font-extrabold">0800 000 0000</div>
          <div class="text-xs text-right font-bold">Any time, any day!</div>
        </div>

        <div class="top-bar-button-border h-full">
          <a href="#settings" class="h-full px-6 flex items-center hover:no-underline hover:text-black">Settings</a>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.top-bar-button-border {
  @apply border-t-8 border-l border-r pb-8px;
  border-color: black;
  border-top-color: theme('colors.blue-bright');
}
</style>
