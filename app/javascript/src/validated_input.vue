<template>
  <div class="pb-3">
    <input class="w-full h-10 font-bold px-3 rounded-lg bg-gray-100 border border-black" :name="name" :type="type" :placeholder="placeholder" :required="required" :pattern="pattern" :value="value" @input="input"/>
    <ul class="bg-red-500 text-white px-5" v-if="isDirty">
      <li><slot class v-if="!validationErrors.typeMismatch && validationErrors.patternMismatch" name="patternMismatch"></slot></li>
      <li><slot class v-if="validationErrors.typeMismatch" name="typeMismatch"></slot></li>
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
      type: Object,
      required: true,
    },

    type: {
      type: String,
      required: false,
      default: 'text',
    },

    name: {
      type: String,
      required: true,
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
      type: Number,
      required: false,
      default: Infinity,
    },
  },

  data() {
    return {
      validity: {},
      isDirty: false,
    };
  },

  computed: {
    isMaxlength() {
      return this.value && this.value.length > this.maxlength;
    },

    validationErrors() {
      return Object.assign({}, this.validity, this.errors);
    },
  },

  methods: {
    input({ target }) {
      if (!this.isDirty) this.isDirty = true;

      const validity = {};
      for (let error in target.validity) {
        validity[error] = target.validity[error];
      }
      this.validity = validity;

      this.$emit('input', target.value);
    },
  },
};
</script>
