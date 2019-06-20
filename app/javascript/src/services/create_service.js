import BaseService from "./base_service.js";

const CreateService = {
  client: BaseService,

  errorMap: {
    present: "valueMissing",
    blank: "valueMissing",
    format: "patternMismatch"
  },

  parseKey(key) {
    return key.replace(/_\w/, match => match.toUpperCase().substring(1));
  },

  parseErrors(errors) {
    return errors.reduce((errors, error) => {
      const [_, key, err] = error.match(
        /Field\s'(.+?)'.+(blank|present|format)/
      );
      const parsedKey = this.parseKey(key);

      if (!errors[parsedKey]) errors[parsedKey] = {};

      errors[parsedKey][this.errorMap[err]] = true;

      return errors;
    }, {});
  },

  create({ name, businessName, email, telephoneNumber }) {
    // return Promise.reject({status: 500});

    // return Promise.reject({ status: 400, data: { errors: this.parseErrors([
    //  "Field 'name' isn't present",
    // "Field 'name' is blank",
    // "Field 'name' wrong format, 'name' must be composed with 2 separated words (space between)",
    // "Field 'business_name' isn't present",
    // "Field 'business_name' is blank",
    // "Field 'business_name' wrong format: 100 chars max",
    // "Field 'telephone_number' isn't present",
    // "Field 'telephone_number' is blank",
    // "Field 'telephone_number' wrong format (must contain have valid phone number with 11 numbers. string max 13 chars)",
    // "Field 'email' isn't present",
    // "Field 'email' is blank",
    // "Field 'email' wrong format",
    // ]) } })

    // return Promise.resolve({status: 200, data: { message: 'Enqueue success' }});

    return this.client
      .post("/create", {
        name,
        business_name: businessName,
        email: email,
        telephone_number: telephoneNumber
      })
      .then(({ data }) => data)
      .catch(({ response }) => {
        if (response.status === 400) {
          response.data.errors = this.parseErrors(response);
          return response;
        } else {
          return response;
        }
      });
  }
};

export default CreateService;
