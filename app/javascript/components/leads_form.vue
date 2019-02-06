<template>
  <form v-bind:action="action" method="post" autocomplete="on">
    <input type="hidden" v-bind:name="csrfParam" v-bind:value="csrfToken">
    <label for="lead[name]">{{ fullNameLabel }}</label>
    <input type="text" name="lead[name]" maxlength="100" required>
    <label for="lead[business_name]"> {{ businessNameLabel }}</label>
    <input type="text" name="lead[business_name]" maxlength="100" required>
    <label for="lead[email]">{{ emailLabel }}</label>
    <input type="email" name="lead[email]" maxlength="80" required>
    <label for="lead[telephone_number]">{{ telephoneNumberLabel }}</label>
    <input type="tel" name="lead[telephone_number]" maxlength="13" required>
    <label for="lead[notes]">{{ notesLabel }}</label>
    <textarea name="lead[notes]" maxlength="255"></textarea>
    <input type="submit" v-bind:value="submit">
  </form>
</template>

<script>
export default {
  computed: {
    csrfParam: () => document.querySelector('meta[name="csrf-param"]').getAttribute('content'),
    csrfToken: () => document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
    action: () => Routes.leads_path(),
    fullNameLabel: () => I18n.t('js.full_name'),
    businessNameLabel: () => I18n.t('js.business_name'),
    emailLabel: () => I18n.t('js.email'),
    telephoneNumberLabel: () => I18n.t('js.telephone_number'),
    notesLabel: () => I18n.t('js.notes'),
    submit: () => I18n.t('js.submit')
  }
}
</script>

<style scoped>
  form {
    --border-color: rgb(52, 48, 207);
    --background-color: rgba(52, 49, 207, 0.05);
    display: block;
    max-width: 10cm;
    margin-top: 2em;
    margin-left: auto;
    margin-right: auto;
    background: linear-gradient(-0.5turn, var(--background-color), rgba(255, 255, 255, 1));
    border: 0.4em var(--border-color) solid;
    border-radius: 1em;
    font-size: 12pt;
    padding: 2em;
    box-shadow: 0.5em 0.5em 1em;
  }

  label {
    display: block;
    margin-top: 1em;
    margin-bottom: 0.4em;
  }

  input, textarea {
    display: block;
    width: 100%;
    margin-top: 0.4em;
    margin-bottom: 1em;
  }

  input[type="submit"] {
    margin-top: 2em;
  }
</style>

