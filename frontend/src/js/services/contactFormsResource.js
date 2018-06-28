(function() {
  "use strict";

  angular
    .module('micApp')
    .factory('ContactFormsResource', ['$resource', 'ENV', contactFormsResourceFactory]);

  function contactFormsResourceFactory($resource, ENV) {
    return $resource(ENV.ApiEndpoint + '/contact_forms/:id');
  }
}());
