define('whisper-ui/controllers/signup', ['exports', 'ember'], function (exports, Ember) {

  'use strict';

  exports['default'] = Ember['default'].Controller.extend({
    actions: {
      register: function register() {

        var user = this.store.createRecord('user', {
          userName: this.getWithDefault('userName'),
          email: this.getWithDefault('email'),
          password: this.getWithDefault('password'),
          password_confirmation: this.getWithDefault('passwrodConfirmation'),
          firstName: this.getWithDefault('firstName'),
          lastName: this.getWithDefault('lastName')
        });

        user.save().then(this.onSucc);
        window.err = user.errors;
      }
    },
    onSucc: function onSucc() {
      console.log('register Success');
    }
  });

});