import Ember from 'ember';

export default Ember.Controller.extend({
  actions: {
    authenticate: function() {
      var credentials = this.getProperties('identification', 'password'),
        authenticator = 'simple-auth-authenticator:jwt';
      this.get('session').authenticate(authenticator, credentials).then(this.onSucc.bind(this) , this.onFail.bind(this));
    },

  },
  errors: Ember.A([]),
  onSucc: function() {
    this.transitionToRoute('member.dashboard');
  },
  onFail: function (rsp) {
    this.errors.addObject(rsp.error);
  }
});