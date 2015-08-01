import Ember from 'ember';

export default Ember.Controller.extend({
  actions: {
    authenticate: function authenticate() {
      var credentials = this.getProperties('identification', 'password'),
          authenticator = 'simple-auth-authenticator:jwt';
      this.get('session').authenticate(authenticator, credentials).then(this.onSucc, this.onFail.bind(this));
    }
  },
  errors: Ember.A([]),
  onSucc: function onSucc(rsp) {
    console.log('Login Success');
  },
  onFail: function onFail(rsp) {
    this.errors.addObject(rsp.error);
  }
});