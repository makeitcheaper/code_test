(function () {
  'use strict';

  angular
    .module('micApp')
    .controller('ContactFromCtrl', ContactFromCtrl);

  ContactFromCtrl.$inject = ['$scope', '$http', 'ContactFormsResource', '$window', '$sce'];

  function ContactFromCtrl($scope, $http, ContactFormsResource, $window, $sce) {
    $scope.newContact = {};
    $scope.message = '';
    $scope.errors = [];
    $scope.resetForm = null;

    $scope.submit = function(isValid) {
      var name = $scope.newContact.name;

      if (isValid) {
        ContactFormsResource.save({ contact_form: $scope.newContact }, function(resp, headers) {
          $scope.message = '';
          $scope.errors = [];
          $scope.resetForm($scope.contactForm);
          popupMsg(name);
        }, function(reason) {
          var data = reason.data;
          if (angular.isDefined(data)) {
            $scope.message = data.message;
            $scope.errors = data.errors;
          }
        });
      }
    };

    $scope.resetForm = function(form) {
      $scope.newContact = {};
      $scope.contactForm.$setPristine();
    };

    function popupMsg(name) {
      var msg = '<h4>Hello ' + 
        name + 
        ',</h4>We received you contact request. We wil get back to you as soon as possible. Thank you!';
      vex.defaultOptions.className = 'vex-theme-wireframe';
      vex.dialog.alert({ unsafeMessage: msg });
    }
  }
}());
