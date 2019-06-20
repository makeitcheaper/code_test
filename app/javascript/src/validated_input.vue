<template>
  <div class="pb-3">
    <input class="w-full h-10 font-bold px-3 rounded-lg bg-gray-100 border border-black" name="name" :type="type" :placeholder="placeholder" :required="required" :pattern="pattern" :value="value" @input="input"/>
    <ul class="bg-red-500 text-white px-5" v-if="isDirty">
      <li><slot class v-if="!validity.typeMismatch && validity.patternMismatch" name="patternMismatch"></slot></li>
      <li><slot class v-if="validity.typeMismatch" name="typeMismatch"></slot></li>
      <li><slot v-if="value && value.length > maxlength" name="tooLong" :maxlength="maxlength"></slot></li>
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

    type: {
      type: String,
      required: false,
      default: 'text',
    },

    placeholder: {
      type: String,
      required: false,
      default: '',
    },

    required: {
      type: Boolean,
      required: true,
      default: false,
    },

    pattern: {
      type: String,
      required: false,
      default: undefined,
    },

    maxlength: {
      type: String,
      required: false,
      default: '',
    },
  },

  data() {
    return {
      validity: {},
      isDirty: false,
    };
  },

  methods: {
    input({ target }) {
      if (!this.isDirty) this.isDirty = true;

      this.validity = target.validity;

      this.$emit('input', target.value);
    },
  },
};
</script>
