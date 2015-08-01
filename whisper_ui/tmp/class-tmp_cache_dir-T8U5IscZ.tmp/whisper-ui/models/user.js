define('whisper-ui/models/user', ['exports', 'ember-data'], function (exports, DS) {

  'use strict';

  exports['default'] = DS['default'].Model.extend({
    userName: DS['default'].attr('string'),
    email: DS['default'].attr('string'),
    authToken: DS['default'].attr('string'),
    password: DS['default'].attr('string'),
    passwordConfirmation: DS['default'].attr('string'),
    firstName: DS['default'].attr('string'),
    lastName: DS['default'].attr('string')
  });

});