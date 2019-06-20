<template>
  <form novalidate="true" @submit.prevent="submit">
    <div>
      <input class="w-full h-10 font-bold px-5 mt-2" name="name" type="text" placeholder="Your full name" pattern=".+\s.+" maxlength="100"/>
      <ul class="bg-red-500 text-white px-5">
        <li v-for="error in errors.name">
          {{ error }}
        </li>
      </ul>
    </div>

    <input class="input" type="text" placeholder="Your business name" maxlength="100"/>

    <input class="input" type="email" placeholder="Your email address" maxlength="13"/>

    <input class="input" type="tel" placeholder="Your telephone number" maxlength="80"/>

    <button type="submit">Create</button>
  </form>
</template>

<script>
export default {
  data() {
    return {
      errors: {
        name: [],
        business_name: [],
        email: [],
        telephone_number: [],
      }
    }
  },

  methods: {
    submit() {
      this.errors.name.push('broked!');
    },
  },
};
</script>
