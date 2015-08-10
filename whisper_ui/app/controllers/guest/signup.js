import Ember from 'ember';

export default Ember.Controller.extend({
  actions: {
    register: function() {

      var user = this.store.createRecord('user', {
        userName: this.getWithDefault('userName'),
        email: this.getWithDefault('email'),
        password: this.getWithDefault('password'),
        passwordConfirmation: this.getWithDefault('passwordConfirmation'),
        firstName: this.getWithDefault('firstName'),
        lastName: this.getWithDefault('lastName')
      });

      user.save().then(this.onSucc.bind(this), this.onFail.bind(this));
    }
  },

  onSucc: function() {
    var identification = this.getWithDefault('userName');
    var password = this.getWithDefault('password');
    var credentials = { identification: identification, password: password };
    var authenticator = 'simple-auth-authenticator:jwt';

    this.get('session').authenticate(authenticator, credentials);
  },

  onFail: function(err) {
    this.set('errors', err);
  },
});
