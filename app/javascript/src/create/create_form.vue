<template>
  <form novalidate="true" class="bg-white mt-2 py-4 px-5 max-w-lg" @submit.prevent="submit">
    <div class="font-bond text-3xl text-center">
      Enter your details here
    </div>
    <div class="text-sm text-center mb-3">
      You complete the form. Good things happen.
    </div>
    <validated-input type="text" placeholder="Your full name" pattern=".+\s.+" maxlength="100" :errors="errors.name"/>

    <validated-input type="text" placeholder="Your business name" maxlength="100" :errors="errors.businessName"/>

    <validated-input type="email" placeholder="Your email address" maxlength="13" :errors="errors.email"/>

    <validated-input type="tel" placeholder="Your telephone number" maxlength="80" :errors="errors.telephoneNumber"/>

    <div class="pb-3 text-xs text-center">By submitting your details you agree to reviewing this code test.</div>

    <button type="submit" class="w-full h-10 bg-red-700 rounded-full text-white font-bold">Create</button>
  </form>
</template>

<script>
import ValidatedInput from '../validated_input.vue';

export default {
  components: {
    ValidatedInput,
  },

  data() {
    return {
      errors: {
        name: [],
        businessName: [],
        email: [],
        telephoneNumber: [],
      }
    }
  },

  methods: {
    submit() {
      this.errors.name.push('broked!');
      this.errors.businessName.push('broked!');
      this.errors.email.push('broked!');
      this.errors.telephoneNumber.push('broked!');
    },
  },
};
</script>
