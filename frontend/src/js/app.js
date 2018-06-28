(function () {
  'use strict';

  angular.module('micApp', [
      'ngRoute',
      'ngResource'
  ])
  .config([
      '$routeProvider',
      function($routeProvider) {
          $routeProvider
              .when('/', {
                  templateUrl: 'views/contact-form.html',
                  controller: 'ContactFromCtrl'
              });
      }
  ])
  .constant("ENV", {
    "ApiEndpoint": "http://api.example.com:3000/api/v1"
  });
}());
