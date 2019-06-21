<template>
  <form ref="form" novalidate="true" class="bg-white mt-2 py-4 px-5 max-w-lg mx-auto md:mx-0 qa-form" @submit.prevent="submit" @input="checkValidity">
    <div class="font-bond text-3xl text-center">
      Enter your details here
    </div>
    <div class="text-sm text-center mb-3">
      You complete the form. Good things happen.
    </div>

    <validated-input type="text" name="name" placeholder="Your full name" pattern=".+\s.+" :maxlength="100" v-model="payload.name" :errors="errors.name" :required="true">
      <template #patternMismatch>
        Please provide your first <strong>and</strong> last name. There should be a space between them!
      </template>
      <template #tooLong="{ maxlength }">
        Your name must be under {{ maxlength }} characters, you can leave out your middle name.
      </template>
    </validated-input>

    <validated-input type="text" name="businessName" placeholder="Your business name" :maxlength="100" v-model="payload.businessName" :errors="errors.businessName" :required="true">
      <template #patternMismatch>
        Please provide a business name.
      </template>
      <template #tooLong="{ maxlength }">
        Please provide a trading name for your business that is under {{ maxlength }} characters.
      </template>
    </validated-input>

    <validated-input type="email" name="email" placeholder="Your email address" :maxlength="80" pattern=".+@.+\..+" v-model="payload.email" :errors="errors.email" :required="true">
      <template #typeMismatch>
        Please provide a valid email address.
      </template>
      <template #patternMismatch>
        Please provide an email address with a fully qualified domain name.
      </template>
      <template #tooLong="{ maxlength }">
        Your email address should be less than {{ maxlength }} characters long, sorry!
      </template>
    </validated-input>

    <validated-input type="tel" name="telephoneNumber" placeholder="Your telephone number" :maxlength="13" pattern="^(\+44|0)\d{10}" v-model="payload.telephoneNumber" :errors="errors.telephoneNumber" :required="true">
      <template #typeMismatch>
        Please provide a valid telephone number.
      </template>
      <template #patternMismatch>
        You should provide a <strong>UK</strong> telephone number, without spaces or brackets. <i>+44 is optional.</i>
      </template>
      <template #tooLong="{ maxlength }">
        A valid phone number should be no more than {{ maxlength }} characters. Remove any spaces and parentheses.
      </template>
    </validated-input>

    <div class="pb-3 text-xs text-center">By submitting your details you agree to reviewing this code test.</div>

    <button type="submit" class="w-full h-10 rounded-full text-white font-bold submit-button qa-submit" :class="submitClass" :disabled="!isValid">{{ submitText }}</button>
  </form>
</template>

<script>
import ValidatedInput from '../validated_input.vue';
import CreateService from '../services/create_service.js';

const DEFAULT_SUBMIT_TEXT = 'Create';

export default {
  components: {
    ValidatedInput,
  },

  data() {
    return {
      isValid: false,

      status: '',

      payload: {
        name: '',
        businessName: '',
        email: '',
        telephoneNumber: '',
      },

      errors: {
        name: {},
        businessName: {},
        email: {},
        telephoneNumber: {},
      }
    }
  },

  computed: {
    submitClass() {
      switch (this.status) {
        case 'loading':
          return 'bg-blue-300';
        case 'failed':
          return 'bg-red-900';
        case 'success':
          return 'bg-green-700';
        default:
          return 'bg-red-500';
      }
    },

    submitText() {
      switch (this.status) {
        case 'loading':
          return 'Creating...';
        case 'failed':
          return 'Failed!';
        case 'success':
          return 'Success!';
        default:
          return 'Create';
      }
    },
  },

  methods: {
    checkValidity() {
      this.status = '';
      this.isValid = this.$refs.form.checkValidity();
    },

    submit() {
      if (!this.isValid) return;

      this.status = 'loading';

      CreateService.create(this.payload)
        .then(({ data }) => {
          this.status = 'success';
          this.payload = {};
        }).catch(({ status, data }) => {
          this.status = 'failed';

          if (status === 400) {
            this.errors = data.errors;
          }
        });
    },
  },
};
</script>

<style scoped>
.submit-button:disabled {
  @apply opacity-50 cursor-not-allowed;
}
</style>
