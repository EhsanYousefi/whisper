import Ember from 'ember';

export default Ember.Controller.extend({
  actions: {
    register: function() {

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
  onSucc: function() {
    console.log('register Success');
  },
});
