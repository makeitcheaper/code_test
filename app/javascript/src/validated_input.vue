<template>
  <div class="pb-3">
    <input class="w-full h-10 font-bold px-3 rounded-lg bg-gray-100 border border-black" name="name" :type="text" :placeholder="placeholder" pattern=".+\s.+" maxlength="100" :value="value" @input="fireInput"/>
    <ul class="bg-red-500 text-white px-5">
      <li v-for="error in errors">
        {{ error }}
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  props: {
    value: {
      type: String,
      required: true,
    },

    errors: {
      type: Array,
      required: true,
    },

    placeholder: {
      type: String,
      required: false,
      default: '',
    },
  },

  methods: {
    fireInput({ target }) {
      this.$emit('input', target.value);
    },
  },
};
</script>
